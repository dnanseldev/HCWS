----------------------
select * from MANUTENCAO.BEM_PATRIMONIAL t
where t.num_bem = 13214;
----------------------

SELECT *
 FROM ordem_servico os
 WHERE 1 = 1
 AND os.cod_unidade_executante = 54
--AND  upper(os.dsc_servico) LIKE '%RECOL%'
 AND OS.DTA_CRIACAO_OS >= TO_dATE('01/01/2021','DD/MM/YYYY');
 --AND os.num_ordem_servico = 7949
 --AND os.ano_ordem_servico = 2021;


(SELECT np.num_bem chave_unica_equipamento,
       COUNT(*) qtd,
       RTRIM(XMLAGG(XMLELEMENT(E, NP.NUM_PATRIMONIO||'-'||TP.DSC_TIPO_PATRIMONIO
                                                   
                             , ',' || CHR(13)).EXTRACT('//text()') ORDER BY nP.NUM_BEM)                             
                            .GETCLOBVAL(),  ',') CHAPAS_EQUIPAMENTO       
   FROM  numero_patrimonio np  
   JOIN tipo_patrimonio tp ON tp.cod_tipo_patrimonio = np.cod_tipo_patrimonio
   GROUP BY np.num_bem) historico_chapeamento;
   --------------------------------------------
 SELECT  historico_chapeamento.chave_unica_equipamento,
        bp.num_patrimonio||'-'||tp.dsc_tipo_patrimonio patrimonio_atual,       
        historico_chapeamento.qtd,
        historico_chapeamento.CHAPAS_EQUIPAMENTO HISTORICO_CHAPAS,
        bp.dsc_complementar,              
        ue.nom_unidade_executante,
        os.num_ordem_servico||'/'||os.ano_ordem_servico OS,
        os.dsc_servico
  FROM bem_patrimonial bp
       JOIN tipo_patrimonio tp ON tp.cod_tipo_patrimonio = bp.cod_tipo_patrimonio
       JOIN (SELECT np.num_bem chave_unica_equipamento,
       COUNT(*) qtd,
       RTRIM(XMLAGG(XMLELEMENT(E, NP.NUM_PATRIMONIO||'-'||TP.DSC_TIPO_PATRIMONIO
                                                   
                             , ',' || CHR(13)).EXTRACT('//text()') ORDER BY nP.NUM_BEM)                             
                            .GETCLOBVAL(),  ',') CHAPAS_EQUIPAMENTO       
   FROM  numero_patrimonio np  
   JOIN tipo_patrimonio tp ON tp.cod_tipo_patrimonio = np.cod_tipo_patrimonio
   GROUP BY np.num_bem) historico_chapeamento ON historico_chapeamento.chave_unica_equipamento = bp.num_bem
   JOIN ordem_servico os ON os.num_bem = bp.num_bem
  -- JOIN EMISSAO_PEDIDO_PROVIDENCIA_OS EPPO ON EPPO.Num_Bem = bp.num_bem
  -- JOIN EMISSAO_PEDIDO_PROVIDENCIA_OS EPPO ON EPPO.Num_Ordem = os.num_ordem       
   JOIN unidade_executante ue ON ue.cod_unidade_executante = os.cod_unidade_executante
   WHERE 1 = 1
   AND os.cod_unidade_executante IN (54)
   AND os.cod_situacao_os IN  (3, 13)
  -- AND EPPO.Idf_Status_Pedido IN (0,1)
   AND ue.cod_instituto = 1;
   -----------------------------------------
   SELECT *
    FROM EMISSAO_PEDIDO_PROVIDENCIA_OS EPPO
    WHERE eppo.num_bem = 10293;
   ---------------------------------------
   SELECT *
    FROM bem_patrimonial bp 
    WHERE bp.num_bem = 48;
    
    SELECT * 
    FROM numero_patrimonio np
    WHERE np.num_bem = 48;
    
    SELECT * FROM ordem_servico os;
