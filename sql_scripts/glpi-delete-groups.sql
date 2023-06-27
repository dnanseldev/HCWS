DECLARE
 BEGIN
    dbms_output.put_line('{');
    dbms_output.put_line('"input":[');
    FOR x IN (SELECT cod_cencusto, cci.dsc_glpi_group_id
         FROM generico.centro_custo_integracao cci
         JOIN centro_custo cc USING(cod_cencusto)
         JOIN instituto i ON i.cod_instituto = cc.cod_instituto
         AND i.cod_entidade_glpi IN (16)
    )
    LOOP
        dbms_output.put_line('{');       
        dbms_output.put_line('"id": '||x.dsc_glpi_group_id);        
        dbms_output.put_line('},');               
    END LOOP;
       
       dbms_output.put_line(']}');
 END;
