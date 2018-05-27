
--CREATE DATABASE "SCS_DEV_TEST" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';


--ALTER DATABASE "SCS_DEV_TEST" OWNER TO postgres;

--\connect "SCS_DEV_TEST"



CREATE SEQUENCE public.actionextn_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



CREATE TABLE public.t_conversation (
    conversation_id bigint NOT NULL,
    intent_id bigint,
    created timestamp with time zone DEFAULT now(),
    session_id character varying,
    start_time character varying,
    end_time character varying
);



CREATE SEQUENCE public."tConversation_ConversationID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."tConversation_ConversationID_seq" OWNED BY public.t_conversation.conversation_id;



CREATE SEQUENCE public."tKRLog_KRLogID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;





CREATE SEQUENCE public."tUserRating_RatingID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




CREATE SEQUENCE public.t_a_error_response_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



CREATE TABLE public.t_a_error_response (
    error_id bigint DEFAULT nextval('public.t_a_error_response_seq'::regclass),
    action_id bigint,
    action_error_response character varying,
    created timestamp with time zone DEFAULT now(),
    locale_code character varying
);




CREATE SEQUENCE public.taction_actionid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



CREATE TABLE public.t_action (
    action_id bigint DEFAULT nextval('public.taction_actionid_seq'::regclass) NOT NULL,
    intent_id bigint,
    action_name character varying,
    kuid bigint,
    entity_id bigint,
    warning_message character varying,
    calling_interval bigint,
    global_identifier character varying(255),
    created character varying DEFAULT (now())::character varying,
    data_type character varying
);



CREATE TABLE public.t_action_authorization (
    action_authorization_id bigint NOT NULL,
    access_token_url character varying,
    created character varying DEFAULT (now())::character varying,
    access_token_req_body character varying,
    access_token_req_method character varying,
    access_token character varying,
    expiry_interval bigint,
    token_creation_time character varying,
    action_name character varying,
    user_access_code character varying
);



CREATE SEQUENCE public.t_action_authorization_action_authorization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE public.t_action_authorization_action_authorization_id_seq OWNED BY public.t_action_authorization.action_authorization_id;


CREATE TABLE public.t_action_extn (
    action_id bigint NOT NULL,
    webhook_url character varying NOT NULL,
    request_body character varying,
    call_method character varying NOT NULL,
    success_code character varying,
    error_code character varying,
    session_parameter character varying,
    created character varying DEFAULT (now())::character varying,
    id bigint DEFAULT nextval('public.actionextn_seq'::regclass) NOT NULL,
    locale_code character varying(255),
    response_path character varying
);




CREATE SEQUENCE public.t_action_log_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE TABLE public.t_action_log (
    action_log_id bigint DEFAULT nextval('public.t_action_log_seq'::regclass) NOT NULL,
    action_id bigint,
    intent_id bigint,
    webhook_url character varying,
    call_method character varying,
    request_body character varying,
    access_code character varying,
    result character varying,
    created character varying,
    entity_id bigint,
    user_id character varying,
    is_success character varying
);




CREATE SEQUENCE public.t_channel_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



CREATE TABLE public.t_channel (
    channel_id bigint DEFAULT nextval('public.t_channel_seq'::regclass) NOT NULL,
    chennel_name character varying,
    webhook_url character varying,
    protocol_type character varying,
    local_url character varying,
    port character varying,
    access_token character varying,
    created timestamp with time zone,
    project_id bigint,
    platform_id bigint,
    verify_token character varying,
    channel_source_id character varying
);




CREATE TABLE public.t_confirm (
    confirm_id bigint NOT NULL,
    confirmation_type character varying,
    confirmation_text character varying,
    confirmed_opt character varying,
    unconfirmed_opt character varying,
    locale_code character varying,
    created character varying DEFAULT (now())::character varying,
    termination_text character varying,
    action_id bigint,
    kuid bigint
);



CREATE SEQUENCE public.t_confirm_confirm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE public.t_confirm_confirm_id_seq OWNED BY public.t_confirm.confirm_id;


CREATE TABLE public.t_conversation_cache (
    conv_cache_id bigint NOT NULL,
    session_id character varying,
    intent_id bigint,
    cache_data character varying,
    fullfilled character varying,
    entry_type character varying,
    created character varying DEFAULT (now())::character varying,
    entry_id character varying,
    action_cache_data character varying
);



CREATE SEQUENCE public.t_conversation_cache_conv_cache_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE public.t_conversation_cache_conv_cache_id_seq OWNED BY public.t_conversation_cache.conv_cache_id;



CREATE TABLE public.t_conversation_pointer (
    conv_pointer_id bigint NOT NULL,
    session_id character varying,
    pointer_type character varying,
    pointer_desc character varying,
    source_id bigint,
    is_pointed character varying,
    temp_cache character varying,
    created character varying DEFAULT (now())::character varying
);



CREATE SEQUENCE public.t_conversation_pointer_conv_pointer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE public.t_conversation_pointer_conv_pointer_id_seq OWNED BY public.t_conversation_pointer.conv_pointer_id;




CREATE TABLE public.t_db_listing (
    list_id bigint NOT NULL,
    button_text character varying(255),
    image_url character varying(255),
    sub_title character varying(255),
    title character varying(255),
    selection_id bigint NOT NULL
);




CREATE SEQUENCE public.t_entity_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




CREATE TABLE public.t_entity (
    entity_id bigint DEFAULT nextval('public.t_entity_seq'::regclass) NOT NULL,
    entity_name character varying NOT NULL,
    example character varying,
    entity_type_code character varying NOT NULL,
    kuid bigint,
    created character varying DEFAULT (now())::character varying,
    required character varying(255),
    flag boolean,
    intent_id bigint,
    project_id bigint,
    global_identifier character varying,
    data_type character varying
);




CREATE SEQUENCE public.t_entity_question_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



CREATE TABLE public.t_entity_question (
    question_id bigint DEFAULT nextval('public.t_entity_question_seq'::regclass) NOT NULL,
    entity_id bigint NOT NULL,
    question character varying,
    created timestamp with time zone,
    kuid bigint,
    title character varying,
    button_text character varying,
    sub_title character varying,
    entity_query character varying,
    entity_example character varying,
    locale_code character varying NOT NULL,
    image_url character varying,
    example character varying(255)
);



CREATE TABLE public.t_entity_regex (
    entity_regex_id bigint NOT NULL,
    entity_id bigint,
    regex_id bigint,
    created character varying DEFAULT (now())::character varying
);



CREATE SEQUENCE public.t_entity_regex_entity_regex_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE public.t_entity_regex_entity_regex_id_seq OWNED BY public.t_entity_regex.entity_regex_id;




CREATE SEQUENCE public.t_entity_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



CREATE TABLE public.t_entity_type (
    entity_type_id bigint DEFAULT nextval('public.t_entity_type_seq'::regclass) NOT NULL,
    entity_type_code character varying NOT NULL,
    entity_type_name character varying,
    invalid_message character varying,
    created timestamp with time zone,
    kuid bigint,
    project_id character varying
);




CREATE TABLE public.t_error_response (
    id bigint NOT NULL,
    error_code character varying NOT NULL,
    error_response character varying,
    kuid bigint,
    created character varying DEFAULT (now())::character varying,
    action_id bigint,
    locale_code character varying NOT NULL,
    regex_id bigint
);




CREATE SEQUENCE public.t_error_response_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE public.t_error_response_id_seq OWNED BY public.t_error_response.id;



CREATE TABLE public.t_im_error_log (
    elog_id bigint NOT NULL,
    session_id character varying,
    message character varying,
    source character varying,
    intent_id character varying,
    conversation_id character varying,
    created timestamp with time zone
);




CREATE SEQUENCE public.t_im_error_log_elog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE public.t_im_error_log_elog_id_seq OWNED BY public.t_im_error_log.elog_id;


CREATE SEQUENCE public.t_im_session_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




CREATE TABLE public.t_im_session (
    session_id character varying,
    im_user_id character varying,
    created_at character varying,
    expired_at character varying,
    reason character varying,
    im_session_id bigint DEFAULT nextval('public.t_im_session_seq'::regclass) NOT NULL,
    channel_id bigint,
    project_id bigint
);




CREATE TABLE public.t_im_session_log (
    log_id bigint NOT NULL,
    session_id character varying,
    message character varying,
    source character varying,
    created timestamp with time zone DEFAULT now(),
    intent_id bigint,
    conversation_id bigint,
    message_status character varying(255),
    user_id bigint
);



CREATE SEQUENCE public.t_im_session_log_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE public.t_im_session_log_log_id_seq OWNED BY public.t_im_session_log.log_id;




CREATE SEQUENCE public.t_intent_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




CREATE TABLE public.t_intent (
    intent_id bigint DEFAULT nextval('public.t_intent_seq'::regclass) NOT NULL,
    intent_definition character varying NOT NULL,
    kuid bigint,
    created character varying DEFAULT (now())::character varying,
    flag character varying(255),
    project_id bigint,
    active_ind character varying(1) DEFAULT 'Y'::character varying,
    global_identifier character varying
);




CREATE SEQUENCE public.t_intent_extn_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



CREATE TABLE public.t_intent_extn (
    intent_id bigint NOT NULL,
    intent_name character varying NOT NULL,
    locale_code character varying NOT NULL,
    id bigint DEFAULT nextval('public.t_intent_extn_seq'::regclass) NOT NULL,
    flag boolean
);




CREATE SEQUENCE public.t_intent_mapping_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



CREATE TABLE public.t_intent_mapping (
    map_id bigint DEFAULT nextval('public.t_intent_mapping_seq'::regclass) NOT NULL,
    entry_type character varying(255) NOT NULL,
    kuid bigint NOT NULL,
    order_id bigint NOT NULL,
    required character varying(255) NOT NULL,
    intent_id bigint NOT NULL,
    workflow_id bigint NOT NULL,
    entry_id character varying
);



CREATE SEQUENCE public.t_keyword_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



CREATE TABLE public.t_keyword (
    keyword_id bigint DEFAULT nextval('public.t_keyword_seq'::regclass) NOT NULL,
    intent_id bigint,
    keyword character varying NOT NULL,
    polarity character varying NOT NULL,
    created character varying,
    locale_code character varying,
    project_id bigint,
    kuid bigint
);




CREATE TABLE public.t_kr_log (
    kr_log_id bigint DEFAULT nextval('public."tKRLog_KRLogID_seq"'::regclass) NOT NULL,
    im_session_log_id bigint,
    intent_id bigint,
    keyword_rate integer,
    created timestamp with time zone DEFAULT now()
);




CREATE SEQUENCE public.t_ku_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




CREATE TABLE public.t_ku (
    kuid bigint DEFAULT nextval('public.t_ku_seq'::regclass) NOT NULL,
    created timestamp with time zone DEFAULT now(),
    ku_name character varying(255),
    flag boolean,
    active_ind character varying(1),
    spam_enable character varying(1),
    project_id bigint,
    is_rankable character varying
);



CREATE TABLE public.t_language (
    language_id bigint NOT NULL,
    english boolean,
    arabic boolean
);



CREATE TABLE public.t_locale (
    locale_id bigint NOT NULL,
    locale_name character varying,
    locale_code character varying,
    locale_cnfrm_msg character varying,
    locale_error_msg character varying,
    intent_choice_msg character varying
);




CREATE SEQUENCE public.t_locale_locale_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE public.t_locale_locale_id_seq OWNED BY public.t_locale.locale_id;



CREATE SEQUENCE public.t_locale_unicodes_unicode_seq_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




CREATE TABLE public.t_locale_unicodes (
    unicode_seq_id bigint DEFAULT nextval('public.t_locale_unicodes_unicode_seq_id_seq'::regclass) NOT NULL,
    locale_code character varying,
    head_unicode bigint,
    tail_unicode bigint,
    head_num_unicode bigint,
    tail_num_unicode bigint,
    created character varying DEFAULT (now())::character varying
);




CREATE TABLE public.t_message (
    message_id bigint NOT NULL,
    message_code character varying,
    created character varying DEFAULT (now())::character varying,
    intent_id bigint
);




CREATE SEQUENCE public.t_message_message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE public.t_message_message_id_seq OWNED BY public.t_message.message_id;



CREATE TABLE public.t_platform (
    platform_id bigint NOT NULL,
    platform_name character varying NOT NULL,
    active_id character varying,
    created character varying DEFAULT (now())::character varying
);




CREATE SEQUENCE public.t_platform_platform_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE public.t_platform_platform_id_seq OWNED BY public.t_platform.platform_id;




CREATE TABLE public.t_project (
    project_id bigint NOT NULL,
    project_name character varying NOT NULL,
    active_id character varying NOT NULL,
    created character varying
);




CREATE TABLE public.t_project_keyword (
    project_keyword_id bigint NOT NULL,
    project_keyword character varying NOT NULL,
    project_keyword_type character varying,
    created character varying DEFAULT (now())::character varying,
    project_id bigint,
    locale_code character varying
);




CREATE SEQUENCE public.t_project_keyword_project_keyword_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE public.t_project_keyword_project_keyword_id_seq OWNED BY public.t_project_keyword.project_keyword_id;




CREATE TABLE public.t_project_locale (
    project_lang_id bigint NOT NULL,
    project_id bigint,
    locale_code character varying,
    active_ind character varying,
    created character varying DEFAULT (now())::character varying
);




CREATE SEQUENCE public.t_project_locale_project_lang_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE public.t_project_locale_project_lang_id_seq OWNED BY public.t_project_locale.project_lang_id;



CREATE SEQUENCE public.t_project_project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE public.t_project_project_id_seq OWNED BY public.t_project.project_id;




CREATE SEQUENCE public.t_regex_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




CREATE TABLE public.t_regex (
    regex_id bigint DEFAULT nextval('public.t_regex_seq'::regclass) NOT NULL,
    expression character varying NOT NULL,
    created timestamp with time zone DEFAULT now(),
    kuid bigint,
    regex_name character varying,
    error_code character varying(255),
    nm_message character varying(255)
);



CREATE SEQUENCE public.t_regex_extn_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



CREATE TABLE public.t_regex_extn (
    regex_id bigint,
    error_message character varying NOT NULL,
    locale_code character varying NOT NULL,
    id bigint DEFAULT nextval('public.t_regex_extn_seq'::regclass) NOT NULL
);




CREATE SEQUENCE public.t_response_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




CREATE TABLE public.t_response (
    response_id bigint DEFAULT nextval('public.t_response_seq'::regclass) NOT NULL,
    intent_id bigint,
    entity_id bigint,
    response character varying,
    created timestamp with time zone,
    kuid bigint,
    locale_code character varying,
    global_identifier character varying,
    regex_id character varying,
    action_id bigint,
    message_id bigint
);




CREATE TABLE public.t_selection_list (
    selection_id bigint NOT NULL,
    created timestamp without time zone,
    kuid bigint,
    list_name character varying(255)
);




CREATE TABLE public.t_session_record (
    intent_id bigint,
    parameter_name character varying,
    parameter_type character varying,
    session_id character varying,
    entity_id bigint,
    created timestamp with time zone DEFAULT now(),
    log_status character varying,
    flowchart_id bigint,
    flowchart_key bigint,
    entity_order bigint,
    cancel_intent character varying,
    confirmation_type character varying,
    user_language character varying,
    flag bigint
);




CREATE TABLE public.t_user_attachments (
    attachment_id bigint NOT NULL,
    im_log_id bigint,
    attachment_type character varying,
    attachment_name character varying,
    source_from character varying,
    created character varying DEFAULT (now())::character varying,
    entity_id bigint,
    is_deleted character varying,
    channel_id bigint
);



CREATE SEQUENCE public.t_user_attachments_attachment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE public.t_user_attachments_attachment_id_seq OWNED BY public.t_user_attachments.attachment_id;



CREATE TABLE public.t_user_locale (
    user_locale_id bigint NOT NULL,
    user_id character varying,
    locale_code character varying,
    created character varying DEFAULT (now())::character varying,
    channel_id bigint
);




CREATE SEQUENCE public.t_user_locale_user_locale_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



ALTER SEQUENCE public.t_user_locale_user_locale_id_seq OWNED BY public.t_user_locale.user_locale_id;




CREATE SEQUENCE public.t_user_login_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




CREATE TABLE public.t_user_login (
    id bigint DEFAULT nextval('public.t_user_login_seq'::regclass) NOT NULL,
    user_id bigint,
    loggedin_time character varying,
    login_status character varying,
    login_attempts bigint
);



CREATE TABLE public.t_user_mapping (
    mapping_id bigint NOT NULL,
    im_user_id character varying,
    backend_accesscode character varying,
    a_code_expiry character varying,
    created timestamp with time zone DEFAULT now(),
    channel_id bigint
);




CREATE SEQUENCE public.t_user_mapping_mapping_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE public.t_user_mapping_mapping_id_seq OWNED BY public.t_user_mapping.mapping_id;



CREATE TABLE public.t_user_rating (
    rating_id bigint DEFAULT nextval('public."tUserRating_RatingID_seq"'::regclass) NOT NULL,
    user_id character varying,
    im_session_log_id bigint,
    keywords character varying,
    intent_id bigint,
    session_id character varying,
    created timestamp with time zone DEFAULT now()
);




CREATE SEQUENCE public.t_workflow_workflow_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



CREATE TABLE public.t_workflow (
    workflow_id bigint DEFAULT nextval('public.t_workflow_workflow_id_seq'::regclass) NOT NULL,
    metadata character varying NOT NULL,
    created timestamp with time zone DEFAULT now(),
    workflow_name character varying,
    intent_id bigint,
    entity_id bigint,
    action_id bigint,
    active_ind character varying(1),
    kuid bigint
);




CREATE SEQUENCE public.t_workflow_sequence_workflow_sequence_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




CREATE TABLE public.t_workflow_sequence (
    workflow_sequence_id bigint DEFAULT nextval('public.t_workflow_sequence_workflow_sequence_id_seq'::regclass) NOT NULL,
    workflow_id bigint NOT NULL,
    entry_type character varying NOT NULL,
    entry_expression character varying NOT NULL,
    primary_dest_wrkflw_id bigint,
    secondary_dest_wrkflw_id bigint,
    intent_seq_id bigint,
    required character varying,
    terminal_type character varying,
    intent_id bigint,
    primary_dest_sequence_key character varying,
    workflow_sequence_key character varying,
    secondary_dest_sequence_key character varying,
    kuid bigint,
    intial_validation character varying,
    initial_validation character varying DEFAULT 'Y'::character varying
);




CREATE SEQUENCE public.tusers2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




CREATE TABLE public.user_details (
    user_id bigint NOT NULL,
    username character varying,
    first_name character varying,
    last_name character varying,
    gender character varying,
    password character varying,
    status bigint
);




CREATE TABLE public.user_roles (
    role_id bigint,
    user_role character varying
);



CREATE TABLE public.user_token (
    token_id bigint NOT NULL,
    enabled smallint,
    expirydate timestamp without time zone,
    token character varying(255),
    user_id bigint
);



CREATE TABLE public.users (
    user_id bigint DEFAULT nextval('public.tusers2_id_seq'::regclass) NOT NULL,
    username character varying(255) NOT NULL,
    enabled smallint,
    full_name character varying(255),
    password character varying(255) NOT NULL,
    role character varying(500),
    email character varying(255) NOT NULL,
    firstname character varying,
    lastname character varying,
    account_locked bigint
);




ALTER TABLE ONLY public.t_action_authorization ALTER COLUMN action_authorization_id SET DEFAULT nextval('public.t_action_authorization_action_authorization_id_seq'::regclass);




ALTER TABLE ONLY public.t_confirm ALTER COLUMN confirm_id SET DEFAULT nextval('public.t_confirm_confirm_id_seq'::regclass);




ALTER TABLE ONLY public.t_conversation ALTER COLUMN conversation_id SET DEFAULT nextval('public."tConversation_ConversationID_seq"'::regclass);




ALTER TABLE ONLY public.t_conversation_cache ALTER COLUMN conv_cache_id SET DEFAULT nextval('public.t_conversation_cache_conv_cache_id_seq'::regclass);



ALTER TABLE ONLY public.t_conversation_pointer ALTER COLUMN conv_pointer_id SET DEFAULT nextval('public.t_conversation_pointer_conv_pointer_id_seq'::regclass);



ALTER TABLE ONLY public.t_entity_regex ALTER COLUMN entity_regex_id SET DEFAULT nextval('public.t_entity_regex_entity_regex_id_seq'::regclass);



ALTER TABLE ONLY public.t_error_response ALTER COLUMN id SET DEFAULT nextval('public.t_error_response_id_seq'::regclass);



ALTER TABLE ONLY public.t_im_error_log ALTER COLUMN elog_id SET DEFAULT nextval('public.t_im_error_log_elog_id_seq'::regclass);



ALTER TABLE ONLY public.t_im_session_log ALTER COLUMN log_id SET DEFAULT nextval('public.t_im_session_log_log_id_seq'::regclass);



ALTER TABLE ONLY public.t_locale ALTER COLUMN locale_id SET DEFAULT nextval('public.t_locale_locale_id_seq'::regclass);




ALTER TABLE ONLY public.t_message ALTER COLUMN message_id SET DEFAULT nextval('public.t_message_message_id_seq'::regclass);



ALTER TABLE ONLY public.t_platform ALTER COLUMN platform_id SET DEFAULT nextval('public.t_platform_platform_id_seq'::regclass);




ALTER TABLE ONLY public.t_project ALTER COLUMN project_id SET DEFAULT nextval('public.t_project_project_id_seq'::regclass);




ALTER TABLE ONLY public.t_project_keyword ALTER COLUMN project_keyword_id SET DEFAULT nextval('public.t_project_keyword_project_keyword_id_seq'::regclass);




ALTER TABLE ONLY public.t_project_locale ALTER COLUMN project_lang_id SET DEFAULT nextval('public.t_project_locale_project_lang_id_seq'::regclass);




ALTER TABLE ONLY public.t_user_attachments ALTER COLUMN attachment_id SET DEFAULT nextval('public.t_user_attachments_attachment_id_seq'::regclass);




ALTER TABLE ONLY public.t_user_locale ALTER COLUMN user_locale_id SET DEFAULT nextval('public.t_user_locale_user_locale_id_seq'::regclass);



ALTER TABLE ONLY public.t_user_mapping ALTER COLUMN mapping_id SET DEFAULT nextval('public.t_user_mapping_mapping_id_seq'::regclass);






SELECT pg_catalog.setval('public.actionextn_seq', 1, true);



SELECT pg_catalog.setval('public."tConversation_ConversationID_seq"', 1, true);



SELECT pg_catalog.setval('public."tKRLog_KRLogID_seq"', 1, true);



SELECT pg_catalog.setval('public."tUserRating_RatingID_seq"', 1, false);



SELECT pg_catalog.setval('public.t_a_error_response_seq', 1, false);



SELECT pg_catalog.setval('public.t_action_authorization_action_authorization_id_seq', 1, true);



SELECT pg_catalog.setval('public.t_action_log_seq', 1, true);



SELECT pg_catalog.setval('public.t_channel_seq', 1, true);



SELECT pg_catalog.setval('public.t_confirm_confirm_id_seq', 1, true);


SELECT pg_catalog.setval('public.t_conversation_cache_conv_cache_id_seq', 1, true);


SELECT pg_catalog.setval('public.t_conversation_pointer_conv_pointer_id_seq', 1, true);


SELECT pg_catalog.setval('public.t_entity_question_seq', 1, false);



SELECT pg_catalog.setval('public.t_entity_regex_entity_regex_id_seq', 1, false);


SELECT pg_catalog.setval('public.t_entity_seq', 1, false);


SELECT pg_catalog.setval('public.t_entity_type_seq', 1, true);



SELECT pg_catalog.setval('public.t_error_response_id_seq', 1, true);

SELECT pg_catalog.setval('public.t_im_error_log_elog_id_seq', 1, false);


SELECT pg_catalog.setval('public.t_im_session_log_log_id_seq', 1, true);



SELECT pg_catalog.setval('public.t_im_session_seq', 1, true);



SELECT pg_catalog.setval('public.t_intent_extn_seq', 1, true);



SELECT pg_catalog.setval('public.t_intent_mapping_seq', 1, true);



SELECT pg_catalog.setval('public.t_intent_seq', 1, false);



SELECT pg_catalog.setval('public.t_keyword_seq', 1, true);



SELECT pg_catalog.setval('public.t_ku_seq', 1, true);


SELECT pg_catalog.setval('public.t_locale_locale_id_seq', 1, true);


SELECT pg_catalog.setval('public.t_locale_unicodes_unicode_seq_id_seq',1, true);



SELECT pg_catalog.setval('public.t_message_message_id_seq', 1, false);


SELECT pg_catalog.setval('public.t_platform_platform_id_seq', 1, false);



SELECT pg_catalog.setval('public.t_project_keyword_project_keyword_id_seq', 1, true);


SELECT pg_catalog.setval('public.t_project_locale_project_lang_id_seq', 1, false);



SELECT pg_catalog.setval('public.t_project_project_id_seq', 1, false);



SELECT pg_catalog.setval('public.t_regex_extn_seq', 1, true);



SELECT pg_catalog.setval('public.t_regex_seq', 1, true);



SELECT pg_catalog.setval('public.t_response_seq', 1, true);



SELECT pg_catalog.setval('public.t_user_attachments_attachment_id_seq', 1, true);


SELECT pg_catalog.setval('public.t_user_locale_user_locale_id_seq', 1, true);



SELECT pg_catalog.setval('public.t_user_login_seq', 1, true);



SELECT pg_catalog.setval('public.t_user_mapping_mapping_id_seq', 1, true);



SELECT pg_catalog.setval('public.t_workflow_sequence_workflow_sequence_id_seq', 1, true);



SELECT pg_catalog.setval('public.t_workflow_workflow_id_seq', 1, false);



SELECT pg_catalog.setval('public.taction_actionid_seq', 1, false);


SELECT pg_catalog.setval('public.tusers2_id_seq', 1, true);





--platform values

INSERT INTO public.t_platform ( platform_name, active_id, created) VALUES ( 'facebook', NULL, '2018-04-17 10:41:19.039416+04');
INSERT INTO public.t_platform ( platform_name, active_id, created) VALUES ( 'purist', NULL, '2018-04-17 10:41:32.708851+04');


--entity type values

INSERT INTO public.t_entity_type ( entity_type_code, entity_type_name, invalid_message, created, kuid, project_id) VALUES ( 'GEN', 'Generic', 'Enter valid message', '2018-01-10 10:53:38.21466+04', NULL, NULL);
INSERT INTO public.t_entity_type ( entity_type_code, entity_type_name, invalid_message, created, kuid, project_id) VALUES ( 'ATCMT', 'Upload File', 'Media Type Required', '2018-02-01 14:51:42.688833+04', NULL, NULL);
INSERT INTO public.t_entity_type ( entity_type_code, entity_type_name, invalid_message, created, kuid, project_id) VALUES ( 'ELS', 'ExternalService Listing', 'No Info Available', '2018-02-20 17:36:47.671523+04', NULL, NULL);
INSERT INTO public.t_entity_type ( entity_type_code, entity_type_name, invalid_message, created, kuid, project_id) VALUES ( 'EILS', 'External Image Listing', 'List is   not Proper', '2018-03-08 11:23:59.657468+04', NULL, NULL);
INSERT INTO public.t_entity_type ( entity_type_code, entity_type_name, invalid_message, created, kuid, project_id) VALUES ( 'EQRP', 'Quick Replies', 'List is   not Proper', '2018-03-08 11:24:52.253494+04', NULL, NULL);

--locale

INSERT INTO public.t_locale ( locale_name, locale_code, locale_cnfrm_msg, locale_error_msg, intent_choice_msg) VALUES ( 'English', 'en', 'Sure I can speak both languages, shall we carry on in English or Arabic?', 'Sorry I haven''t learnt this language yet, I think I''m good in عربى and English', 'which one do you want to perform?');
INSERT INTO public.t_locale ( locale_name, locale_code, locale_cnfrm_msg, locale_error_msg, intent_choice_msg) VALUES ( 'عربي', 'ar', 'أكيد أنا أجيد كلا اللغتين, هل نحول اللغة إلى الإنجليزية أو العربية', 'للأسف مازلت أفكر في تعلم هذه اللغة، في الوقت الحالي أعتقد أني قادر على التفاهم معك باللغة العربية أو الإنكليزية', 'أي واحد تريد أن تؤدي؟');

--locale unicodes

INSERT INTO public.t_locale_unicodes ( locale_code, head_unicode, tail_unicode, head_num_unicode, tail_num_unicode, created) VALUES ( 'en', 65, 90, NULL, NULL, '2018-01-17 11:09:39.733127+04');
INSERT INTO public.t_locale_unicodes ( locale_code, head_unicode, tail_unicode, head_num_unicode, tail_num_unicode, created) VALUES ( 'en', 48, 58, NULL, NULL, '2017-01-17 11:09:39.733127+04');
INSERT INTO public.t_locale_unicodes ( locale_code, head_unicode, tail_unicode, head_num_unicode, tail_num_unicode, created) VALUES ( 'en', 97, 122, NULL, NULL, '2018-01-17 10:15:02.674846+04');
INSERT INTO public.t_locale_unicodes ( locale_code, head_unicode, tail_unicode, head_num_unicode, tail_num_unicode, created) VALUES ( 'ar', 1536, 1791, 1632, 1641, '2018-01-17 10:15:51.980946+04');
 
--authorization values

INSERT INTO public.t_action_authorization ( access_token_url, created, access_token_req_body, access_token_req_method, access_token, expiry_interval, token_creation_time, action_name, user_access_code) VALUES ( 'http://10.10.10.212:7001/SCS_UPDATES/oauth/token', '2018-05-07 15:38:29.612581+04', '{
	"service_type": "X_URL_FORM_ENCODED",
	"headers": [{
		"header_key": "Content-Type",
		"header_value": "application/x-www-form-urlencoded"
	}, {
		"header_key": "Authorization",
		"header_value": "Basic Z21KSFJlMEJxQ1pMQThrT1F6QktQbW14d2pIRW91MVNacDNMYjZLMDozdXVjUndhZHFQUmNxYlVRTzNyRmVMUWVyemU4M1pHNG1ueUFGek1T"
	}],
	"req_body": {
		"req_body_params": [{
			"entitykey": "grant_type",
			"entityvalue": "client_credentials"
		}]
	}
}', 'POST', 'efeaa8d6-2fcd-4fab-8982-5f65c26b9276', NULL, '2018-05-08 17:07:08.582', NULL, 'K+u0K8R52vMZErhD4Yt4h50nvbFQA0QMOrUOE2PcMgw=');
 
 

--error responses



INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'BC_PLS_UPLOAD_FILE', 'Please upload a file.', NULL, '2018-01-31 10:08:02.941114+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_PLSWAIT_MSG', 'Please wait, while we process your request.', NULL, '2017-12-19 11:49:52.592463+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_LANG_NOT_FOUND', 'Sorry I haven''t learnt this language yet, I  think I''m good in   Arabic andEnglish', NULL, '2018-02-15 18:10:51.000683+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_INTENT_NOT_FOUND', 'sorry, I didn''t get that :(', NULL, '2017-08-10 17:22:23.80954+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_ENTITY_NOT_FOUND', 'Sorry, I didn''t get that :(.', NULL, '2017-08-10 17:22:23.80954+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_SERVER_DOWN', 'Server down,please contact system admin.', NULL, '2017-12-19 12:39:11.781571+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'ACTION_CALL_INTERVAL_ERRMSG', 'You have performed this transaction', NULL, '2017-12-1913:31:44.967542+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'FILE_UPLOAD_ERROR', 'Sorry we can''t process your attachment', NULL, '2017-12-20 10:49:53.329998+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_FILELIMIT_ERROR', 'File Cannot Exceed 12 mb', NULL, '2017-12-20 14:41:21.825179+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_INTENT_NOT_FOUND', 'آسف، أنا لا أفهم ما تحاول القيام به.', NULL, '2018-04-19 10:06:26.015421+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'sdf', 'sdf', 6315, '2018-05-03 14:59:23.406764+04', 6333, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'INVALID_SELECTION', 'You have selected invalid option.', NULL, '2018-05-08 10:36:16.581262+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCRIPT_ENGINE_EXCEPTION', 'Oops, Internal Error Occured.', NULL, '2018-05-08 12:41:03.292578+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'ACTION_CONF_EXCEPTION', 'Resource Unavailable.', NULL, '2018-05-08 12:43:01.086624+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_LANG_NOT_FOUND', 'آسف لم أتعلم هذه اللغة بعد ، أعتقد أنني جيد باللغة العربية والإنجليزية', NULL, '2018-05-08 12:49:31.237597+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_ENTITY_NOT_FOUND', 'آسف، أنا لا أفهم ما تحاول القيام به.', NULL, '2018-05-08 12:49:31.237597+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'ACTION_CALL_EXCEPTION', 'Unavailable to get information.', NULL, '2018-05-08 12:43:01.086624+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCRIPT_ENGINE_EXCEPTION', 'عفوًا ، حدث خطأ داخلي.', NULL, '2018-05-08 12:54:10.816313+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_FILELIMIT_ERROR', 'لا يمكن أن يتجاوز الملف 12 ميغابايت', NULL, '2018-05-08 12:56:06.495559+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'BC_PLS_UPLOAD_FILE', 'من فضلك حمل الملف ', NULL, '2018-01-31 10:08:02.941114+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_SERVER_DOWN', 'المخدم قد تعطل  ، يرجى الاتصال بمشرف النظام.', NULL, '2018-05-08 12:52:30.05857+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'ACTION_CALL_EXCEPTION', 'لم أتمكن من الحصول على المعلومات ', NULL, '2018-05-08 12:49:31.237597+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'ACTION_CONF_EXCEPTION', 'البيانات غير متوفرة ', NULL, '2018-05-08 12:52:30.05857+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'INVALID_SELECTION', '.تم تحديدخيار غير صحيح ', NULL, '2018-05-08 12:56:43.946066+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'FILE_UPLOAD_ERROR', 'عذرًا ، لا يمكننا معالجة الملف المرفق الخاص بك', NULL, '2018-05-08 12:56:06.495559+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES (62, 'ACTION_CALL_INTERVAL_ERRMSG', 'لقد تم انجاز  المعاملة ', NULL, '2018-05-08 12:56:06.495559+04', NULL, 'ar', NULL);



--channel values

INSERT INTO public.t_channel ( chennel_name, webhook_url, protocol_type, local_url, port, access_token, created, project_id, platform_id, verify_token, channel_source_id) VALUES ( 'Demo Chat', NULL, 'http', '10.10.10.212', '4200', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.t_channel ( chennel_name, webhook_url, protocol_type, local_url, port, access_token, created, project_id, platform_id, verify_token, channel_source_id) VALUES ( 'purist', 'http://api.puristchat.com/admin/v1/conversations/{conversationID}/messages/', 'http', NULL, NULL, '73e84ccd6e4177d7d92d9fefee438b5e', NULL, NULL, Null, NULL, NULL);
INSERT INTO public.t_channel ( chennel_name, webhook_url, protocol_type, local_url, port, access_token, created, project_id, platform_id, verify_token, channel_source_id) VALUES ( 'Facebook', 'https://graph.facebook.com/v2.8/me/messages?', 'https', 'localhost', '5003', 'EAAFyYLQ8ZBdUBAB8ALDwPwRZCzYoNvpby2hS1tTE0BexSSHVjQFB731vZCEBQVz9gYk4sG5yjB7DgVbk3Ui1ZB3sx6hKVC6amXTHZCcFcqRFVzVvHUEkBoaVTxakqH1MxzXU5ux7ZCssoMEDxyC3oc7vxfOnLyKK2ifGtuFdUJXwZDZD', NULL, NULL, Null, NULL, NULL);

update t_channel set platform_id = (select platform_id from t_platform where platform_name = t_channel.chennel_name limit 1);

--confirmation values


INSERT INTO public.t_confirm ( confirmation_type, confirmation_text, confirmed_opt, unconfirmed_opt, locale_code, created, termination_text, action_id, kuid) VALUES ( 'ATTACHMENT', 'Do you want to upload more files ?', 'yes', 'no', 'en', '2018-05-08 14:23:38.264095+04', NULL, NULL, NULL);
INSERT INTO public.t_confirm ( confirmation_type, confirmation_text, confirmed_opt, unconfirmed_opt, locale_code, created, termination_text, action_id, kuid) VALUES ( 'ATTACHMENT', 'هل تريد بالتأكيد تحميل المزيد من الملفات؟', 'نعم فعلا', 'لا', 'ar', '2018-05-08 14:23:38.264095+04', NULL, NULL, NULL);
INSERT INTO public.t_confirm ( confirmation_type, confirmation_text, confirmed_opt, unconfirmed_opt, locale_code, created, termination_text, action_id, kuid) VALUES ( 'ENTITY_VALUE', '{EntityName}: {EntityUserValue}', 'Continue', 'Change', 'en', '2017-12-13 14:43:02.390352+04', 'Transaction Terminated', NULL, NULL);
INSERT INTO public.t_confirm ( confirmation_type, confirmation_text, confirmed_opt, unconfirmed_opt, locale_code, created, termination_text, action_id, kuid) VALUES ( 'CANCEL', 'Do you want to terminate ', 'yes', 'no', 'en', '2017-12-13 14:43:02.390352+04', 'Transaction Terminated', NULL, NULL);
INSERT INTO public.t_confirm ( confirmation_type, confirmation_text, confirmed_opt, unconfirmed_opt, locale_code, created, termination_text, action_id, kuid) VALUES ( 'CANCEL', 'هل تريد الالغاء', 'نعم فعلا', 'لا', 'ar', '2018-04-19 10:04:56.382129+04', 'Transaction Terminated', NULL, NULL);


--cancel keyword setup

INSERT INTO public.t_ku(	  ku_name,  active_ind, spam_enable,  is_rankable)	VALUES  ( 'CANCEL',  'Y', 'Y',  'N');
	
INSERT INTO public.t_intent(	 intent_definition,     active_ind)	VALUES ('CANCEL', 'Y');
	
update t_intent set kuid = (select kuid from t_ku where ku_name = 'CANCEL') where intent_definition = 'CANCEL';
	
INSERT INTO public.t_project_keyword(	 project_keyword, project_keyword_type,   locale_code)	VALUES ('cancel', 'CANCEL', 'en');
	
INSERT INTO public.t_message(	 message_code)	VALUES ('CANCEL');

update t_message set intent_id = (select intent_id from t_intent where intent_definition = 'CANCEL') where message_code = 'CANCEL';
	
insert into t_workflow(intent_id, workflow_name, metadata) select intent_id,intent_definition, '{}' from t_intent where intent_definition='CANCEL';

update t_workflow set kuid = (select kuid from t_ku where ku_name = 'CANCEL') where workflow_name = 'CANCEL';
	
	
	
INSERT INTO public.t_workflow_sequence(	 workflow_id, entry_type, entry_expression, intent_id, workflow_sequence_key,  kuid)	
	select workflow_id, workflow_name, workflow_name, intent_id, workflow_name, kuid from t_workflow where workflow_name = 'CANCEL';
	
	
	
update t_workflow_sequence set required = 'Y', terminal_type = 'START', entry_type = 'MESSAGE',
	entry_expression = (select message_id:: character varying from t_message where message_code = 'CANCEL') 	
	where intent_id = select intent_id from t_intent where intent_definition = 'CANCEL';
	
	
insert into t_response(response,locale_code) values ('Okay, No problem :)','en');
insert into t_response(response,locale_code) values ('حسنا لا مشكلة :)','ar');
	
update t_response set message_id = (select message_id from t_message where message_code = 'CANCEL') where response = 'Okay, No problem :)';
update t_response set message_id = (select message_id from t_message where message_code = 'CANCEL') where response = 'حسنا لا مشكلة :)';
	
INSERT INTO public.t_keyword(	 intent_id, keyword, polarity)	select intent_id, intent_definition, 'P' from t_intent where intent_definition = 'CANCEL';



ALTER TABLE ONLY public.t_intent
    ADD CONSTRAINT "IntentName" UNIQUE (intent_definition);


--
-- TOC entry 2496 (class 2606 OID 52790)
-- Name: t_user_login UserLogin_id_Pkey; Type: CONSTRAINT; Schema: public; Owner: developer
--

ALTER TABLE ONLY public.t_user_login
    ADD CONSTRAINT "UserLogin_id_Pkey" PRIMARY KEY (id);


--
-- TOC entry 2421 (class 2606 OID 49225)
-- Name: t_entity_type entitytypecode; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_entity_type
    ADD CONSTRAINT entitytypecode UNIQUE (entity_type_code);


--
-- TOC entry 2396 (class 2606 OID 49227)
-- Name: t_action_extn id_pkey; Type: CONSTRAINT; Schema: public; Owner: developer
--

ALTER TABLE ONLY public.t_action_extn
    ADD CONSTRAINT id_pkey PRIMARY KEY (id);


--
-- TOC entry 2445 (class 2606 OID 49229)
-- Name: t_keyword keywordid_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_keyword
    ADD CONSTRAINT keywordid_pkey PRIMARY KEY (keyword_id);


--
-- TOC entry 2453 (class 2606 OID 49231)
-- Name: t_ku kuname; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_ku
    ADD CONSTRAINT kuname UNIQUE (ku_name);


--
-- TOC entry 2459 (class 2606 OID 49233)
-- Name: t_language languageId_pkey; Type: CONSTRAINT; Schema: public; Owner: developer
--

ALTER TABLE ONLY public.t_language
    ADD CONSTRAINT "languageId_pkey" PRIMARY KEY (language_id);


--
-- TOC entry 2467 (class 2606 OID 49235)
-- Name: t_message messageId_pkey; Type: CONSTRAINT; Schema: public; Owner: developer
--

ALTER TABLE ONLY public.t_message
    ADD CONSTRAINT "messageId_pkey" PRIMARY KEY (message_id);


--
-- TOC entry 2415 (class 2606 OID 49237)
-- Name: t_entity_question question_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_entity_question
    ADD CONSTRAINT question_id_pkey PRIMARY KEY (question_id);


--
-- TOC entry 2487 (class 2606 OID 49239)
-- Name: t_response response_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_response
    ADD CONSTRAINT response_id_pkey PRIMARY KEY (response_id);


--
-- TOC entry 2392 (class 2606 OID 49241)
-- Name: t_conversation tConversation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_conversation
    ADD CONSTRAINT "tConversation_pkey" PRIMARY KEY (conversation_id);


--
-- TOC entry 2433 (class 2606 OID 49243)
-- Name: t_im_session_log tIMSessionLog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_im_session_log
    ADD CONSTRAINT "tIMSessionLog_pkey" PRIMARY KEY (log_id);


--
-- TOC entry 2451 (class 2606 OID 49245)
-- Name: t_kr_log tKRLog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_kr_log
    ADD CONSTRAINT "tKRLog_pkey" PRIMARY KEY (kr_log_id);


--
-- TOC entry 2500 (class 2606 OID 49247)
-- Name: t_user_rating tUserRating_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_user_rating
    ADD CONSTRAINT "tUserRating_pkey" PRIMARY KEY (rating_id);


--
-- TOC entry 2518 (class 2606 OID 54165)
-- Name: t_action_authorization t_action_authorization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_action_authorization
    ADD CONSTRAINT t_action_authorization_pkey PRIMARY KEY (action_authorization_id);


--
-- TOC entry 2398 (class 2606 OID 49249)
-- Name: t_action_log t_action_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_action_log
    ADD CONSTRAINT t_action_log_pkey PRIMARY KEY (action_log_id);


--
-- TOC entry 2402 (class 2606 OID 49251)
-- Name: t_confirm t_confirm_pkey; Type: CONSTRAINT; Schema: public; Owner: developer
--

ALTER TABLE ONLY public.t_confirm
    ADD CONSTRAINT t_confirm_pkey PRIMARY KEY (confirm_id);


--
-- TOC entry 2404 (class 2606 OID 49253)
-- Name: t_conversation_cache t_conversation_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_conversation_cache
    ADD CONSTRAINT t_conversation_cache_pkey PRIMARY KEY (conv_cache_id);


--
-- TOC entry 2406 (class 2606 OID 49255)
-- Name: t_conversation_pointer t_conversation_pointer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_conversation_pointer
    ADD CONSTRAINT t_conversation_pointer_pkey PRIMARY KEY (conv_pointer_id);


--
-- TOC entry 2408 (class 2606 OID 49257)
-- Name: t_db_listing t_db_listing_pkey; Type: CONSTRAINT; Schema: public; Owner: ui
--

ALTER TABLE ONLY public.t_db_listing
    ADD CONSTRAINT t_db_listing_pkey PRIMARY KEY (list_id);


--
-- TOC entry 2419 (class 2606 OID 49259)
-- Name: t_entity_regex t_entity_regex_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_entity_regex
    ADD CONSTRAINT t_entity_regex_pkey PRIMARY KEY (entity_regex_id);


--
-- TOC entry 2423 (class 2606 OID 49261)
-- Name: t_entity_type t_enttyp_typcd_ukey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_entity_type
    ADD CONSTRAINT t_enttyp_typcd_ukey UNIQUE (entity_type_code);


--
-- TOC entry 2427 (class 2606 OID 49263)
-- Name: t_error_response t_error_response_pkey; Type: CONSTRAINT; Schema: public; Owner: developer
--

ALTER TABLE ONLY public.t_error_response
    ADD CONSTRAINT t_error_response_pkey PRIMARY KEY (id);


--
-- TOC entry 2429 (class 2606 OID 49265)
-- Name: t_im_error_log t_im_error_log_pkey; Type: CONSTRAINT; Schema: public; Owner: developer
--

ALTER TABLE ONLY public.t_im_error_log
    ADD CONSTRAINT t_im_error_log_pkey PRIMARY KEY (elog_id);


--
-- TOC entry 2431 (class 2606 OID 49267)
-- Name: t_im_session t_imsession_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_im_session
    ADD CONSTRAINT t_imsession_pkey PRIMARY KEY (im_session_id);


--
-- TOC entry 2442 (class 2606 OID 49271)
-- Name: t_intent_mapping t_intent_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: ui
--

ALTER TABLE ONLY public.t_intent_mapping
    ADD CONSTRAINT t_intent_mapping_pkey PRIMARY KEY (map_id);


--
-- TOC entry 2455 (class 2606 OID 49273)
-- Name: t_ku t_key_kunam_ukey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_ku
    ADD CONSTRAINT t_key_kunam_ukey UNIQUE (ku_name);


--
-- TOC entry 2461 (class 2606 OID 49275)
-- Name: t_locale t_locale_loccd; Type: CONSTRAINT; Schema: public; Owner: developer
--

ALTER TABLE ONLY public.t_locale
    ADD CONSTRAINT t_locale_loccd UNIQUE (locale_code);


--
-- TOC entry 2463 (class 2606 OID 49277)
-- Name: t_locale t_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: developer
--

ALTER TABLE ONLY public.t_locale
    ADD CONSTRAINT t_locale_pkey PRIMARY KEY (locale_id);


--
-- TOC entry 2465 (class 2606 OID 49279)
-- Name: t_locale_unicodes t_locale_unicodes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_locale_unicodes
    ADD CONSTRAINT t_locale_unicodes_pkey PRIMARY KEY (unicode_seq_id);


--
-- TOC entry 2469 (class 2606 OID 49283)
-- Name: t_platform t_platform_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_platform
    ADD CONSTRAINT t_platform_pkey PRIMARY KEY (platform_id);


--
-- TOC entry 2473 (class 2606 OID 49285)
-- Name: t_project_keyword t_prjkey_kwrd_Ukey; Type: CONSTRAINT; Schema: public; Owner: developer
--

ALTER TABLE ONLY public.t_project_keyword
    ADD CONSTRAINT "t_prjkey_kwrd_Ukey" UNIQUE (project_keyword);


--
-- TOC entry 2475 (class 2606 OID 49287)
-- Name: t_project_keyword t_project_keyword_pkey; Type: CONSTRAINT; Schema: public; Owner: developer
--

ALTER TABLE ONLY public.t_project_keyword
    ADD CONSTRAINT t_project_keyword_pkey PRIMARY KEY (project_keyword_id);


--
-- TOC entry 2471 (class 2606 OID 49289)
-- Name: t_project t_project_pkey; Type: CONSTRAINT; Schema: public; Owner: developer
--

ALTER TABLE ONLY public.t_project
    ADD CONSTRAINT t_project_pkey PRIMARY KEY (project_id);


--
-- TOC entry 2477 (class 2606 OID 49291)
-- Name: t_project_locale t_projloc_projlid_pkey; Type: CONSTRAINT; Schema: public; Owner: developer
--

ALTER TABLE ONLY public.t_project_locale
    ADD CONSTRAINT t_projloc_projlid_pkey PRIMARY KEY (project_lang_id);


--
-- TOC entry 2485 (class 2606 OID 52508)
-- Name: t_regex_extn t_rgx_extn_id_pkey; Type: CONSTRAINT; Schema: public; Owner: developer
--

ALTER TABLE ONLY public.t_regex_extn
    ADD CONSTRAINT t_rgx_extn_id_pkey PRIMARY KEY (id);


--
-- TOC entry 2479 (class 2606 OID 49293)
-- Name: t_regex t_rgx_rgx_kuid_ukey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_regex
    ADD CONSTRAINT t_rgx_rgx_kuid_ukey UNIQUE (expression, kuid);




ALTER TABLE ONLY public.t_regex
    ADD CONSTRAINT t_rgx_rgx_rgxnm_kuid_ukey UNIQUE (expression, kuid, regex_name);



ALTER TABLE ONLY public.t_selection_list
    ADD CONSTRAINT t_selection_list_pkey PRIMARY KEY (selection_id);




ALTER TABLE ONLY public.users
    ADD CONSTRAINT t_user_email_ukey UNIQUE (email);




ALTER TABLE ONLY public.t_user_locale
    ADD CONSTRAINT t_usrloc_ulid_pkey PRIMARY KEY (user_locale_id);




ALTER TABLE ONLY public.t_workflow
    ADD CONSTRAINT t_workflow_actionid_unique UNIQUE (action_id);




ALTER TABLE ONLY public.t_workflow
    ADD CONSTRAINT t_workflow_entityid_unique UNIQUE (entity_id);



ALTER TABLE ONLY public.t_workflow
    ADD CONSTRAINT t_workflow_intentid_unique UNIQUE (intent_id);



ALTER TABLE ONLY public.t_workflow_sequence
    ADD CONSTRAINT t_workflow_seq_pkey PRIMARY KEY (workflow_sequence_id);




ALTER TABLE ONLY public.t_action
    ADD CONSTRAINT taction_pkey PRIMARY KEY (action_id);




ALTER TABLE ONLY public.t_channel
    ADD CONSTRAINT tchannel_pkey PRIMARY KEY (channel_id);


ALTER TABLE ONLY public.t_entity
    ADD CONSTRAINT tentity_pkey PRIMARY KEY (entity_id);


ALTER TABLE ONLY public.t_entity_type
    ADD CONSTRAINT tentitytype_pkey PRIMARY KEY (entity_type_id);



ALTER TABLE ONLY public.t_intent
    ADD CONSTRAINT tintent_pkey PRIMARY KEY (intent_id);



ALTER TABLE ONLY public.t_ku
    ADD CONSTRAINT tku_kuid_pkey PRIMARY KEY (kuid);




ALTER TABLE ONLY public.t_regex
    ADD CONSTRAINT tregex_pkey PRIMARY KEY (regex_id);




ALTER TABLE ONLY public.t_user_mapping
    ADD CONSTRAINT tusermapping_pkey PRIMARY KEY (mapping_id);



ALTER TABLE ONLY public.t_entity
    ADD CONSTRAINT unique_entity UNIQUE (entity_name, intent_id);


ALTER TABLE ONLY public.t_intent
    ADD CONSTRAINT unique_intent UNIQUE (kuid, intent_definition);




ALTER TABLE ONLY public.t_keyword
    ADD CONSTRAINT unique_keyword_intentid UNIQUE (keyword, intent_id);


ALTER TABLE ONLY public.user_token
    ADD CONSTRAINT user_token_pkey PRIMARY KEY (token_id);



ALTER TABLE ONLY public.users
    ADD CONSTRAINT users2_pkey PRIMARY KEY (user_id);




ALTER TABLE ONLY public.t_workflow
    ADD CONSTRAINT workflow_id_pkey PRIMARY KEY (workflow_id);


CREATE INDEX fki_tkeyword_intentid_fkey ON public.t_keyword USING btree (keyword_id);




CREATE INDEX tentity_kuid_idx ON public.t_entity USING btree (kuid);



CREATE INDEX tentityquestion_entityid_idx ON public.t_entity_question USING btree (entity_id);



CREATE INDEX tentityquestion_kuid_idx ON public.t_entity_question USING btree (kuid);



CREATE INDEX tintent_kuid_idx ON public.t_intent USING btree (kuid);




CREATE INDEX tkeyword_intentid_idx ON public.t_keyword USING btree (intent_id);



CREATE INDEX tkeyword_keyword_idx ON public.t_keyword USING btree (keyword);




CREATE INDEX tresponse_entityid_idx ON public.t_response USING btree (entity_id);


CREATE INDEX tresponse_intentid_idx ON public.t_response USING btree (intent_id);



CREATE INDEX tresponse_kuid_idx ON public.t_response USING btree (kuid);




ALTER TABLE ONLY public.t_kr_log
    ADD CONSTRAINT "tKRLog_tIntent_IntentID_fkey" FOREIGN KEY (intent_id) REFERENCES public.t_intent(intent_id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY public.t_user_rating
    ADD CONSTRAINT "tURat_tIntent_IntentID_fkey" FOREIGN KEY (intent_id) REFERENCES public.t_intent(intent_id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_regex_extn
    ADD CONSTRAINT t_regex_extn_t_regex_regexid_fkey FOREIGN KEY (regex_id) REFERENCES public.t_regex(regex_id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_action
    ADD CONSTRAINT tact_tent_eid_fkey FOREIGN KEY (entity_id) REFERENCES public.t_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE;




ALTER TABLE ONLY public.t_action
    ADD CONSTRAINT tact_tint_intid_fkey FOREIGN KEY (intent_id) REFERENCES public.t_intent(intent_id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_action
    ADD CONSTRAINT tact_tku_kuid_fkey FOREIGN KEY (kuid) REFERENCES public.t_ku(kuid) ON UPDATE CASCADE ON DELETE CASCADE;




ALTER TABLE ONLY public.t_action_extn
    ADD CONSTRAINT tactext_tact_aid_fkey FOREIGN KEY (action_id) REFERENCES public.t_action(action_id) ON UPDATE CASCADE ON DELETE CASCADE;




ALTER TABLE ONLY public.t_action_extn
    ADD CONSTRAINT taction_tactext_aid_fkey FOREIGN KEY (action_id) REFERENCES public.t_action(action_id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_confirm
    ADD CONSTRAINT taction_tconfirm_aid_fkey FOREIGN KEY (action_id) REFERENCES public.t_action(action_id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_action
    ADD CONSTRAINT taction_tintent_inid_fkey FOREIGN KEY (intent_id) REFERENCES public.t_intent(intent_id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY public.t_action
    ADD CONSTRAINT taction_tku_kuid_fkey FOREIGN KEY (kuid) REFERENCES public.t_ku(kuid) ON UPDATE CASCADE ON DELETE CASCADE;




ALTER TABLE ONLY public.t_confirm
    ADD CONSTRAINT tcon_tku_kuid_fkey FOREIGN KEY (kuid) REFERENCES public.t_ku(kuid) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_confirm
    ADD CONSTRAINT tconfirm_tku_kuid_fkey FOREIGN KEY (kuid) REFERENCES public.t_ku(kuid) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_conversation_cache
    ADD CONSTRAINT tconvche_tint_intid_fkey FOREIGN KEY (intent_id) REFERENCES public.t_intent(intent_id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY public.t_entity
    ADD CONSTRAINT tent_tenttpy_entid_fkey FOREIGN KEY (entity_type_code) REFERENCES public.t_entity_type(entity_type_code) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_entity
    ADD CONSTRAINT tent_tku_kuid_fkey FOREIGN KEY (kuid) REFERENCES public.t_ku(kuid) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_entity_question
    ADD CONSTRAINT tentity_questions_eid_fkey FOREIGN KEY (entity_id) REFERENCES public.t_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_entity_question
    ADD CONSTRAINT tentque_tku_kuid_fkey FOREIGN KEY (kuid) REFERENCES public.t_ku(kuid) ON UPDATE CASCADE ON DELETE CASCADE;




ALTER TABLE ONLY public.t_entity_regex
    ADD CONSTRAINT tentrgx_tent_eid FOREIGN KEY (entity_id) REFERENCES public.t_entity(entity_id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_error_response
    ADD CONSTRAINT terror_res_tku_kuid_fkey FOREIGN KEY (kuid) REFERENCES public.t_ku(kuid) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_error_response
    ADD CONSTRAINT terrorresponse_taction_aid_fkey FOREIGN KEY (action_id) REFERENCES public.t_action(action_id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY public.t_error_response
    ADD CONSTRAINT terrresp_tku_kuid_fkey FOREIGN KEY (kuid) REFERENCES public.t_ku(kuid) ON UPDATE CASCADE ON DELETE CASCADE;




ALTER TABLE ONLY public.t_intent_extn
    ADD CONSTRAINT tint_tintext_intid_fkey FOREIGN KEY (intent_id) REFERENCES public.t_intent(intent_id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_intent_extn
    ADD CONSTRAINT tintent_tintent_extn_intent_id_fkey FOREIGN KEY (intent_id) REFERENCES public.t_intent(intent_id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_intent
    ADD CONSTRAINT tintent_tkuid_kuid_fkey FOREIGN KEY (kuid) REFERENCES public.t_ku(kuid) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_message
    ADD CONSTRAINT tintent_tmesssage_intentid_fkey FOREIGN KEY (intent_id) REFERENCES public.t_intent(intent_id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_response
    ADD CONSTRAINT tintent_tresponse_intentid_fkey FOREIGN KEY (intent_id) REFERENCES public.t_intent(intent_id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_workflow
    ADD CONSTRAINT tintent_tworkflow_intid_fkey FOREIGN KEY (intent_id) REFERENCES public.t_intent(intent_id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY public.t_intent_mapping
    ADD CONSTRAINT tintmap_tint_intentid_fkey FOREIGN KEY (intent_id) REFERENCES public.t_intent(intent_id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_keyword
    ADD CONSTRAINT tkeyword_tint_intid_fkey FOREIGN KEY (intent_id) REFERENCES public.t_intent(intent_id) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_entity_type
    ADD CONSTRAINT tku_kuid_fkey FOREIGN KEY (kuid) REFERENCES public.t_ku(kuid) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_regex
    ADD CONSTRAINT tku_treg_kuid_fkey FOREIGN KEY (kuid) REFERENCES public.t_ku(kuid) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_workflow
    ADD CONSTRAINT tku_tworkflow_kuid_fkey FOREIGN KEY (kuid) REFERENCES public.t_ku(kuid) ON UPDATE CASCADE ON DELETE CASCADE;




ALTER TABLE ONLY public.t_locale_unicodes
    ADD CONSTRAINT tlocuni_tloc_loccd_fkey FOREIGN KEY (locale_code) REFERENCES public.t_locale(locale_code) ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY public.t_response
    ADD CONSTRAINT tresp_tint_intid_fkey FOREIGN KEY (intent_id) REFERENCES public.t_intent(intent_id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY public.t_workflow_sequence
    ADD CONSTRAINT twrkflwseq_tint_iid FOREIGN KEY (intent_id) REFERENCES public.t_intent(intent_id) ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE ONLY public.t_workflow_sequence
    ADD CONSTRAINT twrkflwseq_tku_kid FOREIGN KEY (kuid) REFERENCES public.t_ku(kuid) ON UPDATE CASCADE ON DELETE CASCADE;






---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--platform values

INSERT INTO public.t_platform ( platform_name, active_id, created) VALUES ( 'facebook', NULL, '2018-04-17 10:41:19.039416+04');
INSERT INTO public.t_platform ( platform_name, active_id, created) VALUES ( 'purist', NULL, '2018-04-17 10:41:32.708851+04');


--entity type values

INSERT INTO public.t_entity_type ( entity_type_code, entity_type_name, invalid_message, created, kuid, project_id) VALUES ( 'GEN', 'Generic', 'Enter valid message', '2018-01-10 10:53:38.21466+04', NULL, NULL);
INSERT INTO public.t_entity_type ( entity_type_code, entity_type_name, invalid_message, created, kuid, project_id) VALUES ( 'ATCMT', 'Upload File', 'Media Type Required', '2018-02-01 14:51:42.688833+04', NULL, NULL);
INSERT INTO public.t_entity_type ( entity_type_code, entity_type_name, invalid_message, created, kuid, project_id) VALUES ( 'ELS', 'ExternalService Listing', 'No Info Available', '2018-02-20 17:36:47.671523+04', NULL, NULL);
INSERT INTO public.t_entity_type ( entity_type_code, entity_type_name, invalid_message, created, kuid, project_id) VALUES ( 'EILS', 'External Image Listing', 'List is   not Proper', '2018-03-08 11:23:59.657468+04', NULL, NULL);
INSERT INTO public.t_entity_type ( entity_type_code, entity_type_name, invalid_message, created, kuid, project_id) VALUES ( 'EQRP', 'Quick Replies', 'List is   not Proper', '2018-03-08 11:24:52.253494+04', NULL, NULL);

--locale

INSERT INTO public.t_locale ( locale_name, locale_code, locale_cnfrm_msg, locale_error_msg, intent_choice_msg) VALUES ( 'English', 'en', 'Sure I can speak both languages, shall we carry on in English or Arabic?', 'Sorry I haven''t learnt this language yet, I think I''m good in عربى and English', 'which one do you want to perform?');
INSERT INTO public.t_locale ( locale_name, locale_code, locale_cnfrm_msg, locale_error_msg, intent_choice_msg) VALUES ( 'عربي', 'ar', 'أكيد أنا أجيد كلا اللغتين, هل نحول اللغة إلى الإنجليزية أو العربية', 'للأسف مازلت أفكر في تعلم هذه اللغة، في الوقت الحالي أعتقد أني قادر على التفاهم معك باللغة العربية أو الإنكليزية', 'أي واحد تريد أن تؤدي؟');

--locale unicodes

INSERT INTO public.t_locale_unicodes ( locale_code, head_unicode, tail_unicode, head_num_unicode, tail_num_unicode, created) VALUES ( 'en', 65, 90, NULL, NULL, '2018-01-17 11:09:39.733127+04');
INSERT INTO public.t_locale_unicodes ( locale_code, head_unicode, tail_unicode, head_num_unicode, tail_num_unicode, created) VALUES ( 'en', 48, 58, NULL, NULL, '2017-01-17 11:09:39.733127+04');
INSERT INTO public.t_locale_unicodes ( locale_code, head_unicode, tail_unicode, head_num_unicode, tail_num_unicode, created) VALUES ( 'en', 97, 122, NULL, NULL, '2018-01-17 10:15:02.674846+04');
INSERT INTO public.t_locale_unicodes ( locale_code, head_unicode, tail_unicode, head_num_unicode, tail_num_unicode, created) VALUES ( 'ar', 1536, 1791, 1632, 1641, '2018-01-17 10:15:51.980946+04');
 
--authorization values

INSERT INTO public.t_action_authorization ( access_token_url, created, access_token_req_body, access_token_req_method, access_token, expiry_interval, token_creation_time, action_name, user_access_code) VALUES ( 'http://10.10.10.212:7001/SCS_UPDATES/oauth/token', '2018-05-07 15:38:29.612581+04', '{
	"service_type": "X_URL_FORM_ENCODED",
	"headers": [{
		"header_key": "Content-Type",
		"header_value": "application/x-www-form-urlencoded"
	}, {
		"header_key": "Authorization",
		"header_value": "Basic Z21KSFJlMEJxQ1pMQThrT1F6QktQbW14d2pIRW91MVNacDNMYjZLMDozdXVjUndhZHFQUmNxYlVRTzNyRmVMUWVyemU4M1pHNG1ueUFGek1T"
	}],
	"req_body": {
		"req_body_params": [{
			"entitykey": "grant_type",
			"entityvalue": "client_credentials"
		}]
	}
}', 'POST', 'efeaa8d6-2fcd-4fab-8982-5f65c26b9276', NULL, '2018-05-08 17:07:08.582', NULL, 'K+u0K8R52vMZErhD4Yt4h50nvbFQA0QMOrUOE2PcMgw=');
 
 

--error responses


INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'BC_PLS_UPLOAD_FILE', 'Please upload a file.', NULL, '2018-01-31 10:08:02.941114+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_PLSWAIT_MSG', 'Please wait, while we process your request.', NULL, '2017-12-19 11:49:52.592463+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_LANG_NOT_FOUND', 'Sorry I haven''t learnt this language yet, I  think I''m good in   Arabic andEnglish', NULL, '2018-02-15 18:10:51.000683+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_INTENT_NOT_FOUND', 'sorry, I didn''t get that :(', NULL, '2017-08-10 17:22:23.80954+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_ENTITY_NOT_FOUND', 'Sorry, I didn''t get that :(.', NULL, '2017-08-10 17:22:23.80954+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_SERVER_DOWN', 'Server down,please contact system admin.', NULL, '2017-12-19 12:39:11.781571+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'ACTION_CALL_INTERVAL_ERRMSG', 'You have performed this transaction', NULL, '2017-12-1913:31:44.967542+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'FILE_UPLOAD_ERROR', 'Sorry we can''t process your attachment', NULL, '2017-12-20 10:49:53.329998+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_FILELIMIT_ERROR', 'File Cannot Exceed 12 mb', NULL, '2017-12-20 14:41:21.825179+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_INTENT_NOT_FOUND', 'آسف، أنا لا أفهم ما تحاول القيام به.', NULL, '2018-04-19 10:06:26.015421+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'sdf', 'sdf', 6315, '2018-05-03 14:59:23.406764+04', 6333, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'INVALID_SELECTION', 'You have selected invalid option.', NULL, '2018-05-08 10:36:16.581262+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCRIPT_ENGINE_EXCEPTION', 'Oops, Internal Error Occured.', NULL, '2018-05-08 12:41:03.292578+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'ACTION_CONF_EXCEPTION', 'Resource Unavailable.', NULL, '2018-05-08 12:43:01.086624+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_LANG_NOT_FOUND', 'آسف لم أتعلم هذه اللغة بعد ، أعتقد أنني جيد باللغة العربية والإنجليزية', NULL, '2018-05-08 12:49:31.237597+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_ENTITY_NOT_FOUND', 'آسف، أنا لا أفهم ما تحاول القيام به.', NULL, '2018-05-08 12:49:31.237597+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'ACTION_CALL_EXCEPTION', 'Unavailable to get information.', NULL, '2018-05-08 12:43:01.086624+04', NULL, 'en', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCRIPT_ENGINE_EXCEPTION', 'عفوًا ، حدث خطأ داخلي.', NULL, '2018-05-08 12:54:10.816313+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_FILELIMIT_ERROR', 'لا يمكن أن يتجاوز الملف 12 ميغابايت', NULL, '2018-05-08 12:56:06.495559+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'BC_PLS_UPLOAD_FILE', 'من فضلك حمل الملف ', NULL, '2018-01-31 10:08:02.941114+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'SCE_SERVER_DOWN', 'المخدم قد تعطل  ، يرجى الاتصال بمشرف النظام.', NULL, '2018-05-08 12:52:30.05857+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'ACTION_CALL_EXCEPTION', 'لم أتمكن من الحصول على المعلومات ', NULL, '2018-05-08 12:49:31.237597+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'ACTION_CONF_EXCEPTION', 'البيانات غير متوفرة ', NULL, '2018-05-08 12:52:30.05857+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'INVALID_SELECTION', '.تم تحديدخيار غير صحيح ', NULL, '2018-05-08 12:56:43.946066+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES ( 'FILE_UPLOAD_ERROR', 'عذرًا ، لا يمكننا معالجة الملف المرفق الخاص بك', NULL, '2018-05-08 12:56:06.495559+04', NULL, 'ar', NULL);
INSERT INTO public.t_error_response ( error_code, error_response, kuid, created, action_id, locale_code, regex_id) VALUES (62, 'ACTION_CALL_INTERVAL_ERRMSG', 'لقد تم انجاز  المعاملة ', NULL, '2018-05-08 12:56:06.495559+04', NULL, 'ar', NULL);


--channel values

INSERT INTO public.t_channel ( chennel_name, webhook_url, protocol_type, local_url, port, access_token, created, project_id, platform_id, verify_token, channel_source_id) VALUES ( 'Demo Chat', NULL, 'http', '10.10.10.212', '4200', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO public.t_channel ( chennel_name, webhook_url, protocol_type, local_url, port, access_token, created, project_id, platform_id, verify_token, channel_source_id) VALUES ( 'purist', 'http://api.puristchat.com/admin/v1/conversations/{conversationID}/messages/', 'http', NULL, NULL, '73e84ccd6e4177d7d92d9fefee438b5e', NULL, NULL, Null, NULL, NULL);
INSERT INTO public.t_channel ( chennel_name, webhook_url, protocol_type, local_url, port, access_token, created, project_id, platform_id, verify_token, channel_source_id) VALUES ( 'Facebook', 'https://graph.facebook.com/v2.8/me/messages?', 'https', 'localhost', '5003', 'EAAFyYLQ8ZBdUBAB8ALDwPwRZCzYoNvpby2hS1tTE0BexSSHVjQFB731vZCEBQVz9gYk4sG5yjB7DgVbk3Ui1ZB3sx6hKVC6amXTHZCcFcqRFVzVvHUEkBoaVTxakqH1MxzXU5ux7ZCssoMEDxyC3oc7vxfOnLyKK2ifGtuFdUJXwZDZD', NULL, NULL, Null, NULL, NULL);

update t_channel set platfrom_id = (select platform_id from t_platform where platform_name = t_channel.chennel_name limit 1);

--confirmation values


INSERT INTO public.t_confirm ( confirmation_type, confirmation_text, confirmed_opt, unconfirmed_opt, locale_code, created, termination_text, action_id, kuid) VALUES ( 'ATTACHMENT', 'Do you want to upload more files ?', 'yes', 'no', 'en', '2018-05-08 14:23:38.264095+04', NULL, NULL, NULL);
INSERT INTO public.t_confirm ( confirmation_type, confirmation_text, confirmed_opt, unconfirmed_opt, locale_code, created, termination_text, action_id, kuid) VALUES ( 'ATTACHMENT', 'هل تريد بالتأكيد تحميل المزيد من الملفات؟', 'نعم فعلا', 'لا', 'ar', '2018-05-08 14:23:38.264095+04', NULL, NULL, NULL);
INSERT INTO public.t_confirm ( confirmation_type, confirmation_text, confirmed_opt, unconfirmed_opt, locale_code, created, termination_text, action_id, kuid) VALUES ( 'ENTITY_VALUE', '{EntityName}: {EntityUserValue}', 'Continue', 'Change', 'en', '2017-12-13 14:43:02.390352+04', 'Transaction Terminated', NULL, NULL);
INSERT INTO public.t_confirm ( confirmation_type, confirmation_text, confirmed_opt, unconfirmed_opt, locale_code, created, termination_text, action_id, kuid) VALUES ( 'CANCEL', 'Do you want to terminate ', 'yes', 'no', 'en', '2017-12-13 14:43:02.390352+04', 'Transaction Terminated', NULL, NULL);
INSERT INTO public.t_confirm ( confirmation_type, confirmation_text, confirmed_opt, unconfirmed_opt, locale_code, created, termination_text, action_id, kuid) VALUES ( 'CANCEL', 'هل تريد الالغاء', 'نعم فعلا', 'لا', 'ar', '2018-04-19 10:04:56.382129+04', 'Transaction Terminated', NULL, NULL);


--cancel keyword setup

INSERT INTO public.t_ku(  ku_name,  active_ind, spam_enable,  is_rankable)	VALUES  ( 'CANCEL',  'Y', 'Y',  'N');

INSERT INTO public.t_intent( intent_definition,     active_ind)	VALUES ('CANCEL', 'Y');

update t_intent set kuid = (select kuid from t_ku where ku_name = 'CANCEL') where intent_definition = 'CANCEL';

INSERT INTO public.t_project_keyword( project_keyword, project_keyword_type,   locale_code)	VALUES ('cancel', 'CANCEL', 'en');

INSERT INTO public.t_message( message_code)	VALUES ('CANCEL');

update t_message set intent_id = (select intent_id from t_intent where intent_definition = 'CANCEL') where message_code = 'CANCEL';

insert into t_workflow(intent_id, workflow_name, metadata) select intent_id,intent_definition, '{}' from t_intent where intent_definition='CANCEL';

update t_workflow set kuid = (select kuid from t_ku where ku_name = 'CANCEL') where workflow_name = 'CANCEL';	
 
INSERT INTO public.t_workflow_sequence(	 workflow_id, entry_type, entry_expression, intent_id, workflow_sequence_key,  kuid)	
	select workflow_id, workflow_name, workflow_name, intent_id, workflow_name, kuid from t_workflow where workflow_name = 'CANCEL';
	
update t_workflow_sequence set required = 'Y', terminal_type = 'START', entry_type = 'MESSAGE',
	entry_expression = (select message_id:: character varying from t_message where message_code = 'CANCEL') 	
	where intent_id = select intent_id from t_intent where intent_definition = 'CANCEL';


insert into t_response(response,locale_code) values ('Okay, No problem :)','en');
insert into t_response(response,locale_code) values ('حسنا لا مشكلة :)','ar');

update t_response set message_id = (select message_id from t_message where message_code = 'CANCEL') where response = 'Okay, No problem :)';
update t_response set message_id = (select message_id from t_message where message_code = 'CANCEL') where response = 'حسنا لا مشكلة :)';
	
INSERT INTO public.t_keyword(	 intent_id, keyword, polarity)	select intent_id, intent_definition, 'P' from t_intent where intent_definition = 'CANCEL';

CREATE TABLE public.t_conversation_cache
(
	conv_cache_id bigserial primary key,
    session_id character varying COLLATE pg_catalog."default",
    intent_id bigint,
    cache_data character varying COLLATE pg_catalog."default",
    fullfilled character varying COLLATE pg_catalog."default",
    entry_type character varying COLLATE pg_catalog."default",
    entry_id bigint,
	created character varying COLLATE pg_catalog."default" DEFAULT (now())::character varying,
    CONSTRAINT tconvche_tint_intid_fkey FOREIGN KEY (intent_id)
        REFERENCES public.t_intent (intent_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);

CREATE TABLE public.t_conversation_pointer
(
	conv_pointer_id bigserial primary key,
    session_id character varying COLLATE pg_catalog."default",
    pointer_type character varying COLLATE pg_catalog."default",
    pointer_desc character varying COLLATE pg_catalog."default",
    source_id bigint,
    is_pointed character varying COLLATE pg_catalog."default",
    temp_cache character varying COLLATE pg_catalog."default",
    created character varying COLLATE pg_catalog."default" DEFAULT (now())::character varying
    
)
WITH (
    OIDS = FALSE
);





CREATE TABLE public.t_platform
(
    platform_id bigserial PRIMARY KEY,
    platform_name character varying COLLATE pg_catalog."default" NOT NULL,
    active_id character varying COLLATE pg_catalog."default",
    created character varying COLLATE pg_catalog."default" DEFAULT (now())::character varying
)
WITH (
    OIDS = FALSE
);




CREATE TABLE public.t_channel
(
    channel_id bigserial,
    chennel_name character varying COLLATE pg_catalog."default",
    webhook_url character varying COLLATE pg_catalog."default",
    protocol_type character varying COLLATE pg_catalog."default",
    local_url character varying COLLATE pg_catalog."default",
    port character varying COLLATE pg_catalog."default",
    access_token character varying COLLATE pg_catalog."default",
    created timestamp with time zone,
    
    platform_id bigint,
    verify_token character varying COLLATE pg_catalog."default",
   
    CONSTRAINT tchannel_pkey PRIMARY KEY (channel_id)
)
WITH (
    OIDS = FALSE
);





CREATE TABLE public.t_entity_regex
(
    entity_regex_id bigserial primary key,
    entity_id bigint,
    regex_id bigint,
    created character varying COLLATE pg_catalog."default" DEFAULT (now())::character varying,
    CONSTRAINT t_entity_regex_pkey PRIMARY KEY (entity_regex_id),
    CONSTRAINT tentrgx_tent_eid FOREIGN KEY (entity_id)
        REFERENCES public.t_entity (entity_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
WITH (
    OIDS = FALSE
);




CREATE TABLE public.t_workflow_sequence
(
    workflow_sequence_id bigserial,
    workflow_id bigint NOT NULL,
    entry_type character varying COLLATE pg_catalog."default" NOT NULL,
    entry_expression character varying COLLATE pg_catalog."default" NOT NULL,
    primary_dest_wrkflw_id bigint,
    secondary_dest_wrkflw_id bigint,
    intent_seq_id bigint,
    required character varying COLLATE pg_catalog."default",
    terminal_type character varying COLLATE pg_catalog."default",
    intent_id bigint,
    primary_dest_sequence_key character varying COLLATE pg_catalog."default",
    workflow_sequence_key character varying COLLATE pg_catalog."default",
    secondary_dest_sequence_key character varying COLLATE pg_catalog."default",
    kuid bigint,
    intial_validation character varying COLLATE pg_catalog."default",
    CONSTRAINT t_workflow_seq_pkey PRIMARY KEY (workflow_sequence_id)
)
WITH (
    OIDS = FALSE
);




ALTER TABLE public.t_user_locale
    ADD COLUMN channel_id character varying COLLATE pg_catalog."default";


ALTER TABLE public.t_entity
    ADD COLUMN data_type character varying COLLATE pg_catalog."default";



CREATE TABLE public.t_intent_mapping
(
    map_id bigserial,
    entry_type character varying(255) COLLATE pg_catalog."default" NOT NULL,
    kuid bigint NOT NULL,
    order_id bigint NOT NULL,
    required character varying(255) COLLATE pg_catalog."default" NOT NULL,
    intent_id bigint NOT NULL,
    workflow_id bigint NOT NULL,
    entry_id character varying COLLATE pg_catalog."default",
    CONSTRAINT t_intent_mapping_pkey PRIMARY KEY (map_id),
  
    CONSTRAINT tintmap_tint_intentid_fkey FOREIGN KEY (intent_id)
        REFERENCES public.t_intent (intent_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
)
WITH (
    OIDS = FALSE
);


CREATE TABLE public.t_message
(
    message_id bigserial,
    message_code character varying COLLATE pg_catalog."default",
    created character varying COLLATE pg_catalog."default" DEFAULT (now())::character varying,
    CONSTRAINT "messageId_pkey" PRIMARY KEY (message_id)
)
WITH (
    OIDS = FALSE
);




ALTER TABLE public.t_response
    ADD COLUMN action_id bigint;
    
    
ALTER TABLE public.t_response
    ADD COLUMN message_id bigint;


CREATE TABLE public.t_action_authorization
(
    action_authorization_id bigserial PRIMARY KEY,
    access_token_url character varying,
    created character varying DEFAULT (now())::character varying,
    access_token_req_body character varying,
    access_token_req_method character varying,
    access_token character varying,
    expiry_interval bigint,
    token_creation_time character varying,
    action_name character varying,
    user_access_code character varying
)
WITH (
    OIDS = FALSE
);





alter table t_user_mapping add column channel_id bigint;

alter table t_conversation_cache add column action_cache_data character varying;

alter table t_user_attachments add column channel_id bigint;

alter table t_ku add column is_rankable character varying;

alter table t_user_rating add column session_id character varying;


