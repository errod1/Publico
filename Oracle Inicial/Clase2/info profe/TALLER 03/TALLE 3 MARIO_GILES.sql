

----------taller 03-------

CREATE TABLE AFP (
       CODAFP               NUMBER(4) NOT NULL,
       DESCRIPCION          VARCHAR2(50) NULL,
       COMISION_FIJA        NUMBER(15,3) NULL,
       COMISION_VARIABLE    NUMBER(15,3) NULL,
       ESTADO               CHAR(1) NULL
);


ALTER TABLE AFP
       ADD  ( PRIMARY KEY (CODAFP) ) ;


CREATE TABLE AREA (
       CODAREA              NUMBER(4) NOT NULL,
       DESCRIPCION          VARCHAR2(40) NULL,
       ES_PRODUCCION        CHAR(1) NULL,
       ESTADO               CHAR(1) NULL
);


ALTER TABLE AREA
       ADD  ( PRIMARY KEY (CODAREA) ) ;


CREATE TABLE PLANILLA (
       CODPLANILLA          NUMBER NOT NULL,
       CODTRABAJADOR        NUMBER(4) NULL,
       ANNO                 NUMBER NULL,
       MES                  NUMBER NULL,
       BASICO               NUMBER(20,3) NULL,
       HRS_LAB              NUMBER(10,2) NULL,
       HRS_EXT              NUMBER(10,2) NULL,
       BASICO_CALCULADO     NUMBER(15,3) NULL,
       PAGO_HRS_EXTRAS      NUMBER(10,2) NULL,
       BONIFICACION         NUMBER(15,3) NULL,
       TOTAL_INGRESO        NUMBER(15,3) NULL,
       PRESTAMO             NUMBER(10,2) NULL,
       AFP_COMFIJA          NUMBER(20,2) NULL,
       AFP_COMVAR           NUMBER(15,2) NULL,
       FONDO                NUMBER(10,2) NULL,
       TOTAL_DSCTO          NUMBER(15,2) NULL,
       TOTAL_PAGO           NUMBER(10,2) NULL
);


ALTER TABLE PLANILLA
       ADD  ( PRIMARY KEY (CODPLANILLA) ) ;


CREATE TABLE PRESTAMOS (
       CODPRESTAMO          NUMBER(4) NOT NULL,
       CODTRABAJADOR        NUMBER(4) NULL,
       ANNO                 NUMBER NULL,
       MES                  NUMBER NULL,
       FECHA                DATE NULL,
       MONTO                NUMBER(15,3) NULL,
       ESTADO               CHAR(1) NULL
);


ALTER TABLE PRESTAMOS
       ADD  ( PRIMARY KEY (CODPRESTAMO) ) ;


CREATE TABLE REG_HRS_LABORADAS (
       CODREGHRS            NUMBER NOT NULL,
       CODTRABAJADOR        NUMBER(4) NOT NULL,
       NANNO                NUMBER NULL,
       NMES                 INTEGER NULL,
       HRS_LABORADAS        NUMBER(15,2) NULL,
       HRS_EXTRAS           NUMBER(15,3) NULL,
       ESTADO               CHAR(1) NULL
);


ALTER TABLE REG_HRS_LABORADAS
       ADD  ( PRIMARY KEY (CODREGHRS) ) ;


CREATE TABLE RPTBANCO (
       CODRPTBANCO          NUMBER NOT NULL,
       CODPLANILLA          NUMBER NULL,
       CODTRABAJADOR        NUMBER NULL,
       ANNO                 NUMBER NULL,
       MES                  NUMBER NULL,
       CTABANCO             VARCHAR2(20) NULL,
       DEPOSITO             NUMBER(10,2) NULL,
       ESTADO               VARCHAR2(1) NULL
);


ALTER TABLE RPTBANCO
       ADD  ( PRIMARY KEY (CODRPTBANCO) ) ;

DROP TABLE TRABAJADORES;

CREATE TABLE TRABAJADORES (
       CODTRABAJADOR        NUMBER(4) PRIMARY KEY,
       CODAFP               NUMBER(4) NULL,
       CODAREA              NUMBER(4) NULL,
       PATERNO              VARCHAR2(50) NULL,
       MATERNO              VARCHAR2(50) NULL,
       NOMBRE               VARCHAR2(50) NULL,
       TIPO                 VARCHAR2(1) NULL,
       CTABANCO             CHAR(20) NULL,
       BASICO               NUMBER(15,3) NULL,
       ESTADO               CHAR(1) NULL
);

--------taller 03--------
ALTER TABLE RPTBANCO
ADD CONSTRAINT FK_RPTBANCO_PLANILLA
FOREIGN KEY(CODPLANILLA)
REFERENCES PLANILLA (CODPLANILLA);

ALTER TABLE PLANILLA
ADD CONSTRAINT FK_PLANILLA_TRABAJADORES
FOREIGN KEY(CODTRABAJADOR)
REFERENCES TRABAJADORES (CODTRABAJADOR);

ALTER TABLE PRESTAMOS
ADD CONSTRAINT FK_PRESTAMOS_TRABAJADORES
FOREIGN KEY(CODTRABAJADOR)
REFERENCES TRABAJADORES (CODTRABAJADOR);

ALTER TABLE TRABAJADORES
ADD CONSTRAINT FK_TRABAJADORES_AREA
FOREIGN KEY(CODAREA)
REFERENCES AREA (CODAREA);

ALTER TABLE TRABAJADORES
ADD CONSTRAINT FK_TRABAJADORES_AFP
FOREIGN KEY(CODAFP)
REFERENCES AFP (CODAFP);

ALTER TABLE REG_HRS_LABORADAS
ADD CONSTRAINT FK_REG_HRS_LABORADAS_TRABAJADORES
FOREIGN KEY(CODTRABAJADOR)
REFERENCES TRABAJADORES (CODTRABAJADOR);
