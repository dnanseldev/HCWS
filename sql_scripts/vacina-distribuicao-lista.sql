--RITA DE FATIMA APPROBATO

select * from AG_HABILITACAO_VACINA t
WHERE t.nom_funcionario LIKE '%RITA DE FATIMA%'
AND t.num_cpf = '7166979801'
AND t.cod_campanha = 16;

select * from GENERICO.AG_HABILITACAO_VACINA_FUN t
where t.seq_hab_cert_digital_fun = 721;

select * from GENERICO.AG_CAMPANHA t;


select * from GENERICO.DISTRIBUICAO_LISTA t
where 1 = 1
AND T.SEQ_TIPO_LISTA = 41
AND T.NOM_LISTA_DISTRIBUICAO LIKE '%BIVALENTE%';

select * from GENERICO.DISTRIBUICAO_LISTA_FUNC t
where t.seq_distribuicao_lista = 1721
AND t.cpf_funcionario = '07166979801';

select * from GENERICO.DISTRIBUICAO_LOCAL_ENTREGA t
where t.seq_local_entrega = 301;

SELECT *
 FROM AG_VACINA A
 WHERE 1 = 1
 AND A.DTA_HOR_ATENDIMENTO >= TO_dATE('10/01/2023', 'DD/MM/YYYY');
-- AND A.SEQ_HAB_CERT_DIGITAL = 153014;

select * from GENERICO.LOG_HAB_VACINA t
WHERE T.DSC_ANTERIOR = '153014';

