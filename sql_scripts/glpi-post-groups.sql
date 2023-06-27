DECLARE
 BEGIN
    dbms_output.put_line('{');
    dbms_output.put_line('"input":[');
    FOR x IN (SELECT 'CC_' || CC.COD_CENCUSTO || ' ' || CC.NOM_CENCUSTO CENCUSTO       
                      ,i.cod_entidade_glpi
               FROM CENTRO_CUSTO CC
               JOIN instituto i USING(cod_instituto)
               WHERE CC.IDF_ATIVO = 'S'
               AND COD_INSTITUTO IN (14)
 ORDER BY CENCUSTO
    )
    LOOP
        dbms_output.put_line('{');       
        dbms_output.put_line('"name": '||'"'||x.CENCUSTO||'"');
        dbms_output.put_line(',"comment": ""');
        dbms_output.put_line(',"entities_id": '||x.cod_entidade_glpi);
        dbms_output.put_line(',"is_recursive": 0');
        dbms_output.put_line('},');               
    END LOOP;
       
       dbms_output.put_line(']}');
 END;
