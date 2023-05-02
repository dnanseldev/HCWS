CREATE OR REPLACE PROCEDURE GENERICO.PROC_INTEGRACAO_OS_GLPI(  P_NUM_BEM IN ORDEM_SERVICO.NUM_BEM%TYPE DEFAULT NULL
                                                              ,P_COD_CENTRO_CUSTO IN GENERICO.ORDEM_SERVICO.COD_CENCUSTO%TYPE
                                                              ,P_COD_UNIDADE_EXECUTANTE IN GENERICO.ORDEM_SERVICO.COD_UNIDADE_EXECUTANTE%TYPE
                                                              ,P_RAMAL IN GENERICO.ORDEM_SERVICO.NUM_RAMAL%TYPE
                                                              ,P_NUM_USER_BANCO IN ORDEM_SERVICO.NUM_USER_BANCO%TYPE
                                                              ,P_NOM_CONTATO IN GENERICO.ORDEM_SERVICO.NOM_CONTATO%TYPE
                                                              ,P_CPL_LOCAL IN GENERICO.ORDEM_SERVICO.CPL_LOCAL%TYPE                                                  
                                                              ,P_DSC_SERVICO GENERICO.ORDEM_SERVICO.DSC_SERVICO%TYPE
                                                              ,P_NUM_ID_GLPI GENERICO.ORDEM_SERVICO.NUM_ID_GLPI%TYPE )
 /*
 Author: Daniel Anselmo,
 Date: 24-08-2021 10:56
 Purpose: Integrar ticket GLPI com Ordem de serviço
 */                                                             
IS
   L_NUM_ORDEM            GENERICO.ORDEM_SERVICO.NUM_ORDEM%TYPE;
   L_NUM_ORDEM_SERVICO    GENERICO.ORDEM_SERVICO.NUM_ORDEM_SERVICO%TYPE;
   L_ANO_ORDEM_SERVICO    GENERICO.ORDEM_SERVICO.ANO_ORDEM_SERVICO%TYPE;  
BEGIN
     
     SELECT GENERICO.SEQ_NUM_ORDEM.NEXTVAL INTO L_NUM_ORDEM FROM DUAL;
     SELECT GENERICO.SEQ_NUM_ORDEM_SERVICO.NEXTVAL INTO L_NUM_ORDEM_SERVICO FROM DUAL;
     SELECT EXTRACT(YEAR FROM SYSDATE) INTO L_ANO_ORDEM_SERVICO FROM DUAL;          
      
      
     INSERT INTO GENERICO.ORDEM_SERVICO( NUM_ORDEM
                                        ,NUM_BEM
                                        ,IDF_PRIORIZADO
                                        ,COD_SITUACAO_OS
                                        ,COD_UNIDADE_EXECUTANTE
                                        ,COD_CENCUSTO
                                        ,NUM_ORDEM_SERVICO
                                        ,ANO_ORDEM_SERVICO                          
                                        ,NUM_USER_BANCO                       
                                        ,NUM_RAMAL                     
                                        ,NOM_CONTATO
                                        ,CPL_LOCAL
                                        ,DSC_SERVICO     
                                        ,NUM_ID_GLPI )
     VALUES( L_NUM_ORDEM
            ,(CASE WHEN P_NUM_BEM IS NOT NULL THEN P_NUM_BEM ELSE NULL END)
            ,3
            ,0
            ,P_COD_UNIDADE_EXECUTANTE
            ,P_COD_CENTRO_CUSTO
            ,L_NUM_ORDEM_SERVICO
            ,L_ANO_ORDEM_SERVICO
            ,P_NUM_USER_BANCO
            ,P_RAMAL
            ,P_NOM_CONTATO
            ,P_CPL_LOCAL                        
            ,P_DSC_SERVICO
            ,P_NUM_ID_GLPI );                     
                     
     INSERT INTO GENERICO.TRIAGEM_ORDEM_SERVICO ( NUM_USER_BANCO
                                                 ,NUM_ORDEM
                                                 ,COD_UNIDADE_EXECUTANTE
                                                 ,DTA_HOR_TRIAGEM )
     VALUES (  P_NUM_USER_BANCO 
              ,L_NUM_ORDEM
              ,P_COD_UNIDADE_EXECUTANTE
              ,SYSDATE );
              
    INSERT INTO GENERICO.HISTORICO_ORDEM_SERVICO(  NUM_ORDEM
                                                  ,DTA_HOR_HISTORICO
                                                  ,IDF_PRIORIZADO
                                                  ,NUM_USER_LOG
                                                  ,COD_SITUACAO_OS          
                                                  ,COD_UNIDADE_EXECUTANTE )
    VALUES( L_NUM_ORDEM
           ,SYSDATE
           ,3
           ,P_NUM_USER_BANCO
           ,0
           ,P_COD_UNIDADE_EXECUTANTE );
           
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
                  
end PROC_INTEGRACAO_OS_GLPI;
/
