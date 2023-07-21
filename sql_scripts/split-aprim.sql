SELECT APEX_ITEM.RADIOGROUP(1, A.NUM_USER_BANCO) IDF_SELECIONADO
   ,A.NUM_USER_BANCO
   ,A.NOM_USUARIO_BANCO
   ,A.NOM_USUARIO || ' ' || A.SBN_USUARIO NOM_USUARIO
 FROM USUARIO A
WHERE 1 = 1
 AND A.NUM_USER_BANCO = FC_NUM_USER_BANCO
ORDER BY NOM_USUARIO;

SELECT  '69 CAAA00188 1' params
        ,regexp_substr('69 CAAA00188 1', '[^ ]+',1) param01
        ,regexp_substr('69 CAAA00188 1', '[^ ]+',1,2) param02
        ,regexp_substr('69 CAAA00188 1', '[^ ]+',1,3) param03
FROM dual;

SELECT 
  trim(regexp_substr('51283-HCRP','[^-]+', 1,level) ) das
  FROM dual
  connect by regexp_substr('51283-HCRP', '[^-]+', 1, level) is not null
   order by das;
   
SELECT 
  trim(regexp_substr('51283-HCRP','[^-]+', 1,1) ) das
  ,trim(regexp_substr('51283-HCRP','[^-]+', 1,2) ) das2
  FROM dual;
 
