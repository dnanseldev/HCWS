SELECT B.COD_UNIDADE_EXECUTANTE,
       B.NOM_UNIDADE_EXECUTANTE,
       B.COD_UNIDADE_EXECUTANTE_PAI,
       A.IDF_ATIVO
  FROM FUNCIONARIO_UNIDADE_EXECUTANTE A, UNIDADE_EXECUTANTE B
 WHERE A.NUM_USER_BANCO = 1331--66827
   AND B.IDF_ATIVO = 0
   AND A.IDF_ATIVO = 0
   AND B.COD_UNIDADE_EXECUTANTE_PAI IS NOT NULL
   AND FCN_INST_CENCUSTO(B.COD_CENCUSTO,0) = 1
   AND B.COD_UNIDADE_EXECUTANTE = A.COD_UNIDADE_EXECUTANTE
 ORDER BY 2;
 ------------------------------------------------
 SELECT DISTINCT ESTOQUE.FCN_INST_ONERACAO(X.COD_INSTITUICAO, X.COD_ESTRUTURA) COD_INSTITUICAO, 
       Y.NOM_FANTASIA, C.NOM_LOCALIDADE, Y.* 
FROM USUARIO_ESTRUTURA_ORCAMENTARIA X, V_INSTITUICAO_COMPRAS Z, V_INSTITUICAO_ORDEM_SERVICO Y, LOCALIDADE C
WHERE NUM_USER_BANCO = 66827--FC_NUM_USER_BANCO
  AND ESTOQUE.FCN_INST_ONERACAO(X.COD_INSTITUICAO, X.COD_ESTRUTURA) = Z.COD_INSTITUICAO
  AND Z.COD_INSTITUICAO = Y.COD_INSTITUICAO(+)
  AND Y.COD_LOCALIDADE = C.COD_LOCALIDADE(+)
  AND Z.COD_INST_SIST_CC = 1;
 -----------------------------------------------
 SELECT *
  FROM UNIDADE_EXECUTANTE ue
  WHERE (ue.cod_unidade_executante = 2 OR ue.cod_unidade_executante_pai = 2)
  AND ue.idf_ativo = 0;
  -----------------------------------------
  select * from GENERICO.INSTITUTO t
where t.cod_instituto IN (1, 2);
------------------------------------
SELECT *
 FROM atribuicao_funcional af;
 
SELECT TS.* FROM PARAMETRO_SISTEMA P, TIPO_PARAMETRO_SISTEMA TS
WHERE P.COD_TIPO_PARAMETRO = TS.COD_TIPO_PARAMETRO;
-----------------------------------
SELECT *
 FROM TIPO_PARAMETRO_SISTEMA tps
 ORDER BY 1 DESC
 FOR UPDATE;
 
SELECT  PS.COD_TIPO_PARAMETRO
       ,PS.COD_SISTEMA
       ,PS.COD_MODULO
       ,PS.COD_INSTITUICAO
       ,PS.COD_INSTITUTO       
       ,PS.VLR_PARAMETRO
       ,regexp_substr(PS.VLR_PARAMETRO, '[^#]+', 1, 1) cod_unidade_executante
       ,regexp_substr(PS.VLR_PARAMETRO, '[^#]+', 1, 2) ramal
       ,regexp_substr(PS.VLR_PARAMETRO, '[^#]+', 1, 3) telefone
       
 FROM PARAMETRO_SISTEMA ps
 WHERE ps.cod_sistema = 72
 AND PS.COD_TIPO_PARAMETRO = 823;
-- FOR UPDATE;


SELECT  B.COD_UNIDADE_EXECUTANTE
       ,B.NOM_UNIDADE_EXECUTANTE
       ,B.COD_UNIDADE_EXECUTANTE_PAI
       ,B.DSC_EMAIL_UNIDADE_EXECUTANTE
       ,A.IDF_ATIVO
       ,CPUN.VLR_PARAMETRO
       ,CPUN.COD_UNIDADE_EXECUTANTE UNIDADE_PARAMETRO
       ,CPUN.RAMAL
       ,CPUN.TELEFONE   
  FROM FUNCIONARIO_UNIDADE_EXECUTANTE A, UNIDADE_EXECUTANTE B,
       (SELECT      
          PS.COD_INSTITUICAO
         ,PS.COD_INSTITUTO       
         ,PS.VLR_PARAMETRO
         ,REGEXP_SUBSTR(PS.VLR_PARAMETRO, '[^#]+', 1, 1) COD_UNIDADE_EXECUTANTE
         ,REGEXP_SUBSTR(PS.VLR_PARAMETRO, '[^#]+', 1, 2) RAMAL
         ,REGEXP_SUBSTR(PS.VLR_PARAMETRO, '[^#]+', 1, 3) TELEFONE
       
 FROM PARAMETRO_SISTEMA PS
 WHERE PS.COD_SISTEMA = 72
 AND PS.COD_TIPO_PARAMETRO = 823) CPUN
 WHERE A.NUM_USER_BANCO = 1331--FC_NUM_USER_BANCO
   AND B.IDF_ATIVO = 0
   AND A.IDF_ATIVO = 0
   AND B.COD_UNIDADE_EXECUTANTE_PAI IS NOT NULL
   AND FCN_INST_CENCUSTO(B.COD_CENCUSTO,0) = 1
   AND B.COD_UNIDADE_EXECUTANTE = A.COD_UNIDADE_EXECUTANTE
  -- AND CPUN.COD_INSTITUTO = B.COD_INSTITUTO
  --AND CPUN.COD_UNIDADE_EXECUTANTE(+) = B.COD_UNIDADE_EXECUTANTE_PAI  
  --AND CPUN.COD_UNIDADE_EXECUTANTE(+) = B.COD_UNIDADE_EXECUTANTE
  AND CPUN.COD_UNIDADE_EXECUTANTE(+) = NVL(B.COD_UNIDADE_EXECUTANTE_PAI, B.COD_UNIDADE_EXECUTANTE)  
 -- AND CPUN.COD_UNIDADE_EXECUTANTE(+) = B.COD_UNIDADE_EXECUTANTE
  
   --AND ( CPUN.COD_UNIDADE_EXECUTANTE = B.COD_UNIDADE_EXECUTANTE_PAI OR CPUN.COD_UNIDADE_EXECUTANTE = B.COD_UNIDADE_EXECUTANTE )
  
   
   --AND (B.COD_UNIDADE_EXECUTANTE = 124)
 ORDER BY 2;
 /*
   DANIEL ANSELMO - 31/05/2021 SOLU��O MEMORANDO MULTI-EMPRESAS
   PARA INCLUIR INFORMA��ES DE EMAIL,TABELA UNIDADE_EXECUTANTE, COLUNA DSC_EMAIL_UNIDADE_EXECUTANTE
   PARA INCLUIR RAMAL E TELEFONE NAS OFICINAS, TABELA PARAMETRO_SISTEMA, COLUNA VLR_PARAMETRO NESTE TEMPLATE= COD_UNIDADE_EXECUTANTE#NUMERO_RAMAL#TELEFONE
   OBS- COD_TIPO_PARAMETRO 823, COD_SISTEMA 72(OS)
 */
 
 
 SELECT * FROM unidade_executante ue
 WHERE ue.Cod_Unidade_Executante = 2
 AND ue.idf_ativo = 0;
 
 SELECT

 --apoio.adm.eng@hcrp.usp.br


SELECT 
   FCN_BUSCA_INST_SISTEMA(1) COD_INST_SISTEMA, 
   FCN_BUSCA_INST_SISTEMA(2) COD_INSTITUTO_IP, 
   SYS_CONTEXT('USERENV','TERMINAL') TERMINAL, 
   SYS_CONTEXT('USERENV','OS_USER')  USER_WIN   
FROM DUAL ;

SELECT * FROM instituicao i
WHERE i.Cod_Instituicao = 80;

  
