
UPDATE solicitacao_insumo s
SET s.idf_finalizado = 'S'
WHERE s.dta_hor_cadastro >= To_date('01/01/2022', 'DD/MM/YYYY')
AND s.dta_hor_cadastro <= To_date('30/06/2022', 'DD/MM/YYYY')
AND s.idf_status = 6
AND s.idf_finalizado = 'N';


SELECT *  
FROM solicitacao_insumo s
WHERE s.dta_hor_cadastro >= To_date('01/01/2022', 'DD/MM/YYYY')
AND s.dta_hor_cadastro <= To_date('30/06/2022', 'DD/MM/YYYY')
--AND s.idf_status = 6
AND s.idf_finalizado = 'N';
