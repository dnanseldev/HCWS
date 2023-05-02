--DAAA00088
SELECT *
 FROM centro_custo cc
 WHERE cc.cod_cencusto = 'DAAA00088';
 
 SELECT *
  FROM unidade_executante ue 
 WHERE 1 = 1
 AND ue.idf_ativo = 0
 AND ue.cod_unidade_executante_pai = 2;
 --AND ue.cod_unidade_executante = 2;
--  AND ue.COD_UNIDADE_EXECUTANTE IN (2,5,6,7,8,9,11,22,70,219);


SELECT COD_UNIDADE_EXECUTANTE, NOM_UNIDADE_EXECUTANTE
          FROM UNIDADE_EXECUTANTE
         WHERE  COD_UNIDADE_EXECUTANTE IN (2,5,6,7,8,9,11,22,70);
----------------------------------------------------------------------
 -- Serviço externo
SELECT DISTINCT-- OS.NUM_ORDEM,
                OS.NUM_ORDEM_SERVICO || '/' || OS.ANO_ORDEM_SERVICO NUM_OS,
                OS.COD_CENCUSTO,
             --   TOS.COD_UNIDADE_EXECUTANTE,
                DF.DTA_EMISSAO     DTA_OCORRENCIA,
                UE.NOM_UNIDADE_EXECUTANTE,

               -- 0 QTD_OS_CONCLUIDA,
               -- 0 QTD_HOR_APONT,
                DF.VLR_DOCUMENTO VLR_SERVICO_EXTERNO,
               -- 0   VLR_MATERIAL,
                AGS.VLR_FATURADO
              --  GC.COD_GRUPO,
              --  GC.DSC_GRUPO,
               -- GC.ORD_IMPRESSAO

  FROM DOCUMENTO_FINANCEIRO        DF,
       AGENDA_AUT_ENTREGA_SERVICO  AGS,
       AUTORIZACAO_ENTREGA_SERVICO AES,
       COTACAO_PEDIDO_SERVICO      CPS,

       PEDIDO_SERVICO        PS,
       TRIAGEM_ORDEM_SERVICO TOS,
       ORDEM_SERVICO         OS,

       CENTRO_CUSTO   CC,
       GRUPO_CENCUSTO GC,

       (SELECT COD_UNIDADE_EXECUTANTE, NOM_UNIDADE_EXECUTANTE
          FROM UNIDADE_EXECUTANTE
         START WITH COD_UNIDADE_EXECUTANTE IN (2,5,6,7,8,9,11,22,70)
        CONNECT BY PRIOR COD_UNIDADE_EXECUTANTE = COD_UNIDADE_EXECUTANTE_PAI) UE

 WHERE DF.DTA_HOR_LANCAMENTO BETWEEN TO_DATE('01/01/2021', 'DD/MM/YYYY') AND TO_DATE('31/12/2022', 'DD/MM/YYYY')
   AND DF.NUM_DOC_FINANCEIRO = AGS.NUM_DOC_FINANCEIRO
   AND AGS.NUM_AUT_ENTREGA_SERVICO = AES.NUM_AUT_ENTREGA_SERVICO
   AND AES.NUM_COTACAO_SERVICO = CPS.NUM_COTACAO_SERVICO
   AND CPS.NUM_PEDIDO_SERVICO = PS.NUM_PEDIDO_SERVICO
   AND PS.NUM_TRIAGEM_OS = TOS.NUM_TRIAGEM_OS
   AND TOS.NUM_ORDEM = OS.NUM_ORDEM
   AND OS.COD_CENCUSTO = CC.COD_CENCUSTO
   AND CC.COD_GRUPO = GC.COD_GRUPO(+)
   AND TOS.COD_UNIDADE_EXECUTANTE = UE.COD_UNIDADE_EXECUTANTE
   AND OS.COD_CENCUSTO IN ('DAAA00088')
   AND AES.COD_INSTITUICAO IN (1, 2);
   
   select  t.num_doc_financeiro
       ,SUM(t.vlr_faturado) vlr_faturado
       from GENERICO.AGENDA_AUT_ENTREGA_SERVICO t
where t.num_doc_financeiro = 1031730
AND t.idf_recebido = 'S'
GROUP BY t.num_doc_financeiro;
   -----------------------------------------------------------------------------------------
   SELECT  DISTINCT
           --num_ordem
           os.num_ordem_servico
          ,os.ano_ordem_servico
          --,os.num_bem
          ,ue.nom_unidade_executante
          ,os.cod_cencusto
          ,cc.nom_cencusto
          ,df.dta_emissao
          ,ae.cod_fornecedor                       
          ,aaes.vlr_faturado          
          ,df.vlr_documento vlr_servico_externo 
          ,num_doc_financeiro
          ,oaes.cod_estrutura          
       FROM ordem_servico os
       JOIN unidade_executante ue ON ue.cod_unidade_executante = os.cod_unidade_executante
          AND ue.cod_unidade_executante IN (2,5,6,7,8,9,11,22,70)
       JOIN centro_custo cc ON cc.cod_cencusto = os.cod_cencusto
       JOIN triagem_ordem_servico tos USING(num_ordem)
       JOIN pedido_servico ps USING(num_triagem_os)
       JOIN cotacao_pedido_servico cps USING(num_pedido_servico)
       JOIN Autorizacao_Entrega_Servico aes USING(num_cotacao_servico)
       JOIN generico.oneracao_aut_entrega_servico oaes USING(num_aut_entrega_servico)
       JOIN autorizacao_entrega ae USING(num_autorizacao_entrega, ano_autorizacao_entrega)
       JOIN agenda_aut_entrega_servico aaes USING(num_aut_entrega_servico)
       JOIN documento_financeiro df USING (num_doc_financeiro)
      WHERE 1 = 1
      --AND os.num_ordem_servico = 29819 AND os.ano_ordem_servico = 2022
      AND aes.dta_hor_cancelamento IS NULL
      AND df.dta_hor_lancamento BETWEEN to_date('01/01/2021', 'DD/MM/YYYY') AND TO_DATE('31/12/2022', 'DD/MM/YYYY')
      AND os.cod_cencusto IN ('DAAA00088')
      AND aes.cod_instituicao IN (1, 2)
      AND aaes.idf_recebido = 'S'
      --AND num_doc_financeiro = 1066281
      ORDER BY df.dta_emissao DESC;
      ----------------------------------------
       --V3
      WITH main_data_cost AS (
       SELECT DISTINCT
           --num_ordem
           --os.num_ordem_servico
          --,os.ano_ordem_servico
          --,os.num_bem
          --,ue.cod_unidade_executante          
          ue.nom_unidade_executante          
          --,os.cod_cencusto
          ,cc.nom_cencusto
          ,df.dta_emissao
          --,ae.cod_fornecedor                       
          --,aaes.vlr_faturado          
          ,df.vlr_documento vlr_servico_externo 
          ,num_doc_financeiro
         -- ,oaes.cod_estrutura          
       FROM ordem_servico os
       JOIN unidade_executante ue ON ue.cod_unidade_executante = os.cod_unidade_executante
          AND ue.cod_unidade_executante IN (2,5,6,7,8,9,11,22,70)
       JOIN centro_custo cc ON cc.cod_cencusto = os.cod_cencusto
       JOIN triagem_ordem_servico tos USING(num_ordem)
       JOIN pedido_servico ps USING(num_triagem_os)
       JOIN cotacao_pedido_servico cps USING(num_pedido_servico)
       JOIN Autorizacao_Entrega_Servico aes USING(num_cotacao_servico)
       JOIN generico.oneracao_aut_entrega_servico oaes USING(num_aut_entrega_servico)
       JOIN autorizacao_entrega ae USING(num_autorizacao_entrega, ano_autorizacao_entrega)
       JOIN agenda_aut_entrega_servico aaes USING(num_aut_entrega_servico)
       JOIN documento_financeiro df USING (num_doc_financeiro)
      WHERE 1 = 1
      --AND os.num_ordem_servico = 29819 AND os.ano_ordem_servico = 2022
      AND aes.dta_hor_cancelamento IS NULL
      AND df.dta_hor_lancamento BETWEEN to_date('01/01/2016', 'DD/MM/YYYY') AND TO_DATE('31/12/2022', 'DD/MM/YYYY')
      --AND os.cod_cencusto IN ('DAAA00088')
      AND aes.cod_instituicao IN (1, 2)
      AND aaes.idf_recebido = 'S'
      --AND num_doc_financeiro = 1066281
      --GROUP BY ue.cod_unidade_executante
      --        ,os.cod_cencusto;
       )
      
      SELECT mdc.nom_unidade_executante
             --MDC.oficina
            ,mdc.nom_cencusto
            ,SUM(mdc.vlr_servico_externo) vlr_servico_externo
            ,EXTRACT(YEAR FROM mdc.dta_emissao) ano
       FROM  main_data_cost mdc
       GROUP BY mdc.nom_unidade_executante                
               ,mdc.nom_cencusto
               ,EXTRACT(YEAR FROM mdc.dta_emissao)
       ORDER BY 
                mdc.nom_unidade_executante
               ,mdc.nom_cencusto
               ,ano;
      ----------------------------------------
      --V3
      WITH main_data_cost AS (
       SELECT DISTINCT          
          CASE WHEN ue.cod_unidade_executante_pai = 2
               THEN 'eng_clinica'
          END centro_de_trabalho
          ,ue.nom_unidade_executante          
          ,cc.nom_cencusto
          ,df.dta_emissao                    
          ,df.vlr_documento vlr_servico_externo 
          ,num_doc_financeiro                  
       FROM ordem_servico os
       JOIN unidade_executante ue ON ue.cod_unidade_executante = os.cod_unidade_executante
          AND ue.cod_unidade_executante IN (2,5,6,7,8,9,11,22,70)
       JOIN centro_custo cc ON cc.cod_cencusto = os.cod_cencusto
       JOIN triagem_ordem_servico tos USING(num_ordem)
       JOIN pedido_servico ps USING(num_triagem_os)
       JOIN cotacao_pedido_servico cps USING(num_pedido_servico)
       JOIN Autorizacao_Entrega_Servico aes USING(num_cotacao_servico)
       JOIN generico.oneracao_aut_entrega_servico oaes USING(num_aut_entrega_servico)
       JOIN autorizacao_entrega ae USING(num_autorizacao_entrega, ano_autorizacao_entrega)
       JOIN agenda_aut_entrega_servico aaes USING(num_aut_entrega_servico)
       JOIN documento_financeiro df USING (num_doc_financeiro)
      WHERE 1 = 1      
      AND aes.dta_hor_cancelamento IS NULL
      AND df.dta_hor_lancamento BETWEEN to_date('01/01/2019', 'DD/MM/YYYY') AND TO_DATE('31/12/2019', 'DD/MM/YYYY')      
      AND aes.cod_instituicao IN (1, 2)
      AND aaes.idf_recebido = 'S')
      
      SELECT 
             mdc.centro_de_trabalho
            ,mdc.nom_cencusto
            ,SUM(mdc.vlr_servico_externo) vlr_servico_externo
            ,EXTRACT(YEAR FROM mdc.dta_emissao) ano
       FROM  main_data_cost mdc
       GROUP BY centro_de_trabalho
               ,mdc.nom_cencusto
               ,EXTRACT(YEAR FROM mdc.dta_emissao)
       ORDER BY  mdc.nom_cencusto
                ,ano;
               
               
                 
      
   -----------------------------------------------------------------------------------------
   --51941/2020
   --29819/2022
   SELECT *
    FROM ordem_servico os
    WHERE os.num_ordem_servico = 51941
    AND os.ano_ordem_servico = 2022;
    
    
    SELECT  CASE WHEN ue.cod_unidade_executante_pai = 2
               THEN 'ENG_CLINICA'
            END oficina
           ,ue.*
     FROM unidade_executante ue
     WHERE ue.cod_unidade_executante_pai = 2
     AND ue.idf_ativo = 0;
    
  SELECT *
   FROM pesquisa_sistema ps
   WHERE ps.cod_sistema = 72;
   
   SELECT pc.dsc_contratado fornecedor
         ,tcj.dsc_tipo_contratacao
         ,pc.vlr_contrato
         ,pc.dsc_fundamento
         ,pc.dta_vigencia_inicio
         ,pc.dta_vigencia_fim
         ,pc.dta_publicacao
         ,pe.cod_estrutura
    FROM providencia_contrato pc
    JOIN tipo_contratacao_juridico tcj USING(seq_tipo_contratacao_juridico)
    JOIN generico.providencia_cont_estrutura_orc pe USING(seq_providencia_contrato)
    WHERE 1 = 1
    --AND pc.seq_tipo_contratacao_juridico IN (5, 6)
    AND pc.dta_vigencia_inicio > to_date('01/01/2014', 'DD/MM/YYYY')
    --AND pc.cod_fornecedor in (13654, 15168, 15422, 20169, 23703, 12430, 22794, 23127, 5675, 17295, 1165, 13497, 14129, 18508, 106, 19525, 6898, 9170, 4837, 18516, 3498, 9674, 2130, 15355, 1861, 19512, 11040, 3823, 15036, 19463, 18519, 14855, 8934, 10226, 17881, 21374, 21414, 4329, 5223, 17412, 19854, 17061, 925, 1216, 3094, 13926, 1016, 876, 13023, 1457, 13605, 7709, 13732, 16584, 9816, 13483, 13715, 19409, 1867, 76, 11761, 277, 19473, 13271, 1797, 3855, 14436, 8820, 13178, 17154, 17818, 35, 5313, 1298, 1916, 17279, 5304, 6382, 13543, 17254, 8393, 1958, 10943, 7046, 6346, 18196, 9115, 16491, 5261, 8422, 8129, 14600, 10634, 577, 15334, 8623, 15271, 1521, 237, 14733, 323, 9363, 2843, 16040, 8336, 15836, 3315, 12093, 12679, 1851, 12045, 5102, 6716, 5199, 5349, 14596, 15712, 12084, 1511, 5290, 3581, 4609, 1134, 11246, 5155, 3964)
    AND pe.cod_estrutura IN (105,311)
    ORDER BY pc.dta_vigencia_fim DESC;
    
    --105 311
    select * from GENERICO.PROVIDENCIA_CONT_ESTRUTURA_ORC pe
    WHERE pe.cod_estrutura IN (105, 311);
    
    SELECT *
     FROM estrutura_orcamentaria eo
     WHERE 
     cod_estrutura in (176, 198, 193, 105, 435, 62);
    -----------------------------------------------
    --V3
    SELECT num_aut_entrega_servico
          ,num_autorizacao_entrega
          ,ano_autorizacao_entrega
          ,aes.vlr_contratacao
          ,ae.dta_emissao
          ,aaes.vlr_faturado
          ,aaes.num_doc_financeiro
     FROM Autorizacao_Entrega_Servico aes
     JOIN GENERICO.ONERACAO_AUT_ENTREGA_SERVICO oaes USING(num_aut_entrega_servico)
     JOIN agenda_aut_entrega_servico aaes USING(num_aut_entrega_servico)
     JOIN autorizacao_entrega ae USING(num_autorizacao_entrega, ano_autorizacao_entrega)
     WHERE 1 = 1
     AND aes.cod_instituicao IN (1, 2)
     AND aes.dta_hor_cancelamento IS NULL
     AND oaes.cod_estrutura = 105
     AND ae.dta_emissao >= to_date('01/01/2022', 'DD/MM/YYYY');
     
     
     SELECT *
      FROM CENTRO_CUSTO CC
      WHERE CC.NOM_CENCUSTO LIKE '%SEÇÃO DE  TOMOGRAFIA COMPUTADORIZADA%'
      FOR UPDATE;
