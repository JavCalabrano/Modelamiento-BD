-- Generado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   en:        2026-02-21 21:59:29 CLST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE BANCO 
    ( 
     cod_banco NUMBER (2)  NOT NULL , 
     nombre    VARCHAR2 (25)  NOT NULL 
    ) 
;

ALTER TABLE BANCO 
    ADD CONSTRAINT BANCO_PK PRIMARY KEY ( cod_banco ) ;

CREATE TABLE CIUDAD 
    ( 
     id_ciudad        NUMBER (3)  NOT NULL , 
     nombre           VARCHAR2 (25)  NOT NULL , 
     REGION_id_region NUMBER (3)  NOT NULL 
    ) 
;

ALTER TABLE CIUDAD 
    ADD CONSTRAINT CIUDAD_PK PRIMARY KEY ( id_ciudad ) ;

CREATE TABLE COMUNA 
    ( 
     id_comuna        NUMBER (4)  NOT NULL , 
     nombre           VARCHAR2 (25)  NOT NULL , 
     CIUDAD_id_ciudad NUMBER (3)  NOT NULL 
    ) 
;

ALTER TABLE COMUNA 
    ADD CONSTRAINT COMUNA_PK PRIMARY KEY ( id_comuna ) ;

CREATE TABLE DIAGNOSTICO 
    ( 
     cod_diagnostico NUMBER (3)  NOT NULL , 
     nombre          VARCHAR2 (25)  NOT NULL 
    ) 
;

ALTER TABLE DIAGNOSTICO 
    ADD CONSTRAINT DIAGNOSTICO_PK PRIMARY KEY ( cod_diagnostico ) ;

CREATE TABLE DIGITADOR 
    ( 
     id_digitador NUMBER (20)  NOT NULL , 
     pnombre      VARCHAR2 (25)  NOT NULL , 
     papellido    VARCHAR2 (25)  NOT NULL 
    ) 
;

ALTER TABLE DIGITADOR 
    ADD CONSTRAINT DIGITADOR_PK PRIMARY KEY ( id_digitador ) ;

CREATE TABLE DOSIS 
    ( 
     MEDICAMENTO_cod_medicamento NUMBER (7)  NOT NULL , 
     id_receta                   NUMBER (7)  NOT NULL , 
     descripcion_dosis           VARCHAR2 (25)  NOT NULL , 
     RECETA_cod_receta           NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE DOSIS 
    ADD CONSTRAINT DOSIS_PK PRIMARY KEY ( MEDICAMENTO_cod_medicamento, id_receta ) ;

CREATE TABLE ESPECIALIDAD 
    ( 
     id_especialidad NUMBER (3)  NOT NULL , 
     nombre          VARCHAR2 (25)  NOT NULL 
    ) 
;

ALTER TABLE ESPECIALIDAD 
    ADD CONSTRAINT ESPECIALIDAD_PK PRIMARY KEY ( id_especialidad ) ;

CREATE TABLE MEDICAMENTO 
    ( 
     cod_medicamento    NUMBER (7)  NOT NULL , 
     nombre             VARCHAR2 (25)  NOT NULL , 
     tipo_medicamento   NUMBER (3)  NOT NULL , 
     via_administración NUMBER (3)  NOT NULL , 
     stock              NUMBER (4)  NOT NULL , 
     dosis_recomendada  VARCHAR2 (50)  NOT NULL , 
     marca              VARCHAR2 (20)  NOT NULL 
    ) 
;

ALTER TABLE MEDICAMENTO 
    ADD CONSTRAINT MEDICAMENTO_PK PRIMARY KEY ( cod_medicamento );
    
ALTER TABLE MEDICAMENTO -- Instruccion del caso 2 para modificar tabla medicamento
    ADD precio_unitario NUMBER (7) ;


CREATE TABLE MEDICO 
    ( 
     rut_med                      NUMBER (8)  NOT NULL , 
     dv_med                       CHAR (1)  NOT NULL , 
     pnombre                      VARCHAR2 (25)  NOT NULL , 
     snombre                      VARCHAR2 (25) , 
     papellido                    VARCHAR2 (25)  NOT NULL , 
     sapellido                    VARCHAR2 (25) , 
     ESPECIALIDAD_id_especialidad NUMBER (3)  NOT NULL , 
     telefono                     NUMBER (8)  NOT NULL 
    ) 
;

ALTER TABLE MEDICO 
    ADD CONSTRAINT MEDICO_PK PRIMARY KEY ( rut_med ) ;

ALTER TABLE MEDICO 
    ADD CONSTRAINT MEDICO_telefono_UN UNIQUE ( telefono ) ;

CREATE TABLE PACIENTE 
    ( 
     rut_pac          NUMBER (8)  NOT NULL , 
     dv_pac           CHAR (1)  NOT NULL , 
     pnombre          VARCHAR2 (25)  NOT NULL , 
     snombre          VARCHAR2 (25) , 
     papellido        VARCHAR2 (25)  NOT NULL , 
     sapellido        VARCHAR2 (25) , 
     fecha_nacimiento DATE  NOT NULL , 
     telefono         NUMBER (11)  NOT NULL , 
     calle            VARCHAR2 (25)  NOT NULL , 
     numeracion       NUMBER (5)  NOT NULL , 
     REGION_id_region NUMBER (3)  NOT NULL 
    ) 
;

ALTER TABLE PACIENTE 
    ADD CONSTRAINT PACIENTE_PK PRIMARY KEY ( rut_pac ) ;

CREATE TABLE PAGO 
    ( 
     cod_boleta        NUMBER (6)  NOT NULL , 
     fecha_pago        DATE  NOT NULL , 
     monto_total       NUMBER (25)  NOT NULL , 
     metodo_pago       NUMBER (2)  NOT NULL , 
     BANCO_cod_banco   NUMBER (2)  NOT NULL , 
     RECETA_cod_receta NUMBER (7)  NOT NULL 
    ) 
;

ALTER TABLE PAGO 
    ADD CONSTRAINT PAGO_PK PRIMARY KEY ( cod_boleta ) ;

ALTER TABLE PAGO -- Instruccion de caso 2, modificación a la tabla Pago, CAMBIO DE NUMERIC A VARCHAR
    MODIFY (metodo_pago VARCHAR(20)) ;
    
ALTER TABLE PAGO -- Instruccion de caso 2, modificación a la tabla Pago, CHECK DE TIPO DE PAGO CON ENTRADA ESPECIFICA
    ADD CONSTRAINT ck_metodo_pago
    CHECK (metodo_pago IN ('EFECTIVO', 'TARJETA', 'TRANSFERENCIA'));
    
    

CREATE TABLE RECETA 
    ( 
     cod_receta                  NUMBER (7)  NOT NULL , 
     observaciones               VARCHAR2 (500) , 
     fecha_emision               DATE  NOT NULL , 
     fecha_vencimiento           DATE , 
     DIGITADOR_id_digitador      NUMBER (20)  NOT NULL , 
     PACIENTE_rut_pac            NUMBER (8)  NOT NULL , 
     DIAGNOSTICO_cod_diagnostico NUMBER (3)  NOT NULL , 
     MEDICO_rut_med              NUMBER (8)  NOT NULL , 
     id_tipo_receta              NUMBER (3) 
    ) 
;

ALTER TABLE RECETA 
    ADD CONSTRAINT RECETA_PK PRIMARY KEY ( cod_receta ) ;

CREATE TABLE REGION 
    ( 
     id_region NUMBER (3)  NOT NULL , 
     nombre    VARCHAR2 (25)  NOT NULL 
    ) 
;

ALTER TABLE REGION 
    ADD CONSTRAINT REGION_PK PRIMARY KEY ( id_region ) ;

ALTER TABLE CIUDAD 
    ADD CONSTRAINT CIUDAD_REGION_FK FOREIGN KEY 
    ( 
     REGION_id_region
    ) 
    REFERENCES REGION 
    ( 
     id_region
    ) 
;

ALTER TABLE COMUNA 
    ADD CONSTRAINT COMUNA_CIUDAD_FK FOREIGN KEY 
    ( 
     CIUDAD_id_ciudad
    ) 
    REFERENCES CIUDAD 
    ( 
     id_ciudad
    ) 
;

ALTER TABLE DOSIS 
    ADD CONSTRAINT DOSIS_MEDICAMENTO_FK FOREIGN KEY 
    ( 
     MEDICAMENTO_cod_medicamento
    ) 
    REFERENCES MEDICAMENTO 
    ( 
     cod_medicamento
    ) 
;

ALTER TABLE DOSIS 
    ADD CONSTRAINT DOSIS_RECETA_FK FOREIGN KEY 
    ( 
     RECETA_cod_receta
    ) 
    REFERENCES RECETA 
    ( 
     cod_receta
    ) 
;

ALTER TABLE MEDICO 
    ADD CONSTRAINT MEDICO_ESPECIALIDAD_FK FOREIGN KEY 
    ( 
     ESPECIALIDAD_id_especialidad
    ) 
    REFERENCES ESPECIALIDAD 
    ( 
     id_especialidad
    ) 
;

ALTER TABLE PACIENTE 
    ADD CONSTRAINT PACIENTE_REGION_FK FOREIGN KEY 
    ( 
     REGION_id_region
    ) 
    REFERENCES REGION 
    ( 
     id_region
    ) 
;

ALTER TABLE PAGO 
    ADD CONSTRAINT PAGO_BANCO_FK FOREIGN KEY 
    ( 
     BANCO_cod_banco
    ) 
    REFERENCES BANCO 
    ( 
     cod_banco
    ) 
;

ALTER TABLE PAGO 
    ADD CONSTRAINT PAGO_RECETA_FK FOREIGN KEY 
    ( 
     RECETA_cod_receta
    ) 
    REFERENCES RECETA 
    ( 
     cod_receta
    ) 
;

ALTER TABLE RECETA 
    ADD CONSTRAINT RECETA_DIAGNOSTICO_FK FOREIGN KEY 
    ( 
     DIAGNOSTICO_cod_diagnostico
    ) 
    REFERENCES DIAGNOSTICO 
    ( 
     cod_diagnostico
    ) 
;

ALTER TABLE RECETA 
    ADD CONSTRAINT RECETA_DIGITADOR_FK FOREIGN KEY 
    ( 
     DIGITADOR_id_digitador
    ) 
    REFERENCES DIGITADOR 
    ( 
     id_digitador
    ) 
;

ALTER TABLE RECETA 
    ADD CONSTRAINT RECETA_MEDICO_FK FOREIGN KEY 
    ( 
     MEDICO_rut_med
    ) 
    REFERENCES MEDICO 
    ( 
     rut_med
    ) 
;

ALTER TABLE RECETA 
    ADD CONSTRAINT RECETA_PACIENTE_FK FOREIGN KEY 
    ( 
     PACIENTE_rut_pac
    ) 
    REFERENCES PACIENTE 
    ( 
     rut_pac
    ) 
;

CREATE OR REPLACE TRIGGER FKNTM_CIUDAD 
BEFORE UPDATE OF REGION_id_region 
ON CIUDAD 
BEGIN 
  raise_application_error(-20225,'Non Transferable FK constraint  on table CIUDAD is violated'); 
END; 
/

CREATE OR REPLACE TRIGGER FKNTM_COMUNA 
BEFORE UPDATE OF CIUDAD_id_ciudad 
ON COMUNA 
BEGIN 
  raise_application_error(-20225,'Non Transferable FK constraint  on table COMUNA is violated'); 
END; 
/

CREATE OR REPLACE TRIGGER FKNTM_MEDICO 
BEFORE UPDATE OF ESPECIALIDAD_id_especialidad 
ON MEDICO 
BEGIN 
  raise_application_error(-20225,'Non Transferable FK constraint  on table MEDICO is violated'); 
END; 
/

CREATE OR REPLACE TRIGGER FKNTM_PACIENTE 
BEFORE UPDATE OF REGION_id_region 
ON PACIENTE 
BEGIN 
  raise_application_error(-20225,'Non Transferable FK constraint  on table PACIENTE is violated'); 
END; 
/

CREATE OR REPLACE TRIGGER FKNTM_PAGO 
BEFORE UPDATE OF BANCO_cod_banco, RECETA_cod_receta 
ON PAGO 
BEGIN 
  raise_application_error(-20225,'Non Transferable FK constraint  on table PAGO is violated'); 
END; 
/

CREATE OR REPLACE TRIGGER FKNTM_RECETA 
BEFORE UPDATE OF DIGITADOR_id_digitador, DIAGNOSTICO_cod_diagnostico, MEDICO_rut_med, PACIENTE_rut_pac 
ON RECETA 
BEGIN 
  raise_application_error(-20225,'Non Transferable FK constraint  on table RECETA is violated'); 
END; 
/



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            13
-- CREATE INDEX                             0
-- ALTER TABLE                             26
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           6
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
