-- Create table
create table GENERICO.CENTRO_CUSTO_INTEGRACAO
(
  cod_cencusto      CHAR(9) not null,
  dsc_glpi_group_id varchar2(5)
)
;
-- Add comments to the columns 
comment on column GENERICO.CENTRO_CUSTO_INTEGRACAO.cod_cencusto
  is 'Código do Centro de Custo O 9º dígito e um verificador';
comment on column GENERICO.CENTRO_CUSTO_INTEGRACAO.dsc_glpi_group_id
  is 'Grupo do GLPI associado a nosso centro de custo';
-- Create/Recreate indexes 
create index GENERICO.CENTRO_CUSTO_AK1 on GENERICO.CENTRO_CUSTO_INTEGRACAO (cod_cencusto);

-- Create/Recreate primary, unique and foreign key constraints 
alter table GENERICO.CENTRO_CUSTO_INTEGRACAO
  add constraint CC_INTEGRACAO_PK primary key (COD_CENCUSTO);
  
-- Create/Recreate primary, unique and foreign key constraints 
alter table GENERICO.CENTRO_CUSTO_INTEGRACAO
  add constraint CENTRO_CUSTO#CC_INTEGRACAO_FK foreign key (COD_CENCUSTO)
  references PRESCRICAO.centro_custo (COD_CENCUSTO);
