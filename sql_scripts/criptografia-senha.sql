SELECT FCN_INTEGRA_APP_GERAR('USUARIO', 'SENHA', 0) SENHA_CRYPT
  FROM DUAL;

SELECT SUBSTR(SENHA, 2, INSTR(SENHA, ', ') - 2) USUARIO
      ,SUBSTR(SENHA, INSTR(SENHA, ', ') + 2, INSTR(SENHA, ', ', -1) - (INSTR(SENHA, ', ') + 2)) SENHA
      ,SUBSTR(SENHA, INSTR(SENHA, ', ', -1) + 2, 1) TIPO
      ,SENHA
      ,SYSDATE DTA_ATUAL
  FROM (SELECT FCN_INTEGRA_APP_RECUPERAR('10R6VTS5NVNRO6TP9S7OPRT669U5R9VSa5QTM5MUM8OMQO97VO6UQTMS7O6M79668UUS7S9OOO75OQMVTN8PaUM7M865UOPN9V') SENHA
          FROM DUAL);
