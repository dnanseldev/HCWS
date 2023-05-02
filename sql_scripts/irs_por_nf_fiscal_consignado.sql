    SELECT  DISTINCT
            'IR'||iu.seq_insumo_unitario IR
             ,m.nom_material
            ,l.num_lote_fabricante
            ,l.dta_validade_lote
            ,l.qtd_lote
            ,nf.num_nota_fiscal
            ,nf.vlr_nota_fiscal
            ,f.nom_fornecedor           
            ,sol.cod_paciente
            ,p.nom_paciente||' '||p.sbn_paciente nome_paciente
            ,ae.dta_cir_proposta data_cirurgia
            ,iae.num_autorizacao_entrega||'/'||iae.ano_autorizacao_entrega CUC
   FROM insumo_unitario iu
     JOIN lote l USING (num_lote)
     LEFT JOIN nota_fiscal nf USING(seq_nota_fiscal)
     JOIN fornecedor f USING(cod_fornecedor)
     JOIN material m USING(cod_material)
     JOIN solicitacao_insumo_item sii ON sii.seq_insumo_unitario = iu.seq_insumo_unitario
     JOIN solicitacao_insumo sol ON sol.seq_solicitacao_insumo = sii.seq_solicitacao_insumo
       AND sii.idf_operacao IN (5,6)
     JOIN paciente p ON p.cod_paciente = sol.cod_paciente 
     JOIN agenda_cirurgia ae ON ae.seq_agenda_cirurgia = sol.Num_Origem
     JOIN item_requisicao_consignacao irc USING(num_requisicao,ano_requisicao_material)
     JOIN itens_autorizacao_entrega iae USING (num_sugestao_compra)     
     WHERE 1 = 1
    AND nf.num_nota_fiscal = 359324;
