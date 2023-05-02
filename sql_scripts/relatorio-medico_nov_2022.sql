 
--------------------------------------
--1194245G - Celia dos Santos Rodrigues

--relatorio medico - 6061-2022 04/11/22

SELECT *
 FROM relatorio_medico rm
 WHERE 1 = 1
 --AND rm.dta_relatorio_medico >= to_date('04/11/2022', 'DD/MM/YYYY')
 --AND rm.num_solic_rel_medico = 307956
AND num_solic_rel_medico = 307956;
 --FOR UPDATE;
-- AND rm.num_solic_rel_medico = 6061
 --AND rm.a;
 
SELECT *
  FROM DOCUMENTO.SOLICITACAO_REL_MEDICO t
 WHERE t.cod_paciente = '1194245G'
   AND t.num_documento = 6061;

SELECT *
 FROM usuario u
 WHERE 1 = 1
 AND u.nom_usuario LIKE '%MARIA REGINA%'
 AND u.nom_usuario_banco = 'MPOLETTO';
 
SELECT *
 FROM centro_custo_usuario_permissao c
 WHERE c.num_user_banco = 4574;

SELECT *
 FROM especialidade_hc e
 WHERE e.cod_especialidade_hc = 55;
 
 --MPOLETTO
 --4574
 SELECT *
  FROM centro_custo cc
  WHERE cc.nom_cencusto LIKE '%%'
--  AND CC.COD_INSTITUTO IN (1,2)
  AND CC.IDF_ATIVO = 'S';
  
  SELECT * 
   FROM relatorio_paciente rp
   WHERE rp.cod_paciente = '1194245G';
   
   SELECT *
    FROM doc_assinado ds
    WHERE 1 = 1 
    AND ds.cod_sistema = 62
    AND ds.num_user_banco = 4574
    AND ds.dta_hor_cadastro >= to_date('01/10/2022', 'DD/MM/YYYY');
    
    
    SELECT *
     FROM doc_assinado_origem do
     WHERE do.nom_tabela_origem = 'RELATORIO_MEDICO'
     AND DO.NUM_CHAVE_ORIGEM = 268037;
     
     SELECT *
     FROM doc_assinado_origem do
     WHERE do.SEQ_DOCUMENTO_ORIGEM = 75036303
    -- AND DO.NUM_CHAVE_ORIGEM = 268037;
     
        	/*SEQ_DOCUMENTO_ORIGEM	SEQ_DOCUMENTO_CERTIFICADO	NUM_CHAVE_ORIGEM	NOM_TABELA_ORIGEM
                     	75036303	54619108	                268037	          RELATORIO_MEDICO*/

     
     --268037
    --RELATORIO_PACIENTE
    --RELATORIO_MEDICO
    SELECT *
    FROM doc_assinado_assinatura daa
    WHERE daa.nom_assinante LIKE '%MARIA REGINA POLETTO%'
    AND daa.seq_documento_certificado = 54619108;
    
    select * from GENERICO.DOC_ASSINADO t
where t.seq_documento_certificado = 54619108;
--FOR UPDATE;
