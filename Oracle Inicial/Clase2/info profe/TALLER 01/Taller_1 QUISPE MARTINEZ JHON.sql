
----------------------------------
-- PREGUNTA 1 
----------------------------------
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
DATAFILE 'C:\PRACTICA\DF_CONTABILIDAD_01.DBF'
SIZE 10M;

CREATE TABLESPACE TBS_LOGISTICA
DATAFILE 'C:\PRACTICA\DF_LOGISTICA_01.DBF'
SIZE 10M;

ALTER TABLESPACE TBS_LOGISTICA
ADD DATAFILE 'C:\PRACTICA\DF_LOGISTICA_02.DBF'
SIZE 10M;

----------------------------------
-- PREGUNTA 2 
----------------------------------
ALTER TABLESPACE TBS_CONTABILIDAD
ADD DATAFILE 'C:\PRACTICA\DF_CONTABILIDAD_02.DBF'
SIZE 15M;

----------------------------------
-- PREGUNTA 3
----------------------------------
ALTER DATABASE 
DATAFILE 'C:\PRACTICA\DF_COMERCIAL_01.DBF'
RESIZE 25M;


----------------------------------
-- PREGUNTA 4 
----------------------------------
CREATE TABLE PEDIDOS
( IDPEDIDO NUMBER(10),
  FECHA DATE, 
  REFERENCIA CHAR(100))
TABLESPACE TBS_LOGISTICA;

----------------------------------
-- PREGUNTA 5
----------------------------------
INSERT INTO PEDIDOS
SELECT LEVEL , SYSDATE, 'REF_' || LEVEL
FROM DUAL CONNECT BY LEVEL <= 10000;

SELECT /* + RULE */  df.tablespace_name "Tablespace",
       df.bytes / (1024 * 1024) "Size (MB)",
       SUM(fs.bytes) / (1024 * 1024) "Free (MB)",
       Nvl(Round(SUM(fs.bytes) * 100 / df.bytes),1) "% Free",
       Round((df.bytes - SUM(fs.bytes)) * 100 / df.bytes) "% Used"
  FROM dba_free_space fs,
       (SELECT tablespace_name,SUM(bytes) bytes
          FROM dba_data_files
         GROUP BY tablespace_name) df
 WHERE fs.tablespace_name (+)  = df.tablespace_name
 GROUP BY df.tablespace_name,df.bytes
UNION ALL
SELECT /* + RULE */ df.tablespace_name tspace,
       fs.bytes / (1024 * 1024),
       SUM(df.bytes_free) / (1024 * 1024),
       Nvl(Round((SUM(fs.bytes) - df.bytes_used) * 100 / fs.bytes), 1),
       Round((SUM(fs.bytes) - df.bytes_free) * 100 / fs.bytes)
  FROM dba_temp_files fs,
       (SELECT tablespace_name,bytes_free,bytes_used
          FROM v$temp_space_header
         GROUP BY tablespace_name,bytes_free,bytes_used) df
 WHERE fs.tablespace_name (+)  = df.tablespace_name
 GROUP BY df.tablespace_name,fs.bytes,df.bytes_free,df.bytes_used
 ORDER BY 4 DESC;

----------------------------------
-- PREGUNTA 6
----------------------------------
DROP TABLESPACE TBS_CONTABILIDAD
INCLUDING CONTENTS AND DATAFILES;

SELECT * FROM TBS_CONTABILIDAD;

----------------------------------
-- PREGUNTA 7
----------------------------------
ALTER TABLESPACE TBS_LOGISTICA OFFLINE;

SELECT * FROM PEDIDOS;

----------------------------------
-- PREGUNTA 8 
----------------------------------

ALTER TABLESPACE TBS_LOGISTICA ONLINE;

SELECT * FROM PEDIDOS;

SELECT * FROM DBA_TABLES;









