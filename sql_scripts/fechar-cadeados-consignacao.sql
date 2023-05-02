UPDATE solicitacao_insumo s
 SET s.idf_finalizado = 'S' 
 WHERE s.dta_hor_cadastro >= To_date('01/01/2022', 'DD/MM/YYYY')
 AND s.dta_hor_cadastro <= To_date('31/05/2022', 'DD/MM/YYYY')
 AND s.idf_finalizado = 'N';
