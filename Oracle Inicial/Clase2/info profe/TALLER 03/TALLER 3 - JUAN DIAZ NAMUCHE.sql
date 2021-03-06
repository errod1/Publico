ALTER TABLE TRABAJADORES ADD CONSTRAINT FK_TRABAJADORES_AREA FOREIGN KEY (CODAREA) REFERENCES AREA(CODAREA);
ALTER TABLE TRABAJADORES ADD CONSTRAINT FK_TRABAJADORES_AFP FOREIGN KEY (CODAFP) REFERENCES AFP(CODAFP);
ALTER TABLE TRABAJADORES ADD  ( PRIMARY KEY (CODTRABAJADOR) ) ;
ALTER TABLE REG_HRS_LABORADAS  ADD CONSTRAINT FK_HORAS_LABORADAS_TRABAJADOR FOREIGN KEY (CODTRABAJADOR) REFERENCES TRABAJADORES(CODTRABAJADOR);
ALTER TABLE PRESTAMOS  ADD CONSTRAINT FK_PRESTAMOS_TRABAJADOR FOREIGN KEY (CODTRABAJADOR) REFERENCES TRABAJADORES(CODTRABAJADOR);
ALTER TABLE PLANILLA  ADD CONSTRAINT FK_PLANILLA_TRABAJADOR FOREIGN KEY (CODTRABAJADOR) REFERENCES TRABAJADORES(CODTRABAJADOR);
ALTER TABLE RPTBANCO  ADD CONSTRAINT FK_RPTBANCO_PLANILLA FOREIGN KEY (CODPLANILLA) REFERENCES PLANILLA(CODPLANILLA);
