SELECT *
 FROM all_tables a
 WHERE upper(a.TABLE_NAME) LIKE '%fnc%';
 
 SELECT *
 FROM all_objects a
 WHERE upper(a.object_NAME) LIKE  '%USUARIO%';
 
 SELECT *
  FROM BENNERSM.GN_TIPOSFRETES;
 
 SELECT *
  FROM REMESSA_EMAIL R
  WHERE UPPER(R.DSC_DESTINATARIO) LIKE '%WEBEICKER%';
  
  SELECT SYS_CONTEXT('USERENV','IP_ADDRESS') FROM DUAL;
  
  SELECT *
   FROM mapeamento_local ml;
   
   SELECT ( SYSDATE - p.dta_nascimento)
    FROM Paciente_Sem_Registro_Hc p
    WHERE 1 = 1
   -- AND p.nom_paciente LIKE '%%'
    AND p.cod_paciente_sem_registro_hc = 2368591;
