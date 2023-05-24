/*Passo 01: Remover Sequences*/
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
---------------------------
/*Criar sequences e sinonimos*/
DECLARE
BEGIN
    FOR x IN ( SELECT DISTINCT i.nom_sequence_documento
              FROM INSTITUICAO_ESPECIE_DOCUMENTO i
              WHERE i.cod_instituicao = 65
              AND i.nom_sequence_documento <> 'SEQ_NUM_DOCUMENTO' )
     LOOP        
        EXECUTE IMMEDIATE('create sequence DOCUMENTO.'||x.nom_sequence_documento||' minvalue 0 maxvalue 9999999999999999999999999999 start with 1 increment by 1 no cache');        
        EXECUTE IMMEDIATE('create public synonym '||x.nom_sequence_documento||' for DOCUMENTO.'||x.nom_sequence_documento);      
     END LOOP;
END;
---------------------------
