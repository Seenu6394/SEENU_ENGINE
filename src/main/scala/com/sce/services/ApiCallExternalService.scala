package com.sce.services

import akka.actor.ActorSystem
import akka.event.LoggingAdapter

import com.google.inject.{ Inject, Singleton }
import com.typesafe.config.Config
import spray.json._
import com.sce.models._
import com.sce.models._

import scala.concurrent.Future
import com.google.inject.name.Named
import com.sce.dao._

import com.sce.utils.AppConf._
import com.sce.utils.AppUtils.system
import com.sce.utils.AppUtils.fm
import com.sce.models.NLPStrings
import com.sce.utils._
import scala.slick.driver.JdbcProfile
import com.sce.models.NLPStrings._
import com.sce.models.NLPErrorCodes._
import com.sce.exception.BCActionConfException
import scalaj.http.Http
import scalaj.http.HttpRequest
import scalaj.http.MultiPart
import scalaj.http.HttpResponse
import java.nio.file.{ Path, Paths, Files }
import akka.event.{ Logging }
import com.sce.utils.AppUtils._
import scala.io.Source
import com.sce.exception.BCActionConfException
import com.sce.models.NLPRegexs._
import scala.slick.jdbc.JdbcBackend

object ApiCallExternalService extends NlpJsonSupport with Profile with DomainComponent {

  import system.dispatcher

  override val profile: JdbcProfile = SlickDBDriver.getDriver
  val db = new DBConnection(profile).dbObject()
  val imalLogs = IMALLogs.IMALLogs
  val logger = Logging(system, this.getClass)

  val actionTbl = ActionTable.ActionTable
  val actionExtnTbl = ActionExtn.ActionExtn
  val actionLog = ActionLog.ActionLog
  val intentResponse = Response.Response
  val userMapping = UserMapping.UserMapping
  val keywordTable = KeywordTable.KeywordTable
  val intentTable = IntentTable.IntentTable
  val entityQuestions = EntityQuestions.EntityQuestions
  val response = Response.Response
  val entityRecord = Entity.Entity
  val entityType = EntityType.EntityType
  val actionErrorResponse = ActionErrorResponse.ActionErrorResponse
  val errorResponseTbl = ErrorResponse.ErrorResponse
  val knowledgeUnit = KnowledgeUnit.KnowledgeUnit
  val conversationTbl = Conversation.Conversation
  val confirmTbl = Confirm.Confirm
  val localeTbl = Locale.Locale
  val intentExtnTbl = IntentExtn.IntentExtn
  val intentTbl = IntentTable.IntentTable
  val intentMappingTbl = IntentMapping.IntentMapping
  val conversationCacheTbl = ConversationCache.ConversationCache
  val conversationPointerTbl = ConversationPointer.ConversationPointer
  val workFlowSequenceTbl = WorkFlowSequence.WorkFlowSequence

  val imSessionDao = IMSessionDao
  val actionNlpDao = ActionNlpDao
  val errorResponseDao = ErrorResponseDao
  val entityProcessingDao = EntityProcessingDao
  val conversationDao = ConversationDao
  val commonAPICallService = CommonAPICallService
  val kafkaService = KafkaService

  def callWorkflowAction(nlpActionObj: NlpActionConsumerObj) = db withSession { implicit session =>
    import profile.simple._

    var replyMsg = ""
    val msgEvent = nlpActionObj.identityDtls.msgEvent
    val userLang = msgEvent.platformDtls.userLang
    val actionID = nlpActionObj.identityDtls.actionId
    val sessionID = nlpActionObj.identityDtls.sessionID
    val intentID = nlpActionObj.identityDtls.intentID
    val entityID = nlpActionObj.identityDtls.entityID
    try {

      val convCacheRecs = conversationCacheTbl.filter(x => x.SessionID === sessionID).list
      val authCode = imSessionDao.getAccessCode(msgEvent.platformDtls.userID)
      val langActionRec = actionNlpDao.getActionForLang(actionID, userLang)
      logger.info("langActionRec: {}", langActionRec)
      if (langActionRec.nonEmpty) {
        val nlpReqBodyString = langActionRec.get.RequestBody.getOrElse("").parseJson.convertTo[NlpHttpReqObj]
        if (entityID.isEmpty) {
          logger.info("--------------------------------Calling Intent Action---------------------------------------")
          logger.info("nlpReqBodyString.service_type: {}", nlpReqBodyString.service_type)
          if (nlpReqBodyString.service_type == FORM_DATA) {

            if (nlpReqBodyString.req_body.req_body_params.nonEmpty) {

              getMultipartHttpClientRequest(convCacheRecs, langActionRec.get,
                nlpReqBodyString, intentID, sessionID, nlpActionObj)
            }
          } else if (nlpReqBodyString.service_type == X_WWW_FORM_URLENCODED) {

            if (nlpReqBodyString.req_body.req_body_params.nonEmpty) {

              getUrlEncodedHttpClientRequest(convCacheRecs, langActionRec.get,
                nlpReqBodyString, intentID, nlpActionObj)
            }
          } else {

            getJsonHttpClientRequest(convCacheRecs, langActionRec.get,
              nlpReqBodyString, intentID, nlpActionObj)
          }
        } else {
          logger.info("--------------------------------Calling Entity Action---------------------------------------")

          entityHttpClientRequest(convCacheRecs, langActionRec.get,
            nlpReqBodyString, intentID, nlpActionObj)
        }
      } else {
        throw new BCActionConfException(ACTION_CONF_EXCEPTION)
      }
    } catch {

      case bc: BCActionConfException =>

        val replyMsg = errorResponseDao.getErrorDescription(ACTION_CONF_EXCEPTION, userLang)
        entityProcessingDao.trmnteIntentConvWithMsg(sessionID, msgEvent, replyMsg)
      case e: Exception =>

        e.printStackTrace()
        entityProcessingDao.errorTerminateIntentConversation(sessionID, userLang, msgEvent)
    }
  }

  def getMultipartHttpClientRequest(convCacheRecs: List[TConversationCache], actionExtnRec: TActionExtn,
                                    nlpReqBodyString: NlpHttpReqObj, intentID: Long, sessionID: String, nlpActionObj: NlpActionConsumerObj)(implicit session: JdbcBackend#SessionDef) = {

    try {

      val msgEvent = nlpActionObj.identityDtls.msgEvent

      val reqUrl = actionNlpDao.rplceTextWithActionEntityValues(actionExtnRec.WebhookUrl, intentID, convCacheRecs)
      var httpClient = Http(reqUrl)
      val rawFormDataParameters = nlpReqBodyString.req_body.req_body_params.get.filter(x => x.importType == Some(TEXT))
      val rawMultipartParameters = nlpReqBodyString.req_body.req_body_params.get.filter(x => x.importType == Some(FILE))
      val formDataParams = rawFormDataParameters.map(x => (x.entitykey, actionNlpDao.rplceTextWithActionEntityValues(x.entityvalue, intentID, convCacheRecs)))
      val multipartParams = getEntityFilesForUserConv(sessionID, rawMultipartParameters)

      httpClient = withFormData(httpClient, multipartParams, formDataParams, Nil)
      val headers = nlpReqBodyString.headers

      if (nlpReqBodyString.headers.nonEmpty) {
        httpClient = withHeaders(httpClient, headers, msgEvent, convCacheRecs, intentID)
      }
      httpClient = withCallMethod(httpClient, actionExtnRec.CallMethod.getOrElse(""))

      commonAPICallService.getActionResponse(httpClient, nlpActionObj)

    } catch {
      case bc: BCActionConfException =>
        logger.info("Exception: {}", bc.getMessage)
        throw bc
      case e: Exception =>
        e.printStackTrace()
        throw new BCActionConfException(ACTION_CONF_EXCEPTION)
    }
  }

  def getEntityFilesForUserConv(sessionID: String, rawMultipartParameters: List[NlpFormReqbodyparams])(implicit session: JdbcBackend#SessionDef): List[MultiPart] = {

    import profile.simple._

    try {
      val entityPlaceHolders = ENTITY_PLACEHOLDER_REGEX.r
      val convID = conversationDao.getConversationID(sessionID)
      val attachmentsForCon = conversationDao.getAtcmtsForConvID(convID)
      var multipartObj: List[MultiPart] = Nil
      for (i <- 0 until rawMultipartParameters.length) {

        val entityIds = entityPlaceHolders.findAllMatchIn(rawMultipartParameters(i).entityvalue).map(x => x.toString.substring(2, x.toString.length - 2).toLong).toSet.toList
        for (j <- 0 until entityIds.length) {
          val entityAtcmts = attachmentsForCon.filter(x => x.EntityID == entityIds(j))

          multipartObj = multipartObj ::: entityAtcmts.map(x => getMultipartObj(rawMultipartParameters(i).entitykey, x.AttachmentName))
        }
      }
      multipartObj
    } catch {
      case bc: Exception =>
        throw bc;
      case e: Exception =>
        throw new BCActionConfException(ACTION_CONF_EXCEPTION)
    }

  }

  def getMultipartObj(key: String, filePath: String): MultiPart = {

    try {
      val path: Path = Paths.get(filePath)
      logger.info("path: {}", path)
      val contentType = Files.probeContentType(path)
      val fileName = path.getFileName().toString();

      scalaj.http.MultiPart(key, fileName, contentType, Files.readAllBytes(path))
    } catch {

      case e: Exception =>
        throw new BCActionConfException(ACTION_CONF_EXCEPTION)
    }

  }

  def replaceConstants(rawText: String, msgEvent: NlpReqCommonObj, sessionID: String)(implicit session: JdbcBackend#SessionDef): String = {

    var processedText = rawText

    val accessCode = IMSessionDao.getProjectAccessCode(msgEvent.platformDtls.userID, msgEvent.platformDtls.channelID.getOrElse(0L))
    processedText = processedText.replace("[ConversationID]", msgEvent.platformDtls.ExtnlConvID.getOrElse("")).replace("[AccessCode]", accessCode)

    processedText
  }

  def getUrlEncodedHttpClientRequest(convCacheRecs: List[TConversationCache], actionExtnRec: TActionExtn,
                                     nlpReqBodyString: NlpHttpReqObj, intentID: Long, nlpActionObj: NlpActionConsumerObj) = {

    try {

      val msgEvent = nlpActionObj.identityDtls.msgEvent
      val reqUrl = actionNlpDao.rplceTextWithActionEntityValues(actionExtnRec.WebhookUrl, intentID, convCacheRecs)
      var httpClient = Http(reqUrl)
      val rawParameters = nlpReqBodyString.req_body.req_body_params.get
      val formParams = rawParameters.map(x => (x.entitykey, actionNlpDao.rplceTextWithActionEntityValues(x.entityvalue, intentID, convCacheRecs)))
      httpClient = withFormData(httpClient, Nil, Nil, formParams)
      val headers = nlpReqBodyString.headers

      if (nlpReqBodyString.headers.nonEmpty) {
        httpClient = withHeaders(httpClient, headers, msgEvent, convCacheRecs, intentID)
      }
      httpClient = withCallMethod(httpClient, actionExtnRec.CallMethod.getOrElse(""))

      commonAPICallService.getActionResponse(httpClient, nlpActionObj)
    } catch {
      case bc: BCActionConfException =>
        logger.info("Exception: {}", bc.getMessage)
        throw bc
      case e: Exception =>
        e.printStackTrace()
        throw new BCActionConfException(ACTION_CONF_EXCEPTION)
    }
  }

  def entityHttpClientRequest(convCacheRecs: List[TConversationCache], actionExtnRec: TActionExtn,
                              nlpReqBodyString: NlpHttpReqObj, intentID: Long, nlpActionObj: NlpActionConsumerObj)(implicit session: JdbcBackend#SessionDef) = {

    import profile.simple._

    try {

      val actionRec = actionTbl.filter(x => x.ActionId === actionExtnRec.ActionID).first
      val msgEvent = nlpActionObj.identityDtls.msgEvent
      val userLang = nlpActionObj.identityDtls.msgEvent.platformDtls.userLang
      val sessionID = nlpActionObj.identityDtls.sessionID
      val reqUrl = actionNlpDao.rplceTextWithActionEntityValues(actionExtnRec.WebhookUrl, intentID, convCacheRecs)
      var httpClient = Http(reqUrl)
      val reqBody = actionNlpDao.rplceTextWithActionEntityValues(nlpReqBodyString.req_body.request_string.getOrElse(""), intentID, convCacheRecs)
      if (actionExtnRec.CallMethod.getOrElse("") != REST_GET) {
        httpClient = httpClient.postData(reqBody)
        httpClient = withCallMethod(httpClient, actionExtnRec.CallMethod.getOrElse(""))
      }

      val headers = nlpReqBodyString.headers
      if (nlpReqBodyString.headers.nonEmpty) {
        httpClient = withHeaders(httpClient, headers, msgEvent, convCacheRecs, intentID)
      }

      commonAPICallService.getActionResponse(httpClient, nlpActionObj)

    } catch {
      case bc: BCActionConfException =>
        logger.info("Exception: {}", bc.getMessage)
        throw bc
      case e: Exception =>
        e.printStackTrace()
        throw new BCActionConfException(ACTION_CONF_EXCEPTION)
    }
  }

  def getJsonHttpClientRequest(convCacheRecs: List[TConversationCache], actionExtnRec: TActionExtn,
                               nlpReqBodyString: NlpHttpReqObj, intentID: Long, nlpActionObj: NlpActionConsumerObj)(implicit session: JdbcBackend#SessionDef) = {

    import profile.simple._

    try {

      val actionRec = actionTbl.filter(x => x.ActionId === actionExtnRec.ActionID).first
      val msgEvent = nlpActionObj.identityDtls.msgEvent
      val userLang = nlpActionObj.identityDtls.msgEvent.platformDtls.userLang
      val sessionID = nlpActionObj.identityDtls.sessionID
      var reqUrl = actionNlpDao.rplceTextWithActionEntityValues(actionExtnRec.WebhookUrl, intentID, convCacheRecs)//replaceConstants(rawText: String, msgEvent: NlpReqCommonObj, sessionID: String)
      reqUrl = replaceConstants(reqUrl, msgEvent, sessionID)
      var httpClient = Http(reqUrl)
      var reqBody = actionNlpDao.rplceTextWithActionEntityValues(nlpReqBodyString.req_body.request_string.getOrElse(""), intentID, convCacheRecs)
      reqBody = replaceConstants(reqBody, msgEvent, sessionID)
      
      nlpActionObj.messageDtls.reqBody = Some(reqBody)
      logger.info("reqUrl: {}", reqUrl)
      logger.info("reqBody: {}", reqBody)

      if (actionExtnRec.CallMethod.getOrElse("") != REST_GET) {
        httpClient = httpClient.postData(reqBody)
        httpClient = withCallMethod(httpClient, actionExtnRec.CallMethod.getOrElse(""))
      }
      val headers = nlpReqBodyString.headers
      if (nlpReqBodyString.headers.nonEmpty) {
        httpClient = withHeaders(httpClient, headers, msgEvent, convCacheRecs, intentID)
      }

      val actionConfirmRec = actionNlpDao.getConfirmationRec(actionExtnRec.ActionID, userLang)

      val kuId = intentTbl.filter { x => x.IntentID === nlpActionObj.identityDtls.intentID }.map { x => x.KUID }.firstOption.getOrElse(0L)
      val spamEnable = knowledgeUnit.filter { x => x.KUID === kuId }.map { x => x.SpamEnable }.firstOption.getOrElse("")
      logger.info("spamEnable 	:		{}", spamEnable)
      var isActionCalled = false

      if (spamEnable == "Y") {
        isActionCalled = actionNlpDao.isActionCalledInInterval(msgEvent.platformDtls.userID, actionExtnRec.ActionID, reqBody, sessionID, userLang)
      }

      if (!isActionCalled) {
        if (actionConfirmRec.nonEmpty && actionConfirmRec.get.ConfirmationText != "") {

          val acRecord = actionConfirmRec.get
          logger.info("acRecord: {}", acRecord)

          if (msgEvent.msgDtls.msgTxtWithoutPunc == acRecord.ConfirmedOpt.toLowerCase()) {

            commonAPICallService.getActionResponse(httpClient, nlpActionObj)
          } else if (msgEvent.msgDtls.msgTxtWithoutPunc == acRecord.UnConfirmedOpt.toLowerCase()) {
            val terminateMessage = acRecord.TerminationText.getOrElse("")

            entityProcessingDao.trmnteIntentConvWithMsg(sessionID, msgEvent, terminateMessage)
          } else {

            val confrmMsg = actionNlpDao.rplceTextWithActionEntityValues(acRecord.ConfirmationText, intentID, convCacheRecs)
            actionNlpDao.sendConfirmationMsg(msgEvent, confrmMsg, sessionID, Some(intentID), acRecord.ConfirmedOpt, acRecord.UnConfirmedOpt)
            conversationPointerTbl.filter(x => x.PointerType === _CONFIRMATION
              && x.SessionID === sessionID).map(x => (x.PointerDesc, x.SourceID, x.isPointed)).update(Some(ACTION), Some(actionConfirmRec.get.ConfirmID), _Y)
          }
        } else {
          commonAPICallService.getActionResponse(httpClient, nlpActionObj)
        }
      } else {
        val replyMsg = errorResponseDao.getErrorDescription(actionRec.WarningMessage.getOrElse(ACTION_CALL_INTERVAL_ERRMSG), userLang)
        entityProcessingDao.trmnteIntentConvWithMsg(sessionID, msgEvent, replyMsg)
      }
    } catch {
      case bc: BCActionConfException =>
        logger.info("Exception: {}", bc.getMessage)
        throw bc
      case e: Exception =>
        e.printStackTrace()
        throw new BCActionConfException(ACTION_CONF_EXCEPTION)
    }
  }

  def withFormData(httpRequest: HttpRequest, multipartEntries: List[MultiPart], formDataParams: List[(String, String)], urlEncodedFormData: List[(String, String)]): HttpRequest = {

    var request = httpRequest

    if (multipartEntries.nonEmpty) {
      logger.info("multipartEntries: {}", multipartEntries)
      request = request.postMulti(multipartEntries: _*)
    }
    if (formDataParams.nonEmpty) {
      logger.info("formDataParams: {}", formDataParams)
      request = request.params(formDataParams)
    }
    if (urlEncodedFormData.nonEmpty) {
      logger.info("urlEncodedFormData: {}", urlEncodedFormData)
      request = request.postForm(urlEncodedFormData)
    }
    request
  }

  def withHeaders(httpRequest: HttpRequest, headers: List[NlpReqHeaderParams], msgEvent: NlpReqCommonObj, convCacheRecs: List[TConversationCache], intentID: Long): HttpRequest = {

    var request = httpRequest
    var reqHeaders = scala.collection.mutable.Map[String, String]()

    for (i <- 0 until headers.length) {

      if (headers(i).header_key == AUTHORIZATION) {

        val accessToken = imSessionDao.getAccessToken

        logger.info("accessToken: {}", accessToken)
        if (accessToken.nonEmpty) {
          val bearer = BEARER + accessToken.get
          reqHeaders += (AUTHORIZATION -> bearer)
        }
      } else {
        reqHeaders += (headers(i).header_key -> actionNlpDao.rplceTextWithActionEntityValues(headers(i).header_value, intentID, convCacheRecs))
      }
    }

    logger.info("reqHeaders: {}", reqHeaders)
    if (reqHeaders.nonEmpty) {
      request = request.headers(reqHeaders.toMap)
    }
    request
  }

  def withCallMethod(httpRequest: HttpRequest, callMethod: String): HttpRequest = {
    logger.info("callMethod: {}", callMethod)
    httpRequest.method(callMethod)
  }

}