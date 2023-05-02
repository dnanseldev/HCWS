--Relatório João
--Exemplo RecolhidonnOS 80113/2022 - Patrimonio 38359 - HCRP** - data recolhimento 27/10/2022
--Não recolhidos :nOS 91779/2022
SELECT  os.num_ordem_servico
       ,os.ano_ordem_servico          
       ,os.dta_criacao_os
       ,os.dsc_servico      
       ,bp.num_patrimonio      
       ,tp.dsc_tipo_patrimonio
   --    ,ots.dta_hor_observacao dta_recolhimento     
    --   ,ue.nom_unidade_executante
    --   ,ots.dsc_observacao
 FROM ordem_servico os
 LEFT JOIN bem_patrimonial bp USING(num_bem)
 LEFT JOIN tipo_patrimonio tp USING(cod_tipo_patrimonio)
-- JOIN observacao_triagem_os ots USING(num_ordem)    
-- JOIN unidade_executante ue ON ue.cod_unidade_executante = ots.cod_unidade_executante
  --  AND ue.cod_unidade_executante = 54  
 WHERE 1 = 1
 AND os.dta_criacao_os >= to_date('01/01/2016', 'DD/MM/YYYY')
 AND os.cod_situacao_os = 13 
 ORDER BY os.dta_criacao_os DESC;
 
 ---------------------------------------
 SELECT *
  FROM observacao_triagem_os ots
  WHERE ots.num_ordem = 1395053;
 ---------------------------------------
 SELECT *
  FROM ordem_servico os
 WHERE 1 = 1
 AND os.num_ordem_servico = 80113
 AND os.ano_ordem_servico = 2022;
 --AND os.dta_criacao_os >= to_date('01/01/2022', 'DD/MM/YYYY')
 --AND os.cod_situacao_os = 13;
