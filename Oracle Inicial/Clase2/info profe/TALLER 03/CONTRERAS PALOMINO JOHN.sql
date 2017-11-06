--1. FK_TRABAJADORES_AREA
ALTER TABLE TRABAJADORES
ADD CONSTRAINT FK_TRABAJADORES_AREA
FOREIGN KEY (CODAREA) REFERENCES AREA(CODAREA);

--2. FK_TRABAJADORES_AFP
ALTER TABLE TRABAJADORES
ADD CONSTRAINT FK_TRABAJADORES_AFP
FOREIGN KEY (CODAFP) REFERENCES AFP(CODAFP);

--NOTA: AGREGANDO PK A LA TABLA TRABAJADORES
ALTER TABLE TRABAJADORES
ADD CONSTRAINT PK_CODTRABAJADOR
PRIMARY KEY (CODTRABAJADOR);

--3. FK_REG_HRS_LABORADAS_TRABAJADOR

ALTER TABLE REG_HRS_LABORADAS
ADD CONSTRAINT FK_REG_HRS_LABORADAS_TRABAJADOR
FOREIGN KEY (CODTRABAJADOR) REFERENCES TRABAJADORES(CODTRABAJADOR);

--4. FK_PRESTAMOS_TRABAJADOR
ALTER TABLE PRESTAMOS
ADD CONSTRAINT FK_PRESTAMOS_TRABAJADOR
FOREIGN KEY (CODTRABAJADOR) REFERENCES TRABAJADORES(CODTRABAJADOR);

--5. FK_PLANILLA_TRABAJADOR
ALTER TABLE PLANILLA
ADD CONSTRAINT FK_PLANILLA_TRABAJADOR
FOREIGN KEY (CODTRABAJADOR) REFERENCES TRABAJADORES(CODTRABAJADOR);

--6. FK_RPTBANCO_PLANILLA
ALTER TABLE RPTBANCO
ADD CONSTRAINT FK_RPTBANCO_PLANILLA
FOREIGN KEY (CODPLANILLA) REFERENCES PLANILLA(CODPLANILLA);