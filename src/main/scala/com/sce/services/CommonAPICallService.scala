package com.sce.services

import akka.actor.ActorSystem
import akka.event.LoggingAdapter
import akka.http.scaladsl.Http
import akka.http.scaladsl.marshalling.Marshal
import akka.http.scaladsl.model._
import akka.http.scaladsl.unmarshalling.Unmarshal
import akka.stream.Materializer
import com.google.inject.{ Inject, Singleton }
import com.typesafe.config.Config
import com.typesafe.config.ConfigFactory
import spray.json._
import com.sce.models._
import com.sce.dao._
import com.sce.utils._

import scala.concurrent.Promise
import scala.concurrent.{ Await, Future }
import scala.concurrent.duration._
import akka.http.scaladsl.model.headers.{ Authorization, OAuth2BearerToken, Cookie }
import scala.io.Source
import com.sce.models.NlpActionConsumerObj
import com.jayway.jsonpath.JsonPath
import java.util.concurrent.TimeoutException
import scala.util.{ Failure, Success }
import com.google.inject.name.Named

import com.sce.utils.AppConf._
import com.sce.utils.AppUtils.system
import com.sce.utils.AppUtils.fm

import java.io.File
import java.nio.file.{ Path, Paths, Files }
import com.sce.models.NLPErrorCodes._
import akka.dispatch.OnSuccess
import akka.dispatch.OnFailure
import com.sce.exception.BCActionFailureException
import akka.event.{ Logging }

object CommonAPICallService extends NLGJsonSupport {

  import system.dispatcher

  val http = Http()
  val logger = Logging(system, this.getClass)
  val ACTION_SEND = config.getString("ACTION_SEND")

  def getActionResponse(httpRequest: scalaj.http.HttpRequest, nlpActionObject: NlpActionConsumerObj) = {

    val futureHttpResponse = sendHttpRequest(httpRequest, nlpActionObject)
    futureHttpResponse.onComplete {

      case Success(value) =>
      logger.info("-------------------------------------------------Action Response:-------------------------------------------------: \n"+value.body)
        KafkaService.sendActionMsgToKafkaProducer(ACTION_SEND, nlpActionObject.identityDtls.msgEvent.platformDtls.userID, "", nlpActionObject, value.body)
      case Failure(e) => e match {

        case e1: BCActionFailureException =>
          val replyMsg = ErrorResponseDao.getErrorDescription(ACTION_CONF_EXCEPTION, e1.getMessage)
          EntityProcessingDao.trmnteIntentConvWithMsg(nlpActionObject.identityDtls.sessionID, nlpActionObject.identityDtls.msgEvent, replyMsg)
        case e2: Exception =>

          EntityProcessingDao.errorTerminateIntentConversation(nlpActionObject.identityDtls.sessionID,nlpActionObject.identityDtls.msgEvent.platformDtls.userLang, nlpActionObject.identityDtls.msgEvent)
      }
    }
  }
  
  def sendHttpRequest(httpRequest: scalaj.http.HttpRequest, nlpActionObject: NlpActionConsumerObj): Future[scalaj.http.HttpResponse[String]] = Future {

      httpRequest.asString
   
  }
  
  def sendHttpRequest(httpRequest: scalaj.http.HttpRequest): scalaj.http.HttpResponse[String] =  {
    try {

     val httpResponse =  httpRequest.asString
     logger.info("httpResponse: {}", httpResponse)
     httpResponse
    } catch {
      case e: Exception =>
        throw new BCActionFailureException(ACTION_CALL_EXCEPTION)
    }
  }

}