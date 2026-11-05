WITH BaseS4 AS (
    SELECT
        CentroReceptor_MVTCENTRO AS ID_Centro,
        UPPER(TRIM(Nome_NAME1)) AS Unidade,
        EXTRACT(YEAR FROM Data_MVTDATA) AS ano,
        EXTRACT(MONTH FROM Data_MVTDATA) AS mes,
        SAFE_CAST(NumeroSequencialDoMovimento_MVTNUM AS INT64) AS Num_Sequencial_Documento
    FROM
        `sz-dig-corp-business-prd.business_sap_s4_pt_br.vw_AbastecimentoMadeira`
    WHERE
        NumeroSequencialDoMovimento_MVTNUM IS NOT NULL
        AND CodigoDoStatus_MVTSTATUS <> 'Cancelado'
        AND CAST(CentroReceptor_MVTCENTRO AS STRING) IN (
            '6300', '6303', '2283', '1064',
            '1301', '1240', '6100', '5400',
            '2282', '6878', '1102', '1101',
            '6800', '6810', '6811'
        )
        -- Poda de particao dinamica injetada pelo FastAPI (Cutoff Date a partir de 01/11/2026)
        AND DATE(Data_MVTDATA) >= @data_corte
        AND DATE(Data_MVTDATA) >= @data_inicio
        AND DATE(Data_MVTDATA) <= @data_fim
),

Deduplicado AS (
    -- Mantem apenas 1 registro por viagem caso haja repeticao no S/4
    SELECT
        ID_Centro,
        Unidade,
        ano,
        mes,
        Num_Sequencial_Documento,
        ROW_NUMBER() OVER (
            PARTITION BY Num_Sequencial_Documento
            ORDER BY mes DESC
        ) AS rn
    FROM
        BaseS4
),

ViagensValidas AS (
    SELECT
        ID_Centro,
        Unidade,
        ano,
        mes,
        Num_Sequencial_Documento
    FROM
        Deduplicado
    WHERE
        rn = 1
)

SELECT
    ano,
    mes,
    ID_Centro AS centro,
    Unidade AS unidade,
    'PORTARIAS_MADEIRA_TOTAL_VEICULOS' AS indicador,
    COUNT(Num_Sequencial_Documento) AS valor,
    COUNT(Num_Sequencial_Documento) AS numerador,
    COUNT(Num_Sequencial_Documento) AS denominador
FROM
    ViagensValidas
GROUP BY
    ano,
    mes,
    centro,
    unidade
ORDER BY
    ano DESC,
    mes DESC,
    unidade ASC;
