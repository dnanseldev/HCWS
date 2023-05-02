SELECT  
        ''||XMLROOT( 
                XMLELEMENT("Ordens_servicos"
                    ,XMLAGG(     
                        XMLELEMENT( "OS"
                                     ,XMLELEMENT("num_ordem", os.num_ordem) as num_ordem
                                     ,XMLELEMENT("num_ordem_servico", os.num_ordem_servico) AS num_ordem_servico
                                     ,XMLELEMENT("ano_ordem_servico", os.ano_ordem_servico) AS ano_ordem_servico
                                     ,XMLELEMENT("cod_cencusto", os.cod_cencusto) AS cod_cencusto )  ) )
                                     ,VERSION '1.0' )AS ordem_servico  
 FROM ORDEM_SERVICO os
 WHERE os.dta_criacao_os > to_date('01/12/2022', 'DD/MM/YYYY')
 AND os.num_id_glpi IS NOT NULL
 AND ROWNUM <= 20;
 ---------------------------------------------------------------------------
 SELECT '' ||XMLROOT(XMLELEMENT("outer"
                                ,XMLAGG(XMLELEMENT("list"
                                ,XMLELEMENT("element", 'any') AS ANY1)))
                     ,VERSION '1.0') AS SAMPLE
 FROM dual;
    
    
                     
                         
