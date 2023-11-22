/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     2/11/2023 8:06:15 a. m.                      */
/*==============================================================*/



-- Type package declaration
create or replace package PDTypes  
as
    TYPE ref_cursor IS REF CURSOR;
end;

-- Integrity package declaration
create or replace package IntegrityPackage AS
 procedure InitNestLevel;
 function GetNestLevel return number;
 procedure NextNestLevel;
 procedure PreviousNestLevel;
 end IntegrityPackage;
/

-- Integrity package definition
create or replace package body IntegrityPackage AS
 NestLevel number;

-- Procedure to initialize the trigger nest level
 procedure InitNestLevel is
 begin
 NestLevel := 0;
 end;


-- Function to return the trigger nest level
 function GetNestLevel return number is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 return(NestLevel);
 end;

-- Procedure to increase the trigger nest level
 procedure NextNestLevel is
 begin
 if NestLevel is null then
     NestLevel := 0;
 end if;
 NestLevel := NestLevel + 1;
 end;

-- Procedure to decrease the trigger nest level
 procedure PreviousNestLevel is
 begin
 NestLevel := NestLevel - 1;
 end;

 end IntegrityPackage;
/


drop trigger TIB_CLIENTE
/

drop trigger TIB_CUENTA
/

drop trigger TUB_CUENTA
/

drop trigger TIB_CUENTA_LOGS
/

drop trigger TIB_TELEFONOS
/

alter table CLIENTE
   drop constraint FK_CLIENTE_REF_TIPO_CLIENTE
/

alter table CUENTA
   drop constraint FK_CUENTA_REF_CLIENTE
/

alter table CUENTA_LOGS
   drop constraint FK_CUENTA_LOGS_REF_CUENTA
/

alter table DIRECCIONES
   drop constraint FK_DIRECCION_REF_CLIENTE
/

alter table EMAILS
   drop constraint FK_EMAILS_REF_CLIENTE
/

alter table TELEFONOS
   drop constraint FK_TELEFONO_REF_CLIENTE
/

alter table TELEFONOS
   drop constraint FK_TELEFONO_REF_TIPO_TEL
/

alter table CLIENTE
   drop primary key cascade
/

drop table CLIENTE cascade constraints
/

alter table CUENTA
   drop primary key cascade
/

drop table CUENTA cascade constraints
/

alter table CUENTA_LOGS
   drop primary key cascade
/

drop table CUENTA_LOGS cascade constraints
/

alter table DIRECCIONES
   drop primary key cascade
/

drop table DIRECCIONES cascade constraints
/

alter table EMAILS
   drop primary key cascade
/

drop table EMAILS cascade constraints
/

alter table TELEFONOS
   drop primary key cascade
/

drop table TELEFONOS cascade constraints
/

alter table TIPO_CLIENTE
   drop primary key cascade
/

drop table TIPO_CLIENTE cascade constraints
/

alter table TIPO_TELEFONO
   drop primary key cascade
/

drop table TIPO_TELEFONO cascade constraints
/

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   ID                   NUMERIC(20)           not null,
   TIPO_CLIENTE_ID      VARCHAR(2)            not null,
   NOMBRE               VARCHAR(40)           not null,
   APELLIDOS            VARCHAR(40)           not null
)
/

alter table CLIENTE
   add constraint PK_CLIENTE primary key (ID)
/

/*==============================================================*/
/* Table: CUENTA                                                */
/*==============================================================*/
create table CUENTA (
   ID                   NUMBER(10)            not null
      generated as identity ( start with 1 nocycle noorder),
   CLIENTE_ID           NUMBER(10)            not null,
   FECHA_REGISTRO       TIMESTAMP WITH TIME ZONE  not null,
   FECHA_ACTUALIZACION  TIMESTAMP WITH TIME ZONE,
   SALDO                DECIMAL(12, 2)        not null,
   USUARIO              VARCHAR(10),
   IP                   VARCHAR(15)
)
/

alter table CUENTA
   add constraint PK_CUENTA primary key (ID)
/

/*==============================================================*/
/* Table: CUENTA_LOGS                                           */
/*==============================================================*/
create table CUENTA_LOGS (
   ID                   NUMERIC(20)           not null
      generated as identity ( start with 1 nocycle noorder),
   FECHA_HORA           TIMESTAMP WITH TIME ZONE,
   CUENTA_ID            NUMBER(10)            not null,
   FECHA_REGISTRO       TIMESTAMP WITH TIME ZONE  not null,
   FECHA_ACTUALIZACIO   TIMESTAMP WITH TIME ZONE,
   SALDO                DECIMAL(12, 2)        not null,
   USUARIO              VARCHAR(10),
   IP                   VARCHAR(15)
)
/

alter table CUENTA_LOGS
   add constraint PK_CUENTA_LOGS primary key (ID)
/

/*==============================================================*/
/* Table: DIRECCIONES                                           */
/*==============================================================*/
create table DIRECCIONES (
   ID                   NUMBER(10)            not null,
   CLIENTE_ID           NUMBER(10)            not null,
   DIRECCION            VARCHAR(30)           not null
)
/

alter table DIRECCIONES
   add constraint PK_DIRECCIONES primary key (ID)
/

/*==============================================================*/
/* Table: EMAILS                                                */
/*==============================================================*/
create table EMAILS (
   ID                   NUMBER(10)            not null,
   CLIENTE_ID           NUMBER(10)            not null,
   EMAIL                VARCHAR(50)           not null
)
/

alter table EMAILS
   add constraint PK_EMAILS primary key (ID)
/

/*==============================================================*/
/* Table: TELEFONOS                                             */
/*==============================================================*/
create table TELEFONOS (
   ID                   NUMBER(10)            not null
      generated as identity ( start with 1 nocycle noorder),
   CLIENTE_ID           NUMBER(10)            not null,
   TIPO_TELEFONO_ID     VARCHAR(2)            not null,
   TELEFONO             VARCHAR(20)           not null
)
/

alter table TELEFONOS
   add constraint PK_TELEFONOS primary key (ID)
/

/*==============================================================*/
/* Table: TIPO_CLIENTE                                          */
/*==============================================================*/
create table TIPO_CLIENTE (
   ID                   VARCHAR(2)            not null,
   NOMBRE               VARCHAR(20)           not null
)
/

alter table TIPO_CLIENTE
   add constraint PK_TIPO_CLIENTE primary key (ID)
/

/*==============================================================*/
/* Table: TIPO_TELEFONO                                         */
/*==============================================================*/
create table TIPO_TELEFONO (
   ID                   VARCHAR(2)            not null,
   NOMBRE               VARCHAR(20)           not null
)
/

alter table TIPO_TELEFONO
   add constraint PK_TIPO_TELEFONO primary key (ID)
/

alter table CLIENTE
   add constraint FK_CLIENTE_REF_TIPO_CLIENTE foreign key (TIPO_CLIENTE_ID)
      references TIPO_CLIENTE (ID)
/

alter table CUENTA
   add constraint FK_CUENTA_REF_CLIENTE foreign key (CLIENTE_ID)
      references CLIENTE (ID)
/

alter table CUENTA_LOGS
   add constraint FK_CUENTA_LOGS_REF_CUENTA foreign key (CUENTA_ID)
      references CUENTA (ID)
/

alter table DIRECCIONES
   add constraint FK_DIRECCION_REF_CLIENTE foreign key (CLIENTE_ID)
      references CLIENTE (ID)
/

alter table EMAILS
   add constraint FK_EMAILS_REF_CLIENTE foreign key (CLIENTE_ID)
      references CLIENTE (ID)
/

alter table TELEFONOS
   add constraint FK_TELEFONO_REF_CLIENTE foreign key (CLIENTE_ID)
      references CLIENTE (ID)
/

alter table TELEFONOS
   add constraint FK_TELEFONO_REF_TIPO_TEL foreign key (TIPO_TELEFONO_ID)
      references TIPO_TELEFONO (ID)
/


create trigger TIB_CLIENTE before insert
on CLIENTE for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "ID" uses sequence CLIENTE_SEQ
    select CLIENTE_SEQ.NEXTVAL INTO :new.ID from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_CUENTA before insert
on CUENTA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "ID" uses sequence CUENTA_SEQ
    select CUENTA_SEQ.NEXTVAL INTO :new.ID from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TUB_CUENTA before update
of ID,
   CLIENTE_ID
on CUENTA for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;
    seq NUMBER;

begin
    --  Non modifiable column "ID" cannot be modified
    if updating('ID') and :old.ID != :new.ID then
       errno  := -20001;
       errmsg := 'Non modifiable column "ID" cannot be modified.';
       raise integrity_error;
    end if;

    seq := IntegrityPackage.GetNestLevel;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_CUENTA_LOGS before insert
on CUENTA_LOGS for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "ID" uses sequence CUENTA_LOGS_SEQ
    select CUENTA_LOGS_SEQ.NEXTVAL INTO :new.ID from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/


create trigger TIB_TELEFONOS before insert
on TELEFONOS for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "ID" uses sequence TELEFONOS_SEQ
    select TELEFONOS_SEQ.NEXTVAL INTO :new.ID from dual;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

