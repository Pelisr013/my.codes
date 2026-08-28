WITH Base AS (

  -- SISTEMA LEGADO
  -- Dados de 01/01/2025 até 30/06/2026

  SELECT
    CentroReceptor_MVTCENTRO AS ID_Centro,
    SAFE_CAST(NumeroSequencialDoMovimento_MVTNUM AS INT64) AS Num_Sequencial_Documento,
    SAFE_CAST(CodigoDoStatus_MVTSTATUS AS INT64) AS ID_Status_Movimento,

    DATE(Data_MVTDATA) AS Data_Do_Documento,

    BalancaDeEntrada_BALANCA_ENT AS Codigo_Balanca_Entrada,
    BalancaDeSaida_BALANCA_SAI AS Codigo_Balanca_Saida,
    MotivoDeLeituraBalancaDeEntrada_OBSLEITENT AS Motivo_Leitura_Entrada,
    SAFE_CAST(PesoNaEntrada_PESO_ENT AS INT64) AS Peso_Entrada,
    SAFE_CAST(PesoNaSaida_PESO_SAI AS INT64) AS Peso_Saida,
    SAFE_CAST(PesoLiquido_PESO_LIQ AS INT64) AS Peso_Liquido,

    CodigoDoTransportador_LIFNR_TRP AS Cod_Transportadora,
    NomeDaTransportadora_NAME1 AS Transportadora,
    NomeDoMotorista_NAME1 AS Motorista,
    PlacaDoVeiculoRebocador_PLACA1 AS Cavalo,
    PlacaDoVeiculoRebocador_PLACA2 AS Carreta1,
    PlacaDoVeiculoRebocador_PLACA3 AS Carreta2,

    IndicadorDeRegimeEspecial_REGESP AS Flag_Regime_Especial,
    RegimeEspecialDeFrete_REGESPFRT AS Flag_Reg_Especial_Frete,

    SAFE_CAST(NumeroDoMaterial_MATNR AS INT64) AS ID_Material,
    Up_UP AS UP,
    CarregadorFlorestal_CARREGFL AS Carregador_Florestal,
    CentroFlorestal_WERKS_FL AS Centro_Florestal,
    DepositoFlorestal_LGORT_FL AS Deposito_Florestal,
    ClasseDeDensidade_CLSDSD AS Classe_Densidade,
    SAFE_CAST(VolumeReal_VOL_REAL AS FLOAT64) AS Volume_Real_M3,
    SAFE_CAST(VolumeIndividualComCasca_VOLINDCC AS FLOAT64) AS Volum_Individual_CC,
    SAFE_CAST(VolumeIndividualSemCasca_VOLINDSC AS FLOAT64) AS VOlum_Individual_SC,
    DATE(DataDeCorte_DATACORTE) AS Data_Corte,
    SAFE_CAST(NumeroDeDiasDesdeOCorte_DIASCORTE AS INT64) AS Dias_Desde_Corte,

    SAFE_CAST(DistanciaPorAsfalto_DIST_ASFALTO AS INT64) AS Distancia_Asfalto,
    SAFE_CAST(DistanciaPorTerra_DIST_TERRA AS INT64) AS Distancia_Terra,
    SAFE_CAST(Distancia_DIST AS INT64) AS Distancia_Total_KM,

    DataSaidaParaCampo_DATEVT AS Data_Saida_Para_Campo,
    HoraSaidaParaCampo_HOREVT AS Hora_Saida_Para_Campo,

    DataChegadaNoCampo_DATEVT AS Data_Chegada_No_Campo,
    HoraChegadaNoCampo_HOREVT AS Hora_Chegada_No_Campo,

    DataInicioDeCargaEmCampo_DATEVT AS Data_Inicio_De_Carga_Campo,
    HoraInicioDeCargaEmCampo_HOREVT AS Hora_Inicio_De_Carga_Campo,

    DataFimDeCargaEmCampo_DATEVT AS Data_FIm_De_Carga_Campo,
    HoraFimDeCargaEmCampo_HOREVT AS Hora_FIm_De_Carga_Campo,

    DataSaidaDoCampo_DATEVT AS Data_Saida_Campo,
    HoraSaidaDoCampo_HOREVT AS Hora_Saida_Campo,

    DataChegadaNaFabrica_DATEVT AS Data_Chegada_Fabrica,
    HoraChegadaNaFabrica_HOREVT AS Hora_Chegada_Fabrica,

    DataEntradaNaFabrica_DATEVT AS Data_Entrada_Fabrica,
    HoraEntradaNaFabrica_HOREVT AS Hora_Entrada_Fabrica,

    DataInicioDeDescargaNaFabrica_DATEVT AS Data_Inicio_Descarga_Fabrica,
    HoraInicioDeDescargaNaFabrica_HOREVT AS Hora_Inicio_Descarga_Fabrica,

    DataFimDeDescargaNaFabrica_DATEVT AS Data_Fim_Descaraga_Fabrica,
    HoraFimDeDescargaNaFabrica_HOREVT AS Hora_Fim_Descaraga_Fabrica,

    DataSaidaDaFabrica_DATEVT AS Data_Saida_Fabrica,
    HoraSaidaDaFabrica_HOREVT AS Hora_Saida_Fabrica,

    1 AS Prioridade_Fonte

  FROM `sz-dig-corp-business-prd.business_sap_pt_br.vw_AbastecimentoMadeira`

  WHERE NumeroSequencialDoMovimento_MVTNUM IS NOT NULL
    AND CAST(CentroReceptor_MVTCENTRO AS STRING) IN (
      '1064',
      '6300',
      '6319',
      '6320',
      '6326'
    )
    AND DATE(Data_MVTDATA) >= DATE '2025-01-01'
    AND DATE(Data_MVTDATA) < DATE '2026-07-01'

  UNION ALL

  -- SISTEMA S/4
  -- Dados a partir de 01/07/2026

  SELECT
    CentroReceptor_MVTCENTRO AS ID_Centro,
    SAFE_CAST(NumeroSequencialDoMovimento_MVTNUM AS INT64) AS Num_Sequencial_Documento,
    SAFE_CAST(CodigoDoStatus_MVTSTATUS AS INT64) AS ID_Status_Movimento,

    DATE(Data_MVTDATA) AS Data_Do_Documento,

    BalancaDeEntrada_BALANCA_ENT AS Codigo_Balanca_Entrada,
    BalancaDeSaida_BALANCA_SAI AS Codigo_Balanca_Saida,
    MotivoDeLeituraBalancaDeEntrada_OBSLEITENT AS Motivo_Leitura_Entrada,
    SAFE_CAST(PesoNaEntrada_PESO_ENT AS INT64) AS Peso_Entrada,
    SAFE_CAST(PesoNaSaida_PESO_SAI AS INT64) AS Peso_Saida,
    SAFE_CAST(PesoLiquido_PESO_LIQ AS INT64) AS Peso_Liquido,

    CodigoDoTransportador_LIFNR_TRP AS Cod_Transportadora,
    NomeDaTransportadora_NAME1 AS Transportadora,
    NomeDoMotorista_NAME1 AS Motorista,
    PlacaDoVeiculoRebocador_PLACA1 AS Cavalo,
    PlacaDoVeiculoRebocador_PLACA2 AS Carreta1,
    PlacaDoVeiculoRebocador_PLACA3 AS Carreta2,

    IndicadorDeRegimeEspecial_REGESP AS Flag_Regime_Especial,
    RegimeEspecialDeFrete_REGESPFRT AS Flag_Reg_Especial_Frete,

    SAFE_CAST(NumeroDoMaterial_MATNR AS INT64) AS ID_Material,
    Up_UP AS UP,
    CarregadorFlorestal_CARREGFL AS Carregador_Florestal,
    CentroFlorestal_WERKS_FL AS Centro_Florestal,
    DepositoFlorestal_LGORT_FL AS Deposito_Florestal,
    ClasseDeDensidade_CLSDSD AS Classe_Densidade,
    SAFE_CAST(VolumeReal_VOL_REAL AS FLOAT64) AS Volume_Real_M3,
    SAFE_CAST(VolumeIndividualComCasca_VOLINDCC AS FLOAT64) AS Volum_Individual_CC,
    SAFE_CAST(VolumeIndividualSemCasca_VOLINDSC AS FLOAT64) AS VOlum_Individual_SC,
    DATE(DataDeCorte_DATACORTE) AS Data_Corte,
    SAFE_CAST(NumeroDeDiasDesdeOCorte_DIASCORTE AS INT64) AS Dias_Desde_Corte,

    SAFE_CAST(DistanciaPorAsfalto_DIST_ASFALTO AS INT64) AS Distancia_Asfalto,
    SAFE_CAST(DistanciaPorTerra_DIST_TERRA AS INT64) AS Distancia_Terra,
    SAFE_CAST(Distancia_DIST AS INT64) AS Distancia_Total_KM,

    DataSaidaParaCampo_DATEVT AS Data_Saida_Para_Campo,
    HoraSaidaParaCampo_HOREVT AS Hora_Saida_Para_Campo,

    DataChegadaNoCampo_DATEVT AS Data_Chegada_No_Campo,
    HoraChegadaNoCampo_HOREVT AS Hora_Chegada_No_Campo,

    DataInicioDeCargaEmCampo_DATEVT AS Data_Inicio_De_Carga_Campo,
    HoraInicioDeCargaEmCampo_HOREVT AS Hora_Inicio_De_Carga_Campo,

    DataFimDeCargaEmCampo_DATEVT AS Data_FIm_De_Carga_Campo,
    HoraFimDeCargaEmCampo_HOREVT AS Hora_FIm_De_Carga_Campo,

    DataSaidaDoCampo_DATEVT AS Data_Saida_Campo,
    HoraSaidaDoCampo_HOREVT AS Hora_Saida_Campo,

    DataChegadaNaFabrica_DATEVT AS Data_Chegada_Fabrica,
    HoraChegadaNaFabrica_HOREVT AS Hora_Chegada_Fabrica,

    DataEntradaNaFabrica_DATEVT AS Data_Entrada_Fabrica,
    HoraEntradaNaFabrica_HOREVT AS Hora_Entrada_Fabrica,

    DataInicioDeDescargaNaFabrica_DATEVT AS Data_Inicio_Descarga_Fabrica,
    HoraInicioDeDescargaNaFabrica_HOREVT AS Hora_Inicio_Descarga_Fabrica,

    DataFimDeDescargaNaFabrica_DATEVT AS Data_Fim_Descaraga_Fabrica,
    HoraFimDeDescargaNaFabrica_HOREVT AS Hora_Fim_Descaraga_Fabrica,

    DataSaidaDaFabrica_DATEVT AS Data_Saida_Fabrica,
    HoraSaidaDaFabrica_HOREVT AS Hora_Saida_Fabrica,

    2 AS Prioridade_Fonte

  FROM `sz-dig-corp-business-prd.business_sap_s4_pt_br.vw_AbastecimentoMadeira`

  WHERE NumeroSequencialDoMovimento_MVTNUM IS NOT NULL
    AND CAST(CentroReceptor_MVTCENTRO AS STRING) IN (
      '1064',
      '6300',
      '6319',
      '6320',
      '6326'
    )
    AND DATE(Data_MVTDATA) >= DATE '2026-07-01'
),

Deduplicado AS (
  SELECT
    *,

    ROW_NUMBER() OVER (
      PARTITION BY Num_Sequencial_Documento
      ORDER BY
        Data_Do_Documento DESC,
        Prioridade_Fonte DESC
    ) AS rn

  FROM Base
),

Normalizado AS (
  SELECT
    *,

    TIMESTAMP(
      DATETIME(Data_Saida_Para_Campo, Hora_Saida_Para_Campo)
    ) AS ts_Saida_Para_Campo,

    TIMESTAMP(
      DATETIME(Data_Chegada_No_Campo, Hora_Chegada_No_Campo)
    ) AS ts_Chegada_Campo,

    TIMESTAMP(
      DATETIME(Data_Inicio_De_Carga_Campo, Hora_Inicio_De_Carga_Campo)
    ) AS ts_Inicio_Carga_Campo,

    TIMESTAMP(
      DATETIME(Data_FIm_De_Carga_Campo, Hora_FIm_De_Carga_Campo)
    ) AS ts_Fim_Carga_Campo,

    TIMESTAMP(
      DATETIME(Data_Saida_Campo, Hora_Saida_Campo)
    ) AS ts_Saida_Campo,

    TIMESTAMP(
      DATETIME(Data_Chegada_Fabrica, Hora_Chegada_Fabrica)
    ) AS ts_Chegada_Fabrica,

    TIMESTAMP(
      DATETIME(Data_Entrada_Fabrica, Hora_Entrada_Fabrica)
    ) AS ts_Entrada_Fabrica,

    TIMESTAMP(
      DATETIME(
        Data_Inicio_Descarga_Fabrica,
        Hora_Inicio_Descarga_Fabrica
      )
    ) AS ts_Descarga_Fabrica,

    TIMESTAMP(
      DATETIME(
        Data_Fim_Descaraga_Fabrica,
        Hora_Fim_Descaraga_Fabrica
      )
    ) AS ts_Fim_Descarga_Fabrica,

    TIMESTAMP(
      DATETIME(Data_Saida_Fabrica, Hora_Saida_Fabrica)
    ) AS ts_Saida_Fabrica

  FROM Deduplicado

  WHERE rn = 1
),

Metricas AS (
  SELECT
    *,

    SAFE.TIMESTAMP_DIFF(
      ts_Chegada_Campo,
      ts_Saida_Para_Campo,
      SECOND
    ) AS Tempo_Fabrica_X_Campo,

    SAFE.TIMESTAMP_DIFF(
      ts_Inicio_Carga_Campo,
      ts_Chegada_Campo,
      SECOND
    ) AS Tempo_Fila_Campo,

    SAFE.TIMESTAMP_DIFF(
      ts_Fim_Carga_Campo,
      ts_Inicio_Carga_Campo,
      SECOND
    ) AS Tempo_Carga_Campo,

    SAFE.TIMESTAMP_DIFF(
      ts_Saida_Campo,
      ts_Fim_Carga_Campo,
      SECOND
    ) AS Tempo_Amarra_Campo,

    SAFE.TIMESTAMP_DIFF(
      ts_Chegada_Fabrica,
      ts_Saida_Campo,
      SECOND
    ) AS Tempo_Campo_X_Fabrica,

    SAFE.TIMESTAMP_DIFF(
      ts_Entrada_Fabrica,
      ts_Chegada_Fabrica,
      SECOND
    ) AS Tempo_Ate_Entrada,

    SAFE.TIMESTAMP_DIFF(
      ts_Descarga_Fabrica,
      ts_Entrada_Fabrica,
      SECOND
    ) AS Tempo_Ate_Descarga,

    SAFE.TIMESTAMP_DIFF(
      ts_Fim_Descarga_Fabrica,
      ts_Descarga_Fabrica,
      SECOND
    ) AS Tempo_Descarga,

    SAFE.TIMESTAMP_DIFF(
      ts_Saida_Fabrica,
      ts_Fim_Descarga_Fabrica,
      SECOND
    ) AS Tempo_Saida_Fabrica,

    SAFE.TIMESTAMP_DIFF(
      ts_Saida_Fabrica,
      ts_Saida_Para_Campo,
      SECOND
    ) AS Tempo_Ciclo,

    SAFE.TIMESTAMP_DIFF(
      ts_Chegada_Fabrica,
      ts_Saida_Para_Campo,
      SECOND
    ) AS Tempo_Ciclo_Viagem,

    SAFE.TIMESTAMP_DIFF(
      ts_Saida_Fabrica,
      ts_Chegada_Fabrica,
      SECOND
    ) AS Tempo_Ciclo_Fabrica

  FROM Normalizado
)

SELECT
  * EXCEPT (
    Data_Saida_Para_Campo,
    Hora_Saida_Para_Campo,
    Data_Chegada_No_Campo,
    Hora_Chegada_No_Campo,
    Data_Inicio_De_Carga_Campo,
    Hora_Inicio_De_Carga_Campo,
    Data_FIm_De_Carga_Campo,
    Hora_FIm_De_Carga_Campo,
    Data_Saida_Campo,
    Hora_Saida_Campo,
    Data_Chegada_Fabrica,
    Hora_Chegada_Fabrica,
    Data_Entrada_Fabrica,
    Hora_Entrada_Fabrica,
    Data_Inicio_Descarga_Fabrica,
    Hora_Inicio_Descarga_Fabrica,
    Data_Fim_Descaraga_Fabrica,
    Hora_Fim_Descaraga_Fabrica,
    Data_Saida_Fabrica,
    Hora_Saida_Fabrica,
    Prioridade_Fonte,
    rn,
    ts_Saida_Para_Campo,
    ts_Chegada_Campo,
    ts_Inicio_Carga_Campo,
    ts_Fim_Carga_Campo,
    ts_Saida_Campo,
    ts_Chegada_Fabrica,
    ts_Entrada_Fabrica,
    ts_Descarga_Fabrica,
    ts_Fim_Descarga_Fabrica,
    ts_Saida_Fabrica
  )

FROM Metricas

ORDER BY
  Data_Do_Documento
