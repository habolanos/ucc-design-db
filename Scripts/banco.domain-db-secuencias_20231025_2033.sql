/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     2/11/2023 7:39:54 a. m.                      */
/*==============================================================*/


drop sequence CLIENTE_SEQ;

drop sequence CUENTA_LOGS_SEQ;

drop sequence CUENTA_SEQ;

drop sequence TELEFONOS_SEQ;

create sequence CLIENTE_SEQ
increment by 1
start with 0
 nomaxvalue
 minvalue 0
nocycle
 nocache
order;

create sequence CUENTA_LOGS_SEQ
increment by 1
start with 0
 nomaxvalue
 minvalue 0
nocycle
 nocache
order;

create sequence CUENTA_SEQ
increment by 1
start with 0
 nomaxvalue
 minvalue 0
nocycle
 nocache
order;

create sequence TELEFONOS_SEQ
increment by 1
start with 0
 nomaxvalue
 minvalue 0
 nocache
order;

