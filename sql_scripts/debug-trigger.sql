------Usar em editor de test  para poder debugar------------------------
DECLARE
V_NUM_ORDEM               HISTORICO_ORDEM_SERVICO.NUM_ORDEM%TYPE := 1433610;
V_DATA                    HISTORICO_ORDEM_SERVICO.DTA_HOR_HISTORICO%TYPE := TO_DATE('17-04-2023 15:40:07', 'dd-mm-yyyy hh24:mi:ss');
V_IDF_PRIORIZADO          HISTORICO_ORDEM_SERVICO.IDF_PRIORIZADO%TYPE := 3;
V_NUM_USER_LOG            HISTORICO_ORDEM_SERVICO.NUM_USER_LOG%TYPE := 66827;
V_COD_SITUACAO_OS         HISTORICO_ORDEM_SERVICO.COD_SITUACAO_OS%TYPE := 6;
V_COD_UNIDADE_EXECUTANTE  HISTORICO_ORDEM_SERVICO.COD_UNIDADE_EXECUTANTE%TYPE := 48;
V_SEQ_HISTORICO_OS        HISTORICO_ORDEM_SERVICO.SEQ_HISTORICO_OS%TYPE := 8890909;
BEGIN
    EXECUTE IMMEDIATE 'INSERT INTO GENERICO.HISTORICO_ORDEM_SERVICO
                        (NUM_ORDEM, DTA_HOR_HISTORICO, IDF_PRIORIZADO, NUM_USER_LOG, COD_SITUACAO_OS, COD_UNIDADE_EXECUTANTE, SEQ_HISTORICO_OS)
                      VALUES (:1, :2, :3, :4, :5,:6, :7)'
    USING V_NUM_ORDEM, V_DATA, V_IDF_PRIORIZADO, V_NUM_USER_LOG, V_COD_SITUACAO_OS, V_COD_UNIDADE_EXECUTANTE, V_SEQ_HISTORICO_OS;
END;