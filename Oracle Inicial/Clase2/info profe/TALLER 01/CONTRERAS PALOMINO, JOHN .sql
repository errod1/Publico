/*1*/
CREATE TABLESPACE TBS_COMERCIAL
DATAFILE 'C:\PRACTICA\DF_COMERCIAL_01.DBF'
SIZE 15M;

CREATE TABLESPACE TBS_FINANZAS
DATAFILE 'C:\PRACTICA\DF_FINANZAS_01.DBF'
SIZE 10M;

ALTER TABLESPACE TBS_FINANZAS
ADD DATAFILE 'C:\PRACTICA\DF_FINANZAS_02.DBF'
SIZE 10M;

CREATE TABLESPACE TBS_CONTABILIDAD
DATAFILE 'C:\PRACTICA\DF_CONTABILIDAD.DBF'
SIZE 10M;

CREATE TABLESPACE TBS_LOGISTICA
DATAFILE 'C:\PRACTICA\DF_LOGISTICA_01.DBF'
SIZE 10M;

ALTER TABLESPACE TBS_LOGISTICA
ADD DATAFILE 'C:\PRACTICA\DF_LOGISTICA_02.DBF'
SIZE 10M;


/*2*/
ALTER TABLESPACE TBS_CONTABILIDAD
ADD DATAFILE 'C:\PRACTICA\DF_CONTABILIDAD_02.DBF'
SIZE 15M;

/*3*/
ALTER DATABASE 
DATAFILE 'C:\PRACTICA\DF_COMERCIAL_01.DBF'
RESIZE 25M;

/*4*/
CREATE TABLE PEDIDOS 
( IDPEDIDO NUMBER(10),
  FECHA DATE,
  REFERENCIA CHAR(100))
TABLESPACE TBS_LOGISTICA;

/*5*/
INSERT INTO PEDIDOS
SELECT LEVEL ,SYSDATE, 'REFERENCIA ' || LEVEL
FROM DUAL CONNECT BY LEVEL <= 10000;

/*6*/
DROP TABLESPACE TBS_CONTABILIDAD
INCLUDING CONTENTS AND DATAFILES;

SELECT * FROM DBA_TABLESPACES;

/*7*/
ALTER TABLESPACE TBS_LOGISTICA OFFLINE;
SELECT * FROM PEDIDOS;
/*Rpta: No me permite acceder a los datos de la tabla PEDIDO porque se deshabilito el acceso al TABLESPACE que contiene al DATAFILE de la misma*/

/*8*/
ALTER TABLESPACE TBS_LOGISTICA ONLINE;
SELECT * FROM PEDIDOS;


/*consulta*/
SELECT * FROM DBA_TABLESPACES;
SELECT FILE#, NAME FROM V$DATAFILE;    