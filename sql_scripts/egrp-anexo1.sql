SELECT PC.COD_SIAFISICO,
       MAT.COD_MATERIAL,
       MAT.NOM_MATERIAL,
       DECODE(PCP.COD_INSTITUICAO, 1, 'HC', 'FAEPA') SGL_INST,      
       PCP.COD_INSTITUICAO,
       ' ' COD_UG,
       I.NOM_INSTITUICAO || ' DE RIBEIRÃO PRETO-USP, COM ENTREGA NO ENDEREÇO CONSTANTE NO ITEM 8.2. DO EDITAL' DSC_INSTITUICAO,
       PCP.QTD_PARTICIPACAO
  FROM PEDIDO_COMPRA PC,  UNIDADE UN,  MATERIAL MAT, AGRUPAMENTO_COMPRA AGRUP,
       LICITACAO, MODALIDADE_LICITACAO MOD_LICIT,
       SIAFISICO_MATERIAL SM, UNIDADE_SIAFISICO US,
       PEDIDO_COMPRA_QTD_PARTIC PCP, INSTITUICAO I
 WHERE MAT.COD_UNIDADE             = UN.COD_UNIDADE
   AND PC.COD_MATERIAL            = MAT.COD_MATERIAL
   AND MOD_LICIT.COD_MODALIDADE_LICITACAO = LICITACAO.COD_MODALIDADE_LICITACAO
   AND AGRUP.NUM_AGRUPAMENTO      = PC.NUM_AGRUPAMENTO
   AND LICITACAO.NUM_AGRUPAMENTO  = PC.NUM_AGRUPAMENTO
   AND SM.COD_MATERIAL(+) = PC.COD_MATERIAL
   AND SM.COD_SIAFISICO(+) = PC.COD_SIAFISICO
   AND US.COD_UNIDADE_SIAFISICO(+) = SM.COD_UNIDADE_SIAFISICO
   AND PC.NUM_AGRUPAMENTO = 425797
   AND PC.NUM_PEDIDO_COMPRA = PCP.NUM_PEDIDO_COMPRA(+)
   AND PC.ANO_PEDIDO_COMPRA = PCP.ANO_PEDIDO_COMPRA(+)
   AND I.COD_INSTITUICAO = PCP.COD_INSTITUICAO
 ORDER BY PC.NUM_SEQ_AGRUPAMENTO;
 -----------------------------------------------------------------------
 SELECT 
       cod_siafisico
       ,cod_material
       ,mat.nom_material
       ,DECODE(cod_instituicao, 1, 'HC', 'FAEPA') sgl_inst      
       ,cod_instituicao
       ,' ' cod_ug
       ,i.nom_instituicao || ' DE RIBEIRÃO PRETO-USP, COM ENTREGA NO ENDEREÇO CONSTANTE NO ITEM 8.2. DO EDITAL' dsc_instituicao
       ,pcp.qtd_participacao
   FROM pedido_compra pc
   JOIN material mat USING(cod_material)
   JOIN unidade un USING(cod_unidade)
   JOIN agrupamento_compra agrup USING(num_agrupamento)
   JOIN licitacao USING(num_agrupamento)
   JOIN modalidade_licitacao mod_licit USING(cod_modalidade_licitacao)
   LEFT JOIN siafisico_material sm USING(cod_material, cod_siafisico)
   LEFT JOIN unidade_siafisico US USING(cod_unidade_siafisico)
   RIGHT JOIN pedido_compra_qtd_partic pcp USING(num_pedido_compra, ano_pedido_compra)
   JOIN instituicao i USING(cod_instituicao)   
 WHERE num_agrupamento = 425797
 ORDER BY pc.num_seq_agrupamento;
 ------------------------------------------------------------
 SELECT *
  FROM licitacao l
  WHERE l.num_agrupamento = 425797;
  
  SELECT *
   FROM pedido_compra_qtd_partic pcp;
   
   
   SELECT COUNT(*) qtd FROM pedido_compra pc
        JOIN pedido_compra_qtd_partic pcp USING(num_pedido_compra, ano_pedido_compra)
        WHERE pc.num_agrupamento = 425797;
 
 --4106/2022
