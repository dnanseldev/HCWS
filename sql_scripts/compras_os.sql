
--29821/2022
 SELECT *
    FROM ordem_servico os
    WHERE os.num_ordem_servico = 51941
    AND os.ano_ordem_servico = 2022;
    
select * from GENERICO.TRIAGEM_ORDEM_SERVICO t
where t.num_ordem = 1365926;

select * from GENERICO.PEDIDO_SERVICO t
where t.num_triagem_os = 2254483;

select * from GENERICO.COTACAO_PEDIDO_SERVICO t
where t.num_pedido_servico = 100171;

select * from GENERICO.AUTORIZACAO_ENTREGA_SERVICO t
where t.num_cotacao_servico = 123521;

select * from GENERICO.AGENDA_AUT_ENTREGA_SERVICO t
where t.num_aut_entrega_servico = 101947;

select * from FINANCEIRO.DOCUMENTO_FINANCEIRO t
where t.num_doc_financeiro = 1097346;
