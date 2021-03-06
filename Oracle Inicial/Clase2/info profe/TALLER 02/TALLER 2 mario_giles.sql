

----------------------------------
-- 1. CREACION DE TBS
----------------------------------
  CREATE TABLESPACE TBS_AUTOS
  DATAFILE 'C:\TEMP\DF_AUTOS.DBF'
  SIZE 30M;
  
  CREATE TABLESPACE TBS_CAMIONETAS
  DATAFILE 'C:\TEMP\DF_CAMIONETAS.DBF'
  SIZE 30M;
  
  CREATE TABLESPACE TBS_BUSES
  DATAFILE 'C:\TEMP\DF_BUSES.DBF'
  SIZE 30M;
  
 CREATE TABLESPACE TBS_CAMIONES
  DATAFILE 'C:\TEMP\DF_CAMIONES.DBF'
  SIZE 30M;

----------------------------------
-- 2. TABLA PARTICIONADA POR LISTA
----------------------------------

CREATE TABLE VEHICULOS
(ID NUMBER(10),
 TIPO VARCHAR2(10),
 A�O INTEGER,
 PLACA VARCHAR2 (10) default sysdate )

PARTITION BY LIST( TIPO)

(PARTITION VEHICULOS_AUTOS  VALUES('AUTOS')    tablespace TBS_AUTOS,
 PARTITION VEHICULOS_CAMIONETAS VALUES ('CAMIONETAS') tablespace TBS_CAMIONETAS,
 PARTITION VEHICULOS_BUSES     VALUES ('BUSES')     tablespace TBS_BUSES,
 PARTITION VEHICULOS_CAMIONES  VALUES('CAMIONES')   tablespace TBS_CAMIONES );

-------------------------------------------------
-- 3 INSERTANDO DATOS EN TABLAS PARTICIONADAS
-------------------------------------------------

INSERT INTO VEHICULOS
SELECT LEVEL, 'AUTOS',2017,'PL_'||LEVEL
FROM DUAL CONNECT BY LEVEL < 15000;
 
INSERT INTO VEHICULOS
SELECT LEVEL, 'BUSES', SYSDATE
FROM DUAL CONNECT BY LEVEL < 25000;

COMMIT;
