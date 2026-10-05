WITH Base AS (
 
  SELECT
    CentroReceptor_MVTCENTRO AS ID_Centro,
    SAFE_CAST(NumeroSequencialDoMovimento_MVTNUM AS INT64) AS Num_Sequencial_Documento,
    DATE(Data_MVTDATA) AS Data_Movimento,
 
    PlacaDoVeiculoRebocador_PLACA1 AS Cavalo,
    PlacaDoVeiculoRebocador_PLACA2 AS Carreta1,
    PlacaDoVeiculoRebocador_PLACA3 AS Carreta2,
    TipoDeVeiculo_TIPOVEIC AS Composicao,
 
    CPFDoMotorista AS CPF,
    NomeDoMotorista_NAME1 AS Motorista,
 
    CodigoDoTransportador_LIFNR_TRP AS Cod_Transportadora,
    NomeDaTransportadora_NAME1 AS Transportadora,
 
    Up_UP AS UP
 
  FROM `sz-dig-corp-business-prd.business_sap_s4_pt_br.vw_AbastecimentoMadeira`
 
  WHERE NumeroSequencialDoMovimento_MVTNUM IS NOT NULL
    AND CAST(CentroReceptor_MVTCENTRO AS STRING) IN (
      '6300',
      '6319',
      '6320',
      '6326'
    )
 
),
 
Ultima_Viagem AS (
 
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY Cavalo
      ORDER BY Num_Sequencial_Documento DESC
    ) AS rn
 
  FROM Base
 
)
 
SELECT
  ID_Centro,
  Num_Sequencial_Documento,
  Data_Movimento,
 
  Cavalo,
  Carreta1,
  Carreta2,
  Composicao,
 
  CPF,
  Motorista,
 
  Cod_Transportadora,
  Transportadora,
 
  UP
 
FROM Ultima_Viagem
 
WHERE rn = 1
