-- Tabela ANEXO_SISTEMA e seus objetos
-- tablespace: TS_LOB_HC 
create sequence GENERICO.SEQ_ANEXO_SISTEMA
minvalue 1
maxvalue 9999999999
start with 1
increment by 1;

create table GENERICO.ANEXO_SISTEMA
(
  seq_anexo_sistema    NUMBER not null,
  ctu_arquivo          BLOB,
  dsc_link_externo     VARCHAR2(4000),
  dsc_nome_arquivo     VARCHAR2(255) not null,
  dsc_complemento      VARCHAR2(4000),
  num_user_cadastro    NUMBER not null,
  dta_hor_cadastro     DATE default SYSDATE not null,
  dta_exclusao_logica  DATE,
  num_usuario_exclusao NUMBER
);

comment on column GENERICO.ANEXO_SISTEMA.seq_anexo_sistema
  is 'CHAVE ATRIBUIDA VIA SEQUENCE';
comment on column GENERICO.ANEXO_SISTEMA.ctu_arquivo
  is 'CONTEÚDO DO ARQUIVO';
comment on column GENERICO.ANEXO_SISTEMA.dsc_link_externo
  is 'URL QUANDO O ARQUIVO FOR ACESSADO POR REFERENCI EXTERNA';
comment on column GENERICO.ANEXO_SISTEMA.dsc_nome_arquivo
  is 'NOME COMPLETO DO ARQUIVO COM EXTENSÃO';
comment on column GENERICO.ANEXO_SISTEMA.dsc_complemento
  is 'DESCRIÇÃO COMPLEMENTAR SOBRE O ARQUIVO';
comment on column GENERICO.ANEXO_SISTEMA.num_user_cadastro
  is 'USUÁRIO QUE INCLUIU O ANEXO';
comment on column GENERICO.ANEXO_SISTEMA.dta_hor_cadastro
  is 'DATA DO ORACLE INSERIDO VIA SYSDATE DEFAULT NO MOMENTO DA INCLUSÃO DO REGISTRO';
comment on column GENERICO.ANEXO_SISTEMA.dta_exclusao_logica
  is 'DATA DA EXCLUSÃO LÓGICA REGISTRADO VIA TRIGGER';
comment on column GENERICO.ANEXO_SISTEMA.num_usuario_exclusao
  is 'USUÁRIO QUE EXCLUIU LOGICAMENTE O ANEXO';  

alter table GENERICO.ANEXO_SISTEMA
  add constraint PK_ANEXO_SISTEMA primary key (SEQ_ANEXO_SISTEMA);  

CREATE OR REPLACE TRIGGER GENERICO.TG_INS_ANEXO_SISTEMA
  BEFORE INSERT
  ON GENERICO.ANEXO_SISTEMA 
  FOR EACH ROW  
BEGIN
  SELECT GENERICO.SEQ_ANEXO_SISTEMA.NEXTVAL
   INTO :NEW.SEQ_ANEXO_SISTEMA FROM DUAL;
END TG_INS_ANEXO_SISTEMA;
 ----------------------------------------------------------- 
  -- Tabela ANEXO_SISTEMA_OBJETO e seus objetos 
  -- tablespace: TS_DATA_HC
create sequence GENERICO.SEQ_ANEXO_SISTEMA_OBJETO
minvalue 1
maxvalue 9999999999
start with 1
increment by 1;

create table GENERICO.ANEXO_SISTEMA_OBJETO
(
  seq_anexo_sistema_objeto  NUMBER not null,
  dsc_objeto                VARCHAR2(50) not null,
  dsc_regra_chave           VARCHAR2(30),
  seq_anexo_sistema_obj_pai NUMBER
);

comment on column GENERICO.ANEXO_SISTEMA_OBJETO.seq_anexo_sistema_objeto
  is 'CHAVE ATRIBUIDA VIA SEQUENCE';
comment on column GENERICO.ANEXO_SISTEMA_OBJETO.dsc_objeto
  is 'DESCRIÇÃO DO OBJETO';
comment on column GENERICO.ANEXO_SISTEMA_OBJETO.dsc_regra_chave
  is 'DESCRIÇÃO DA REGRA DE COMO A CHAVE SERÁ GRAVADA NA TABELA ANEXO_SISTEMA_VINCULO';
comment on column GENERICO.ANEXO_SISTEMA_OBJETO.seq_anexo_sistema_obj_pai
  is 'AUTO RELACIONAMENTO PARA ORGANIZAÇÃO HIERARQUICA DOS OBJETOS';

alter table GENERICO.ANEXO_SISTEMA_OBJETO
  add constraint PK_SEQ_ANEXO_SISTEMA_OBJETO primary key (SEQ_ANEXO_SISTEMA_OBJETO);
 
alter table GENERICO.ANEXO_SISTEMA_OBJETO
  add constraint FK_ANEXO_SISTEMA_OBJ_PAI foreign key (SEQ_ANEXO_SISTEMA_OBJ_PAI)
  references GENERICO.ANEXO_SISTEMA_OBJETO (SEQ_ANEXO_SISTEMA_OBJETO);
  
CREATE OR REPLACE TRIGGER GENERICO.TG_INS_ANEXO_SISTEMA_OBJETO
  BEFORE INSERT
  ON GENERICO.ANEXO_SISTEMA_OBJETO 
  FOR EACH ROW
BEGIN
 SELECT GENERICO.SEQ_ANEXO_SISTEMA_OBJETO.NEXTVAL
   INTO :NEW.SEQ_ANEXO_SISTEMA_OBJETO FROM DUAL;
END TG_INS_ANEXO_SISTEMA_OBJETO;
-----------------------------------------------------

 -- Tabela ANEXO_SISTEMA_VINCULO e seus objetos 
 -- tablespace: TS_DATA_HC
create table GENERICO.ANEXO_SISTEMA_VINCULO
(
  seq_anexo_sistema        NUMBER not null,
  seq_anexo_sistema_objeto NUMBER not null,
  dsc_chave                VARCHAR2(20) not null
);

comment on column GENERICO.ANEXO_SISTEMA_VINCULO.seq_anexo_sistema
  is 'REFERÊNCIA À CHAVE DA TABELA ANEXO_SISTEMA';
comment on column GENERICO.ANEXO_SISTEMA_VINCULO.seq_anexo_sistema_objeto
  is 'REFERÊNCIA À CHAVE DA TABELA ANEXO_SISTEMA_OBJETO';
comment on column GENERICO.ANEXO_SISTEMA_VINCULO.dsc_chave
  is 'CHAVE DA TABELA VINCULADA CONFORME DESCRITO NA REGRA DA TABELA ANEXO_SISTEMA_OBJETO';

alter table GENERICO.ANEXO_SISTEMA_VINCULO
  add constraint PK_ANEXO_HC_VINCULO primary key (SEQ_ANEXO_SISTEMA, SEQ_ANEXO_SISTEMA_OBJETO);
  
alter table GENERICO.ANEXO_SISTEMA_VINCULO
  add constraint FK_ANEXO_SIST_OBJ_VINCULO foreign key (SEQ_ANEXO_SISTEMA_OBJETO)
  references GENERICO.ANEXO_SISTEMA_OBJETO (SEQ_ANEXO_SISTEMA_OBJETO);
alter table GENERICO.ANEXO_SISTEMA_VINCULO
  add constraint FK_ANEXO_SIST_VINCULO foreign key (SEQ_ANEXO_SISTEMA)
  references GENERICO.ANEXO_SISTEMA (SEQ_ANEXO_SISTEMA);

CREATE OR REPLACE TRIGGER GENERICO.TG_AI_ANEXO_SISTEMA_VINCULO
  AFTER INSERT
  ON GENERICO.ANEXO_SISTEMA_VINCULO
  FOR EACH ROW
BEGIN
   INSERT INTO GENERICO.ANEXO_SISTEMA_LOG(SEQ_ANEXO_SISTEMA, SEQ_ANEXO_SISTEMA_OBJETO, IDF_OPERAÇÃO , NUM_USER_LOG)
  VALUES(:NEW.SEQ_ANEXO_SISTEMA, :NEW.SEQ_ANEXO_SISTEMA_OBJETO,'I', fc_num_user_banco);
END TG_BD_ANEXO_SISTEMA_VINCULO;

CREATE OR REPLACE TRIGGER GENERICO.TG_BD_ANEXO_SISTEMA_VINCULO
  BEFORE DELETE
  ON GENERICO.ANEXO_SISTEMA_VINCULO
  FOR EACH ROW
BEGIN
   INSERT INTO GENERICO.ANEXO_SISTEMA_LOG(SEQ_ANEXO_SISTEMA, SEQ_ANEXO_SISTEMA_OBJETO, IDF_OPERAÇÃO , NUM_USER_LOG)
  VALUES(:OLD.SEQ_ANEXO_SISTEMA, :OLD.SEQ_ANEXO_SISTEMA_OBJETO,'E', fc_num_user_banco);
END TG_BD_ANEXO_SISTEMA_VINCULO;
----------------------------------------------------------------
-- Tabela ANEXO_SISTEMA_LOG e seus objetos 
 -- tablespace: TS_DATA_HC
 
 -- Create table
create table GENERICO.ANEXO_SISTEMA_LOG
(
  seq_anexo_sistema        NUMBER not null,
  seq_anexo_sistema_objeto NUMBER not null,
  idf_operação             VARCHAR2(1) not null,
  dta_hor_log              DATE default SYSDATE not null,
  num_user_log             NUMBER not null
);

comment on column GENERICO.ANEXO_SISTEMA_LOG.seq_anexo_sistema
  is 'REFERÊNCIA À CHAVE DA TABELA ANEXO_SISTEMA';
comment on column GENERICO.ANEXO_SISTEMA_LOG.seq_anexo_sistema_objeto
  is 'REFERÊNCIA À CHAVE DA TABELA ANEXO_SISTEMA_OBJETO';
comment on column GENERICO.ANEXO_SISTEMA_LOG.idf_operação
  is 'I - INCLUSÃO |  E - EXCLUSÃO';
comment on column GENERICO.ANEXO_SISTEMA_LOG.dta_hor_log
  is 'DATA DA OPERAÇÃO';
comment on column GENERICO.ANEXO_SISTEMA_LOG.num_user_log
  is 'USUÁRIO DA OPERAÇÃO';

  
