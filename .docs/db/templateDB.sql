create table TI18N
(
    ID_I18N          INTEGER GENERATED ALWAYS AS IDENTITY
        primary key,
    CLASS_NAME       VARCHAR(150),
    I18N_DESCRIPTION VARCHAR(250)
);

create table TI18N_VALUE
(
    ID_I18N_VALUE INTEGER GENERATED ALWAYS AS IDENTITY
        primary key,
    ID_I18N       INTEGER not null,
    KEY           VARCHAR(250),
    ES_ES         VARCHAR(10485760),
    EN_US         VARCHAR(10485760),
    GL_ES         VARCHAR(10485760)
);

create table TREQUEST_STATISTICS
(
    ID_REQUEST_STATISTICS INTEGER not null
        primary key,
    SERVICE_NAME          VARCHAR(255),
    METHOD_NAME           VARCHAR(50),
    USER_NAME             VARCHAR(50),
    EXECUTION_DATE        DATE,
    EXECUTION_TIME        INTEGER,
    METHOD_PARAMS         VARCHAR(5000),
    SERVICE_EXCEPTION     VARCHAR(5000)
);

create table TROLE
(
    ID_ROLENAME         INTEGER GENERATED ALWAYS AS IDENTITY
        primary key,
    ROLENAME            VARCHAR(255),
    XMLCLIENTPERMISSION VARCHAR(10485760)
);

create table TSERVER_PERMISSION
(
    ID_SERVER_PERMISSION INTEGER GENERATED ALWAYS AS IDENTITY
        primary key,
    PERMISSION_NAME      VARCHAR(10485760)
);

create table TROLE_SERVER_PERMISSION
(
    ID_ROLE_SERVER_PERMISSION INTEGER GENERATED ALWAYS AS IDENTITY
        primary key,
    ID_ROLENAME               INTEGER
        constraint FK_TROLE_SERVER_PERMISSION
            references TROLE,
    ID_SERVER_PERMISSION      INTEGER
        constraint FK_TSERVER_PERMISSION
            references TSERVER_PERMISSION
);

create table TSETTING
(
    ID_SETTING      INTEGER GENERATED ALWAYS AS IDENTITY
        primary key,
    SETTING_KEY     VARCHAR(10485760),
    SETTING_VALUE   VARCHAR(10485760),
    SETTING_COMMENT VARCHAR(10485760)
);

create table TUSER
(
    USER_              VARCHAR(50) not null
        primary key,
    PASSWORD           VARCHAR(50),
    NAME               VARCHAR(50),
    SURNAME            VARCHAR(50),
    EMAIL              VARCHAR(50),
    NIF                VARCHAR(50),
    USERBLOCKED        TIMESTAMP,
    LASTPASSWORDUPDATE TIMESTAMP default CURRENT_TIMESTAMP,
    FIRSTLOGIN         BOOLEAN   default TRUE
);

create table TUSER_PREFERENCE
(
    ID_USER_PREFERENCE INTEGER GENERATED ALWAYS AS IDENTITY
        primary key,
    PREFERENCE_NAME    VARCHAR(150),
    USER_LOGIN         VARCHAR(150),
    PREFERENCE_VALUE   VARCHAR(10485760)
);

create table TUSER_ROLE
(
    ID_USER_ROLE INTEGER GENERATED ALWAYS AS IDENTITY
        primary key,
    ID_ROLENAME  INTEGER
        constraint FK_TROLE
            references TROLE,
    USER_        VARCHAR(50)
        constraint FK_TUSER
            references TUSER
);




INSERT INTO TI18N (ID_I18N, CLASS_NAME, I18N_DESCRIPTION) OVERRIDING SYSTEM VALUE VALUES (0, 'i18n.bundle', 'Resource bundle in database');

INSERT INTO TROLE (ID_ROLENAME, ROLENAME, XMLCLIENTPERMISSION) OVERRIDING SYSTEM VALUE VALUES (0, 'admin', '<?xml version="1.0" encoding="UTF-8"?><security></security>');


INSERT INTO TSERVER_PERMISSION (ID_SERVER_PERMISSION, PERMISSION_NAME) OVERRIDING SYSTEM VALUE VALUES (0, 'com.ontimize.hr.api.core.service.IUserAndRoleService/userQuery');
INSERT INTO TSERVER_PERMISSION (ID_SERVER_PERMISSION, PERMISSION_NAME) OVERRIDING SYSTEM VALUE VALUES (1, 'com.ontimize.jee.common.services.user.IUserInformationService/getUserInformation');
INSERT INTO TSERVER_PERMISSION (ID_SERVER_PERMISSION, PERMISSION_NAME) OVERRIDING SYSTEM VALUE VALUES (2, 'com.ontimize.jee.common.services.mail.IMailService/sendMail');
INSERT INTO TSERVER_PERMISSION (ID_SERVER_PERMISSION, PERMISSION_NAME) OVERRIDING SYSTEM VALUE VALUES (3, 'com.ontimize.jee.common.services.mail.IMailService/sendMailWithoutAttach');
INSERT INTO TSERVER_PERMISSION (ID_SERVER_PERMISSION, PERMISSION_NAME) OVERRIDING SYSTEM VALUE VALUES (4, 'com.ontimize.jee.common.services.i18n.II18nService/getAvailableBundles');
INSERT INTO TSERVER_PERMISSION (ID_SERVER_PERMISSION, PERMISSION_NAME) OVERRIDING SYSTEM VALUE VALUES (5, 'com.ontimize.jee.common.services.i18n.II18nService/getBundle');
INSERT INTO TSERVER_PERMISSION (ID_SERVER_PERMISSION, PERMISSION_NAME) OVERRIDING SYSTEM VALUE VALUES (6, 'com.ontimize.jee.common.services.i18n.II18nService/getBundles');
INSERT INTO TSERVER_PERMISSION (ID_SERVER_PERMISSION, PERMISSION_NAME) OVERRIDING SYSTEM VALUE VALUES (7, 'com.ontimize.jee.common.services.i18n.II18nService/getAllResourceBundles');
INSERT INTO TSERVER_PERMISSION (ID_SERVER_PERMISSION, PERMISSION_NAME) OVERRIDING SYSTEM VALUE VALUES (8, 'com.ontimize.jee.common.services.i18n.II18nService/getAvailableLocales');
INSERT INTO TSERVER_PERMISSION (ID_SERVER_PERMISSION, PERMISSION_NAME) OVERRIDING SYSTEM VALUE VALUES (9, 'com.ontimize.jee.common.services.i18n.II18nService/updateBundleValues');
INSERT INTO TSERVER_PERMISSION (ID_SERVER_PERMISSION, PERMISSION_NAME) OVERRIDING SYSTEM VALUE VALUES (10, 'com.ontimize.jee.common.services.preferences.IRemoteApplicationPreferencesService/getPreference');
INSERT INTO TSERVER_PERMISSION (ID_SERVER_PERMISSION, PERMISSION_NAME) OVERRIDING SYSTEM VALUE VALUES (11, 'com.ontimize.jee.common.services.preferences.IRemoteApplicationPreferencesService/getDefaultPreference');
INSERT INTO TSERVER_PERMISSION (ID_SERVER_PERMISSION, PERMISSION_NAME) OVERRIDING SYSTEM VALUE VALUES (12, 'com.ontimize.jee.common.services.preferences.IRemoteApplicationPreferencesService/setPreference');
INSERT INTO TSERVER_PERMISSION (ID_SERVER_PERMISSION, PERMISSION_NAME) OVERRIDING SYSTEM VALUE VALUES (13, 'com.ontimize.jee.common.services.preferences.IRemoteApplicationPreferencesService/setDefaultPreference');
INSERT INTO TSERVER_PERMISSION (ID_SERVER_PERMISSION, PERMISSION_NAME) OVERRIDING SYSTEM VALUE VALUES (14, 'com.ontimize.jee.common.services.preferences.IRemoteApplicationPreferencesService/savePreferences');
INSERT INTO TSERVER_PERMISSION (ID_SERVER_PERMISSION, PERMISSION_NAME) OVERRIDING SYSTEM VALUE VALUES (15, 'com.ontimize.jee.common.services.preferences.IRemoteApplicationPreferencesService/loadPreferences');
INSERT INTO TSERVER_PERMISSION (ID_SERVER_PERMISSION, PERMISSION_NAME) OVERRIDING SYSTEM VALUE VALUES (16, 'com.ontimize.jee.common.services.i18n.II18nService/deleteBundleValues');

INSERT INTO TSETTING (ID_SETTING, SETTING_KEY, SETTING_VALUE, SETTING_COMMENT) OVERRIDING SYSTEM VALUE VALUES (0, 'mail_host', 'smtp.gmail.com', 'Host del servidor');
INSERT INTO TSETTING (ID_SETTING, SETTING_KEY, SETTING_VALUE, SETTING_COMMENT) OVERRIDING SYSTEM VALUE VALUES (1, 'mail_port', '587', 'Puerto del servidor de email');
INSERT INTO TSETTING (ID_SETTING, SETTING_KEY, SETTING_VALUE, SETTING_COMMENT) OVERRIDING SYSTEM VALUE VALUES (2, 'mail_protocol', 'smtp', 'Protocolo de env\u00edo de mails');
INSERT INTO TSETTING (ID_SETTING, SETTING_KEY, SETTING_VALUE, SETTING_COMMENT) OVERRIDING SYSTEM VALUE VALUES (3, 'mail_user', 'mi.mail@example.com', 'Usuario para el env\u00edo de mails');
INSERT INTO TSETTING (ID_SETTING, SETTING_KEY, SETTING_VALUE, SETTING_COMMENT) OVERRIDING SYSTEM VALUE VALUES (4, 'mail_password', 'mis_credenciales', 'Password del servidor de mail');
INSERT INTO TSETTING (ID_SETTING, SETTING_KEY, SETTING_VALUE, SETTING_COMMENT) OVERRIDING SYSTEM VALUE VALUES (5, 'mail_encoding', 'UTF-8', 'Codificaci\u00f3n de mails');
INSERT INTO TSETTING (ID_SETTING, SETTING_KEY, SETTING_VALUE, SETTING_COMMENT) OVERRIDING SYSTEM VALUE VALUES (6, 'mail_properties', 'mail.smtp.auth:true;mail.smtp.starttls.enable:true;', 'Propiedades de mails');
INSERT INTO TSETTING (ID_SETTING, SETTING_KEY, SETTING_VALUE, SETTING_COMMENT) OVERRIDING SYSTEM VALUE VALUES (7, 'report_folder', 'C:/applications/ontimize-boot-app/reports', 'Carpeta de las plantillas de report');

INSERT INTO TUSER (USER_, PASSWORD, NAME, SURNAME, EMAIL, NIF, USERBLOCKED, LASTPASSWORDUPDATE, FIRSTLOGIN) OVERRIDING SYSTEM VALUE VALUES ('demo', 'demouser', 'demo', 'demo', null, '44460713B', null, null, null);

INSERT INTO TUSER_PREFERENCE (ID_USER_PREFERENCE, PREFERENCE_NAME, USER_LOGIN, PREFERENCE_VALUE) OVERRIDING SYSTEM VALUE VALUES (0, 'user_preference', 'demo', 'Iw0KI1R1ZSBNYXkgMTYgMTI6NTc6MDYgQ0VTVCAyMDE3DQpkZW1vX2FwcF9zdGF0dXNfYmFyX3Zpc2libGU9eWVzDQpkZW1vX2FkanVzdF90cmVlX3NwYWNlPXRydWUNCmRlbW9fYXBwX3dpbmRvd19zdGF0ZT0wDQpkZW1vX3RhYmxlX2NvbmZfc29ydF9maWx0ZXJfZm9ybUN1c3RvbWVyLnhtbF9DdXN0b21lclNlcnZpY2UuY3VzdG9tZXJfVEVTVD1udWxsO251bGw7U1VSTkFNRVw9OThcOjF8SURcPTc1XDoyfE5BTUVcPTk5XDozfENVU1RPTUVSVFlQRUlEXD0wXDo0fENVU1RPTUVSSURcPTEyNVw6NXxBRERSRVNTXD0xMjNcOjZ8UEhPTkVcPTEyMVw6N3xTVEFSVERBVEVcPTEzNlw6OHxMT05HSVRVREVcPTExNlw6OXxMQVRJVFVERVw9MTEzXDoxMHxFTUFJTFw9MTcwXDoxMnw7QkFTRTY0ck8wQUJYTnlBQk5xWVhaaExuVjBhV3d1U0dGemFIUmhZbXhsRTdzUEpTRks1TGdEQUFKR0FBcHNiMkZrUm1GamRHOXlTUUFKZEdoeVpYTm9iMnhrZUhBL1FBQUFBQUFBQ0hjSUFBQUFDd0FBQUFCNA0KZGVtb190YWJsZV9jb25mX3NvcnRfZmlsdGVyX2NvbmZpZ3VyYXRpb25zX2Zvcm1DdXN0b21lci54bWxfQ3VzdG9tZXJTZXJ2aWNlLmN1c3RvbWVyPVRFU1QNCmRlbW9fdGFibGVfY29udHJvbF9wYW5lbF9mb3JtQWNjb3VudHMtZGV0YWlsLnhtbF9Nb3ZlbWVudFNlcnZpY2UubW92ZW1lbnQ9Z3JvdXB0YWJsZWtleTtkZWZhdWx0Y2hhcnRidXR0b247ZXhjZWxleHBvcnRidXR0b247c3Vtcm93YnV0dG9uO2NhbGN1bGVkY29sc2J1dHRvbjtwcmludGluZ2J1dHRvbjtmaWx0ZXJzYXZlYnV0dG9uO3Zpc2libGVjb2xzYnV0dG9uO2h0bWxleHBvcnRidXR0b247Y29weWJ1dHRvbjtncm91cHRhYmxla2V5O2luc2VydGJ1dHRvbjtyZWZyZXNoYnV0dG9uDQpkZW1vX2Zvcm1CcmFuY2hlcy1kZXRhaWwueG1sPTg4MDs1MDU7LTExNTA7MzY5DQpkZW1vX2RldGFpbF9kaWFsb2dfc2l6ZV9wb3NpdGlvbl9mb3JtQ3VzdG9tZXIueG1sX0N1c3RvbWVyU2VydmljZS5jdXN0b21lcj03NDk7MzUwOy0xOTA1OzM5MQ0KZGVtb19hcHBfdG9vbGJhcl9sb2NhdGlvbj1Ob3J0aA0KZGVtb19hcHBfd2luZG93X3Bvc2l0aW9uPS0xNTgwOzExDQpkZW1vX2FwcF93aW5kb3dfc2l6ZT0xNTg0OzEwNDQNCmRlbW9fZm9ybUVtcGxveWVlcy1kZXRhaWwueG1sPTExMTY7NzM5OzYxMDsxOTUNCmRlbW9fZm9ybUFjY291bnRzLWRldGFpbC54bWw9OTE1OzUwMDstMTE1MDszNjkNCg==');

INSERT INTO TUSER_ROLE (ID_USER_ROLE, ID_ROLENAME, USER_) OVERRIDING SYSTEM VALUE VALUES (0, 0, 'demo');


INSERT INTO TROLE_SERVER_PERMISSION (ID_ROLE_SERVER_PERMISSION, ID_ROLENAME, ID_SERVER_PERMISSION) OVERRIDING SYSTEM VALUE VALUES (0, 0, 0);
INSERT INTO TROLE_SERVER_PERMISSION (ID_ROLE_SERVER_PERMISSION, ID_ROLENAME, ID_SERVER_PERMISSION) OVERRIDING SYSTEM VALUE VALUES (1, 0, 1);
INSERT INTO TROLE_SERVER_PERMISSION (ID_ROLE_SERVER_PERMISSION, ID_ROLENAME, ID_SERVER_PERMISSION) OVERRIDING SYSTEM VALUE VALUES (2, 0, 2);
INSERT INTO TROLE_SERVER_PERMISSION (ID_ROLE_SERVER_PERMISSION, ID_ROLENAME, ID_SERVER_PERMISSION) OVERRIDING SYSTEM VALUE VALUES (3, 0, 3);
INSERT INTO TROLE_SERVER_PERMISSION (ID_ROLE_SERVER_PERMISSION, ID_ROLENAME, ID_SERVER_PERMISSION) OVERRIDING SYSTEM VALUE VALUES (4, 0, 4);
INSERT INTO TROLE_SERVER_PERMISSION (ID_ROLE_SERVER_PERMISSION, ID_ROLENAME, ID_SERVER_PERMISSION) OVERRIDING SYSTEM VALUE VALUES (5, 0, 5);
INSERT INTO TROLE_SERVER_PERMISSION (ID_ROLE_SERVER_PERMISSION, ID_ROLENAME, ID_SERVER_PERMISSION) OVERRIDING SYSTEM VALUE VALUES (6, 0, 6);
INSERT INTO TROLE_SERVER_PERMISSION (ID_ROLE_SERVER_PERMISSION, ID_ROLENAME, ID_SERVER_PERMISSION) OVERRIDING SYSTEM VALUE VALUES (7, 0, 7);
INSERT INTO TROLE_SERVER_PERMISSION (ID_ROLE_SERVER_PERMISSION, ID_ROLENAME, ID_SERVER_PERMISSION) OVERRIDING SYSTEM VALUE VALUES (8, 0, 8);
INSERT INTO TROLE_SERVER_PERMISSION (ID_ROLE_SERVER_PERMISSION, ID_ROLENAME, ID_SERVER_PERMISSION) OVERRIDING SYSTEM VALUE VALUES (9, 0, 9);
INSERT INTO TROLE_SERVER_PERMISSION (ID_ROLE_SERVER_PERMISSION, ID_ROLENAME, ID_SERVER_PERMISSION) OVERRIDING SYSTEM VALUE VALUES (10, 0, 10);
INSERT INTO TROLE_SERVER_PERMISSION (ID_ROLE_SERVER_PERMISSION, ID_ROLENAME, ID_SERVER_PERMISSION) OVERRIDING SYSTEM VALUE VALUES (11, 0, 11);
INSERT INTO TROLE_SERVER_PERMISSION (ID_ROLE_SERVER_PERMISSION, ID_ROLENAME, ID_SERVER_PERMISSION) OVERRIDING SYSTEM VALUE VALUES (12, 0, 12);
INSERT INTO TROLE_SERVER_PERMISSION (ID_ROLE_SERVER_PERMISSION, ID_ROLENAME, ID_SERVER_PERMISSION) OVERRIDING SYSTEM VALUE VALUES (13, 0, 13);
INSERT INTO TROLE_SERVER_PERMISSION (ID_ROLE_SERVER_PERMISSION, ID_ROLENAME, ID_SERVER_PERMISSION) OVERRIDING SYSTEM VALUE VALUES (14, 0, 14);
INSERT INTO TROLE_SERVER_PERMISSION (ID_ROLE_SERVER_PERMISSION, ID_ROLENAME, ID_SERVER_PERMISSION) OVERRIDING SYSTEM VALUE VALUES (15, 0, 15);
INSERT INTO TROLE_SERVER_PERMISSION (ID_ROLE_SERVER_PERMISSION, ID_ROLENAME, ID_SERVER_PERMISSION) OVERRIDING SYSTEM VALUE VALUES (16, 0, 16);