DROP TABLE BATCH_JOB_SEQ IF EXISTS;
DROP TABLE BATCH_JOB_EXECUTION_SEQ IF EXISTS;
DROP TABLE BATCH_STEP_EXECUTION_SEQ IF EXISTS;
DROP TABLE BATCH_JOB_EXECUTION_CONTEXT IF EXISTS;
DROP TABLE BATCH_STEP_EXECUTION_CONTEXT IF EXISTS;
DROP TABLE BATCH_STEP_EXECUTION IF EXISTS;
DROP TABLE BATCH_JOB_PARAMS IF EXISTS;
DROP TABLE BATCH_JOB_EXECUTION IF EXISTS;
DROP TABLE BATCH_JOB_INSTANCE IF EXISTS;
DROP TABLE T_ORDER IF EXISTS;
DROP TABLE T_ORDERITEM IF EXISTS;
DROP TABLE SEQUENCE IF EXISTS;

CREATE MEMORY TABLE SEQUENCE(SEQ_NAME VARCHAR(50) NOT NULL PRIMARY KEY,SEQ_COUNT NUMERIC(38));
CREATE MEMORY TABLE T_ORDERITEM(ID INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY, C_COUNT INTEGER, C_ITEM VARCHAR(100), ID_ORDER INTEGER);
CREATE MEMORY TABLE T_ORDER(ID INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY, C_CUSTOMER INTEGER, C_PROCESSED INTEGER, C_INVOICED INTEGER, C_EXPRESS INTEGER);
CREATE MEMORY TABLE BATCH_JOB_INSTANCE(JOB_INSTANCE_ID BIGINT IDENTITY NOT NULL PRIMARY KEY ,	VERSION BIGINT , JOB_NAME VARCHAR(100) NOT NULL,	JOB_KEY VARCHAR(32) NOT NULL,	constraint JOB_INST_UN unique (JOB_NAME, JOB_KEY));
CREATE MEMORY TABLE BATCH_JOB_EXECUTION  (JOB_EXECUTION_ID BIGINT IDENTITY NOT NULL PRIMARY KEY , VERSION BIGINT  ,	JOB_INSTANCE_ID BIGINT NOT NULL,	CREATE_TIME TIMESTAMP NOT NULL,	START_TIME TIMESTAMP DEFAULT NULL ,	END_TIME TIMESTAMP DEFAULT NULL ,	STATUS VARCHAR(10) ,	EXIT_CODE VARCHAR(20) ,	EXIT_MESSAGE VARCHAR(2500) ,	LAST_UPDATED TIMESTAMP,	constraint JOB_INST_EXEC_FK foreign key (JOB_INSTANCE_ID)	references BATCH_JOB_INSTANCE(JOB_INSTANCE_ID)) ;
CREATE MEMORY TABLE BATCH_JOB_PARAMS  (	JOB_INSTANCE_ID BIGINT NOT NULL ,	TYPE_CD VARCHAR(6) NOT NULL ,	KEY_NAME VARCHAR(100) NOT NULL ,	STRING_VAL VARCHAR(250) ,	DATE_VAL TIMESTAMP DEFAULT NULL , LONG_VAL BIGINT , DOUBLE_VAL DOUBLE PRECISION ,constraint JOB_INST_PARAMS_FK foreign key (JOB_INSTANCE_ID)	references BATCH_JOB_INSTANCE(JOB_INSTANCE_ID)) ;
CREATE MEMORY TABLE BATCH_STEP_EXECUTION  (	STEP_EXECUTION_ID BIGINT IDENTITY NOT NULL PRIMARY KEY ,	VERSION BIGINT NOT NULL,	STEP_NAME VARCHAR(100) NOT NULL,	JOB_EXECUTION_ID BIGINT NOT NULL,	START_TIME TIMESTAMP NOT NULL ,	END_TIME TIMESTAMP DEFAULT NULL ,	STATUS VARCHAR(10) ,	COMMIT_COUNT BIGINT ,	READ_COUNT BIGINT ,	FILTER_COUNT BIGINT ,	WRITE_COUNT BIGINT ,	READ_SKIP_COUNT BIGINT ,	WRITE_SKIP_COUNT BIGINT ,	PROCESS_SKIP_COUNT BIGINT ,	ROLLBACK_COUNT BIGINT ,	EXIT_CODE VARCHAR(20) ,	EXIT_MESSAGE VARCHAR(2500) ,	LAST_UPDATED TIMESTAMP,	constraint JOB_EXEC_STEP_FK foreign key (JOB_EXECUTION_ID)	references BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)) ;
CREATE MEMORY TABLE BATCH_STEP_EXECUTION_CONTEXT  (	STEP_EXECUTION_ID BIGINT NOT NULL PRIMARY KEY,	SHORT_CONTEXT VARCHAR(2500) NOT NULL,	SERIALIZED_CONTEXT LONGVARCHAR ,	constraint STEP_EXEC_CTX_FK foreign key (STEP_EXECUTION_ID)	references BATCH_STEP_EXECUTION(STEP_EXECUTION_ID)) ;
CREATE MEMORY TABLE BATCH_JOB_EXECUTION_CONTEXT  (	JOB_EXECUTION_ID BIGINT NOT NULL PRIMARY KEY,	SHORT_CONTEXT VARCHAR(2500) NOT NULL,	SERIALIZED_CONTEXT LONGVARCHAR ,	constraint JOB_EXEC_CTX_FK foreign key (JOB_EXECUTION_ID)	references BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)) ;
CREATE MEMORY TABLE BATCH_STEP_EXECUTION_SEQ (	ID BIGINT IDENTITY);
CREATE MEMORY TABLE BATCH_JOB_EXECUTION_SEQ (	ID BIGINT IDENTITY);
CREATE MEMORY TABLE BATCH_JOB_SEQ (	ID BIGINT IDENTITY);

INSERT INTO SEQUENCE VALUES('SEQ_GEN',0);
