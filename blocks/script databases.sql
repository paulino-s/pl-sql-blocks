/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     30/6/2021 17:45:22                           */
/*==============================================================*/


alter table CITAS
   drop constraint FK_CITAS_RELATIONS_DATOS_CL;

alter table DATOS_CLINICA
   drop constraint FK_DATOS_CL_RELATIONS_LOGIN;

alter table DOCTORES
   drop constraint FK_DOCTORES_RELATIONS_DATOS_CL;

alter table DOCTORES_PACIENTE
   drop constraint FK_DOCTORES_RELATIONS_DOCTORES;

alter table DOCTORES_PACIENTE
   drop constraint FK_DOCTORES_RELATIONS_PACIENTE;

alter table ESTADISTICAS
   drop constraint FK_ESTADIST_RELATIONS_DATOS_CL;

alter table HISTORIAL
   drop constraint FK_HISTORIA_RELATIONS_PACIENTE;

alter table INGRESOS
   drop constraint FK_INGRESOS_RELATIONS_DATOS_CL;

alter table LOGIN
   drop constraint FK_LOGIN_RELATIONS_DATOS_CL;

alter table PACIENTE
   drop constraint FK_PACIENTE_RELATIONS_DATOS_CL;

alter table PACIENTE
   drop constraint FK_PACIENTE_RELATIONS_HISTORIA;

alter table SERVICIOS
   drop constraint FK_SERVICIO_RELATIONS_DATOS_CL;

drop index RELATIONSHIP_7_FK;

drop table CITAS cascade constraints;

drop index RELATIONSHIP_13_FK;

drop table DATOS_CLINICA cascade constraints;

drop index RELATIONSHIP_1_FK;

drop table DOCTORES cascade constraints;

drop index RELATIONSHIP_11_FK;

drop index RELATIONSHIP_10_FK;

drop table DOCTORES_PACIENTE cascade constraints;

drop index RELATIONSHIP_6_FK;

drop table ESTADISTICAS cascade constraints;

drop index RELATIONSHIP_3_FK;

drop table HISTORIAL cascade constraints;

drop index RELATIONSHIP_8_FK;

drop table INGRESOS cascade constraints;

drop index RELATIONSHIP_14_FK;

drop table LOGIN cascade constraints;

drop index RELATIONSHIP_12_FK;

drop index RELATIONSHIP_4_FK;

drop table PACIENTE cascade constraints;

drop index RELATIONSHIP_9_FK;

drop table SERVICIOS cascade constraints;

/*==============================================================*/
/* Table: CITAS                                                 */
/*==============================================================*/
create table CITAS 
(
   ID_REGISTRO          INTEGER              not null,
   ID_CLINICA           INTEGER,
   FECHA                DATE,
   HORA                 DATE,
   constraint PK_CITAS primary key (ID_REGISTRO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_7_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_7_FK on CITAS (
   ID_CLINICA ASC
);

/*==============================================================*/
/* Table: DATOS_CLINICA                                         */
/*==============================================================*/
create table DATOS_CLINICA 
(
   ID_CLINICA           INTEGER              not null,
   ID_LOGIN             INTEGER,
   NOMBRE_CLINICA       CHAR(100)            not null,
   DIRECCION            CHAR(100),
   TELEFONO             CHAR(100),
   EMAIL                CHAR(100),
   constraint PK_DATOS_CLINICA primary key (ID_CLINICA)
);

/*==============================================================*/
/* Index: RELATIONSHIP_13_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_13_FK on DATOS_CLINICA (
   ID_LOGIN ASC
);

/*==============================================================*/
/* Table: DOCTORES                                              */
/*==============================================================*/
create table DOCTORES 
(
   IDDOCTOR             INTEGER              not null,
   ID_CLINICA           INTEGER,
   NOMBRE               CHAR(100)            not null,
   APELLIDO             CHAR(100)            not null,
   ESPACIALIDAD         CHAR(100)            not null,
   EMAIL                CHAR(100),
   SEXO                 CHAR(100),
   TELEFONO             CHAR(100),
   constraint PK_DOCTORES primary key (IDDOCTOR)
);

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_1_FK on DOCTORES (
   ID_CLINICA ASC
);

/*==============================================================*/
/* Table: DOCTORES_PACIENTE                                     */
/*==============================================================*/
create table DOCTORES_PACIENTE 
(
   ID_PACIENTE_DOC      INTEGER              not null,
   IDDOCTOR             INTEGER,
   ID_PACIENTE          INTEGER,
   constraint PK_DOCTORES_PACIENTE primary key (ID_PACIENTE_DOC)
);

/*==============================================================*/
/* Index: RELATIONSHIP_10_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_10_FK on DOCTORES_PACIENTE (
   IDDOCTOR ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_11_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_11_FK on DOCTORES_PACIENTE (
   ID_PACIENTE ASC
);

/*==============================================================*/
/* Table: ESTADISTICAS                                          */
/*==============================================================*/
create table ESTADISTICAS 
(
   ID_ESTADISTICA       INTEGER              not null,
   ID_CLINICA           INTEGER,
   CANTIDAD_ATENDIDOS   INTEGER              not null,
   CANTIDAD_ALTA        INTEGER,
   constraint PK_ESTADISTICAS primary key (ID_ESTADISTICA)
);

/*==============================================================*/
/* Index: RELATIONSHIP_6_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_6_FK on ESTADISTICAS (
   ID_CLINICA ASC
);

/*==============================================================*/
/* Table: HISTORIAL                                             */
/*==============================================================*/
create table HISTORIAL 
(
   IDCLINICO            INTEGER              not null,
   ID_PACIENTE          INTEGER,
   SINTOMAS             CHAR(100)            not null,
   EXAMEN_CLINICO       CHAR(100)            not null,
   EXAMEN_FISICO        CHAR(100)            not null,
   TRATAMIENTOI_MEDICO  CHAR(100)            not null,
   constraint PK_HISTORIAL primary key (IDCLINICO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_3_FK on HISTORIAL (
   ID_PACIENTE ASC
);

/*==============================================================*/
/* Table: INGRESOS                                              */
/*==============================================================*/
create table INGRESOS 
(
   ID_INGRESO           INTEGER              not null,
   ID_CLINICA           INTEGER,
   CANTIDAD_PAGAR       NUMBER(8,2)          not null,
   CANTIDAD_HOSPITAL    NUMBER(8,2)          not null,
   FECHA                DATE,
   constraint PK_INGRESOS primary key (ID_INGRESO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_8_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_8_FK on INGRESOS (
   ID_CLINICA ASC
);

/*==============================================================*/
/* Table: LOGIN                                                 */
/*==============================================================*/
create table LOGIN 
(
   ID_LOGIN             INTEGER              not null,
   ID_CLINICA           INTEGER,
   USUARIO              CHAR(100)            not null,
   CONTRA               CHAR(100),
   constraint PK_LOGIN primary key (ID_LOGIN)
);

/*==============================================================*/
/* Index: RELATIONSHIP_14_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_14_FK on LOGIN (
   ID_CLINICA ASC
);

/*==============================================================*/
/* Table: PACIENTE                                              */
/*==============================================================*/
create table PACIENTE 
(
   ID_PACIENTE          INTEGER              not null,
   IDCLINICO            INTEGER,
   ID_CLINICA           INTEGER,
   NOMBRE               CHAR(100)            not null,
   APELLIDO             CHAR(100)            not null,
   EMAIL                CHAR(100),
   DUI                  CHAR(50)             not null,
   FECHA_NACIEMIENTO    DATE,
   TELEFONO             CHAR(100),
   DIRECCION            CHAR(100),
   constraint PK_PACIENTE primary key (ID_PACIENTE)
);

/*==============================================================*/
/* Index: RELATIONSHIP_4_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_4_FK on PACIENTE (
   IDCLINICO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_12_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_12_FK on PACIENTE (
   ID_CLINICA ASC
);

/*==============================================================*/
/* Table: SERVICIOS                                             */
/*==============================================================*/
create table SERVICIOS 
(
   ID_SERVICIO          INTEGER              not null,
   ID_CLINICA           INTEGER,
   NOMBRE_SERVICIOS     CHAR(150),
   constraint PK_SERVICIOS primary key (ID_SERVICIO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_9_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_9_FK on SERVICIOS (
   ID_CLINICA ASC
);

alter table CITAS
   add constraint FK_CITAS_RELATIONS_DATOS_CL foreign key (ID_CLINICA)
      references DATOS_CLINICA (ID_CLINICA);

alter table DATOS_CLINICA
   add constraint FK_DATOS_CL_RELATIONS_LOGIN foreign key (ID_LOGIN)
      references LOGIN (ID_LOGIN);

alter table DOCTORES
   add constraint FK_DOCTORES_RELATIONS_DATOS_CL foreign key (ID_CLINICA)
      references DATOS_CLINICA (ID_CLINICA);

alter table DOCTORES_PACIENTE
   add constraint FK_DOCTORES_RELATIONS_DOCTORES foreign key (IDDOCTOR)
      references DOCTORES (IDDOCTOR);

alter table DOCTORES_PACIENTE
   add constraint FK_DOCTORES_RELATIONS_PACIENTE foreign key (ID_PACIENTE)
      references PACIENTE (ID_PACIENTE);

alter table ESTADISTICAS
   add constraint FK_ESTADIST_RELATIONS_DATOS_CL foreign key (ID_CLINICA)
      references DATOS_CLINICA (ID_CLINICA);

alter table HISTORIAL
   add constraint FK_HISTORIA_RELATIONS_PACIENTE foreign key (ID_PACIENTE)
      references PACIENTE (ID_PACIENTE);

alter table INGRESOS
   add constraint FK_INGRESOS_RELATIONS_DATOS_CL foreign key (ID_CLINICA)
      references DATOS_CLINICA (ID_CLINICA);

alter table LOGIN
   add constraint FK_LOGIN_RELATIONS_DATOS_CL foreign key (ID_CLINICA)
      references DATOS_CLINICA (ID_CLINICA);

alter table PACIENTE
   add constraint FK_PACIENTE_RELATIONS_DATOS_CL foreign key (ID_CLINICA)
      references DATOS_CLINICA (ID_CLINICA);

alter table PACIENTE
   add constraint FK_PACIENTE_RELATIONS_HISTORIA foreign key (IDCLINICO)
      references HISTORIAL (IDCLINICO);

alter table SERVICIOS
   add constraint FK_SERVICIO_RELATIONS_DATOS_CL foreign key (ID_CLINICA)
      references DATOS_CLINICA (ID_CLINICA);

