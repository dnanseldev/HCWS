SELECT TP.COD_TIPO_PATRIMONIO, TP.DSC_TIPO_PATRIMONIO, TP.COD_CENCUSTO
FROM TIPO_PATRIMONIO TP
  INNER JOIN USUARIO_TIPO_PATRIMONIO UTP ON UTP.COD_TIPO_PATRIMONIO = TP.COD_TIPO_PATRIMONIO
                                        AND UTP.NUM_USER_BANCO = 66827--:NUM_USER_BANCO
  INNER JOIN INSTITUICAO_TIPO_PATRIMONIO ITP ON ITP.COD_TIPO_PATRIMONIO = TP.COD_TIPO_PATRIMONIO
                                            AND ITP.COD_INST_SISTEMA = 1
ORDER BY TP.DSC_TIPO_PATRIMONIO;

SELECT
  TB.COD_TIPO_BAIXA, DSC_TIPO_BAIXA
FROM TIPO_PATRIMONIO_BAIXA PB
  LEFT JOIN TIPO_BAIXA_PATRIMONIO TB ON TB.COD_TIPO_BAIXA = PB.COD_TIPO_BAIXA
WHERE PB.COD_TIPO_PATRIMONIO = :COD_TIPO_PATRIMONIO
ORDER BY 2
