 --Daniel Anselmo Dez 6 2022
 --v1
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
 --------------------------------------
 --v2
      WITH main_data_cost AS (
       SELECT DISTINCT          
          CASE WHEN ue.cod_unidade_executante_pai = 2
               THEN 'ENG_CLINICA'
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
      AND df.dta_hor_lancamento BETWEEN to_date('01/01/2016', 'DD/MM/YYYY') AND TO_DATE('31/12/2022', 'DD/MM/YYYY')      
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
 ------------------------------------------------------------
  SELECT pc.dsc_contratado fornecedor
         ,tcj.dsc_tipo_contratacao
         ,pc.vlr_contrato
         ,pc.dsc_fundamento
         ,pc.dta_vigencia_inicio
         ,pc.dta_vigencia_fim
         ,pc.dta_publicacao        
    FROM providencia_contrato pc
    JOIN tipo_contratacao_juridico tcj USING(seq_tipo_contratacao_juridico)
    JOIN generico.providencia_cont_estrutura_orc pe USING(seq_providencia_contrato)
    WHERE 1 = 1
    --AND pc.seq_tipo_contratacao_juridico IN (5, 6)
    AND pc.dta_vigencia_fim > to_date('01/01/2016', 'DD/MM/YYYY')
    --AND pc.cod_fornecedor in (13654, 15168, 15422, 20169, 23703, 12430, 22794, 23127, 5675, 17295, 1165, 13497, 14129, 18508, 106, 19525, 6898, 9170, 4837, 18516, 3498, 9674, 2130, 15355, 1861, 19512, 11040, 3823, 15036, 19463, 18519, 14855, 8934, 10226, 17881, 21374, 21414, 4329, 5223, 17412, 19854, 17061, 925, 1216, 3094, 13926, 1016, 876, 13023, 1457, 13605, 7709, 13732, 16584, 9816, 13483, 13715, 19409, 1867, 76, 11761, 277, 19473, 13271, 1797, 3855, 14436, 8820, 13178, 17154, 17818, 35, 5313, 1298, 1916, 17279, 5304, 6382, 13543, 17254, 8393, 1958, 10943, 7046, 6346, 18196, 9115, 16491, 5261, 8422, 8129, 14600, 10634, 577, 15334, 8623, 15271, 1521, 237, 14733, 323, 9363, 2843, 16040, 8336, 15836, 3315, 12093, 12679, 1851, 12045, 5102, 6716, 5199, 5349, 14596, 15712, 12084, 1511, 5290, 3581, 4609, 1134, 11246, 5155, 3964)
    AND pe.cod_estrutura IN (105,311)
    ORDER BY pc.dta_vigencia_fim DESC;              
  
