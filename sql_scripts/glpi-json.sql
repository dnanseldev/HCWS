select * from centro_custo where cod_cencusto like 'HCB%';


SELECT 'CC_' || CC.COD_CENCUSTO || ' ' || CC.NOM_CENCUSTO, CC.COD_INSTITUTO
  FROM CENTRO_CUSTO CC
 WHERE CC.IDF_ATIVO = 'S'
 AND CC.cod_cencusto like 'HCB%';
------------------------------------------

SELECT 'CC_' || CC.COD_CENCUSTO || ' ' || CC.NOM_CENCUSTO cc       
                      ,i.cod_entidade_glpi
               FROM CENTRO_CUSTO CC
               JOIN instituto i USING(cod_instituto)
               WHERE CC.IDF_ATIVO = 'S'
               AND CC.cod_cencusto like 'HCB%';
 
 
------------------------------------------- 
 

/*
{
"input":{
"name": "Meu item",
"comment": "Adicionando um novo item",
"entities_id": 0,
"is_recursive": 0
}
}
*/

/*
{
    "input": [{
        "name": "My first computer",
        "serial": "12345"
    }, {
        "name": "My 2nd computer",
        "serial": "67890"
    }, {
        "name": "My 3rd computer",
        "serial": "qsd12sd"
    }]
}
*/

DECLARE
 BEGIN
    dbms_output.put_line('{');
    dbms_output.put_line('"input":[');
    FOR x IN (SELECT 'CC_' || CC.COD_CENCUSTO || ' ' || CC.NOM_CENCUSTO cc       
                      ,i.cod_entidade_glpi
               FROM CENTRO_CUSTO CC
               JOIN instituto i USING(cod_instituto)
               WHERE CC.IDF_ATIVO = 'S'
               AND CC.cod_cencusto like 'HCB%'
    )
    LOOP
        dbms_output.put_line('{');       
        dbms_output.put_line('"name": '||'"'||x.cc||'"');
        dbms_output.put_line(',"comment": ""');
        dbms_output.put_line(',"entities_id": '||x.cod_entidade_glpi);
        dbms_output.put_line(',"is_recursive": 0');
        dbms_output.put_line('},');               
    END LOOP;
       
       dbms_output.put_line(']}');
 END;
