DECLARE
BEGIN
    FOR x IN ( SELECT DISTINCT i.nom_sequence_documento
              FROM INSTITUICAO_ESPECIE_DOCUMENTO i
              WHERE i.cod_instituicao = 65
              AND i.nom_sequence_documento <> 'SEQ_NUM_DOCUMENTO' )
     LOOP        
        EXECUTE IMMEDIATE('create sequence DOCUMENTO.'||x.nom_sequence_documento||' minvalue 0 maxvalue 9999999999999999999999999999 start with 1 increment by 1');        
        EXECUTE IMMEDIATE('create public synonym '||x.nom_sequence_documento||' for DOCUMENTO.'||x.nom_sequence_documento);      
     END LOOP;
END;
-----------------------------------------------
DECLARE
BEGIN
    FOR x IN ( SELECT DISTINCT i.nom_sequence_documento
              FROM INSTITUICAO_ESPECIE_DOCUMENTO i
              WHERE i.cod_instituicao = 65
              AND i.nom_sequence_documento <> 'SEQ_NUM_DOCUMENTO' )
     LOOP        
        EXECUTE IMMEDIATE('drop sequence DOCUMENTO.'||x.nom_sequence_documento||' ');   
        EXECUTE IMMEDIATE('drop public synonym '||x.nom_sequence_documento||' ');       
      END LOOP;
END;

------------------------------------
DECLARE
BEGIN
    FOR x IN ( SELECT DISTINCT i.nom_sequence_documento
              FROM INSTITUICAO_ESPECIE_DOCUMENTO i
              WHERE i.cod_instituicao = 65
              AND i.nom_sequence_documento <> 'SEQ_NUM_DOCUMENTO' )
     LOOP        
        EXECUTE IMMEDIATE('GRANT select ON DOCUMENTO.'||x.nom_sequence_documento||' TO DAANSELMO');   
       --GRANT ALL ON documento.SEQ_NUM_OFICIO_BAURU TO nycrepaldi;      
      END LOOP;
END;
------------------------------------
select sequence_owner, sequence_name from dba_sequences ds
WHERE ds.SEQUENCE_OWNER = 'DOCUMENTO'
AND ds.SEQUENCE_NAME LIKE '%BAURU%';

--DROP PUBLIC SYNONYM
