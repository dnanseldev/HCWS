--DRS Soro
--prescricao_medicamento
--DSC_MATERIAL_FORA_EST

SELECT *
 FROM material m
 WHERE m.nom_material LIKE '%SORO%';

SELECT *
 FROM prescricao_medicamento p
 JOIN prescricao_medica pm USING(num_prescricao)
 WHERE pm.dta_hor_prescricao >= TRUNC(SYSDATE - 7)
 AND p.cod_material = ''
 
