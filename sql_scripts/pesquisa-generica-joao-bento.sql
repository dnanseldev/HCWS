--30024420, 30024419, 30024432
SELECT num_solicitacao,
       ano_solicitacao,       
       sm.cod_cencusto,
       sm.dta_abertura_sm,
       sm.idf_status,
       sm.idf_tipo_sm,     
       sm.dsc_manifestacao_at,      
       ism.cod_material,
       ism.nom_material,
       ism.qtd_solicitada,
       ism.qtd_aprovada,
       ism.idf_prioridade_solicitacao,       
       ism.idf_status_item,       
       ism.dsc_justificativa,       
       ism.vlr_item_aprovacao,
       ism.qtd_atendida,       
       ism.idf_criticidade
       --ism.num_requisicao
 FROM solicitacao_materiais sm
 JOIN estoque.itens_solicitacao ism USING (num_solicitacao, ano_solicitacao)
 WHERE 1 = 1
 AND ism.cod_material IN ('30024420', '30024419', '30024432')
 AND sm.dta_abertura_sm >= to_date('01/01/2021', 'DD/MM/YYYY')
 ORDER BY sm.dta_abertura_sm DESC;
 -----------------------------------------------------------------

 SELECT num_requisicao,
        ano_requisicao_material,        
        rm.cod_cencusto_solicitante,
        cc.nom_cencusto,            
        rm.dta_atendimento,
        rm.cod_cencusto_atendente,
        CASE 
            rm.idf_status_requisicao
            WHEN 0 THEN 'Aberta'
            WHEN 1 THEN 'Impressa'
            WHEN 2 THEN 'Atendida'
            WHEN 3 THEN 'Cancelada'
        END idf_status_requisicao,
        
         CASE 
            rm.idf_tipo_requisicao
            WHEN 0 THEN 'Entrega'
            WHEN 1 THEN 'Devolução'
            WHEN 2 THEN 'Transferência'            
        END idf_tipo_requisicao,       
        
        CASE 
            rm.idf_sub_tipo_requi
            WHEN 0 THEN 'Por paciente'
            WHEN 1 THEN 'Reposição de Centro de Custo'
            WHEN 2 THEN 'Material Programado' 
            WHEN 3 THEN 'Material Engenharia'
            WHEN 4 THEN 'Atendimento de SM' 
            WHEN 5 THEN 'Acerto de estoque (obrigar justificativa)'
            WHEN 6 THEN 'Compras de Departamento'
            WHEN 7 THEN 'Requisicao da Consignação'
            WHEN 8 THEN 'Requisicao do CEMB'
            WHEN 9 THEN 'Requisicao OS'
            WHEN 10 THEN 'Entrega Mat. Permanente'
            WHEN 11 THEN 'Recuperação de Medicamentos'
            WHEN 12 THEN 'Racionamento'
            WHEN 13 THEN 'COVID-19 - EPI'          
        END idf_tipo_requisicao, 
             
        cod_material,
        m.nom_material,
        irm.qtd_requisi_devolvida,
        irm.qtd_forne_recebida,Re
        irm.vlr_ultima_compra          
  FROM requisicao_material rm  
  JOIN item_requisicao_material irm USING (num_requisicao, ano_requisicao_material)
  JOIN centro_custo cc ON cc.cod_cencusto = rm.cod_cencusto_solicitante
  JOIN material m USING(cod_material)
  WHERE 1 = 1
  AND cod_material IN ('30024420', '30024419', '30024432')
  AND rm.dta_requisicao >= to_date('01/01/2021', 'DD/MM/YYYY')
  AND rm.cod_cencusto_atendente = 'CGDA00019'
  ORDER BY rm.dta_requisicao DESC;
