/*                   === TOTAL DE VIAGENS POR CENTRO ===                   */

WITH Base AS (
    -- SISTEMA LEGADO (ECC)
    -- Dados de 01/01/2025 ate 30/06/2026
    SELECT
        CentroReceptor_MVTCENTRO AS ID_Centro,
        UPPER(TRIM(Nome_NAME1)) AS Unidade,
        EXTRACT(YEAR FROM Data_MVTDATA) AS ano,
        EXTRACT(MONTH FROM Data_MVTDATA) AS mes,
        SAFE_CAST(NumeroSequencialDoMovimento_MVTNUM AS INT64) AS Num_Sequencial_Documento,
        SAFE_CAST(CodigoDoStatus_MVTSTATUS AS INT64) AS ID_Status_Movimento,
        1 AS Prioridade_Fonte
    FROM
        `sz-dig-corp-business-prd.business_sap_pt_br.vw_AbastecimentoMadeira`
    WHERE
        NumeroSequencialDoMovimento_MVTNUM IS NOT NULL
        AND CodigoDoStatus_MVTSTATUS <> 'Cancelado'
        AND CAST(CentroReceptor_MVTCENTRO AS STRING) IN (
            '6300', '6303', '2283', '1064',
            '1301', '1240', '6100', '5400',
            '2282', '6878', '1102', '1101',
            '6800', '6810', '6811'
        )
        AND DATE(Data_MVTDATA) >= DATE '2025-01-01'
        AND DATE(Data_MVTDATA) < DATE '2026-07-01'

    UNION ALL

    -- SISTEMA ATUAL (S/4 HANA)
    -- Dados a partir de 01/07/2026
    SELECT
        CentroReceptor_MVTCENTRO AS ID_Centro,
        UPPER(TRIM(Nome_NAME1)) AS Unidade,
        EXTRACT(YEAR FROM Data_MVTDATA) AS ano,
        EXTRACT(MONTH FROM Data_MVTDATA) AS mes,
        SAFE_CAST(NumeroSequencialDoMovimento_MVTNUM AS INT64) AS Num_Sequencial_Documento,
        SAFE_CAST(CodigoDoStatus_MVTSTATUS AS INT64) AS ID_Status_Movimento,
        2 AS Prioridade_Fonte
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
        AND DATE(Data_MVTDATA) >= DATE '2026-07-01'
),

Deduplicado AS (
    SELECT
        ID_Centro,
        Unidade,
        ano,
        mes,
        Num_Sequencial_Documento,
        ROW_NUMBER() OVER (
            PARTITION BY Num_Sequencial_Documento
            ORDER BY
                mes DESC,
                Prioridade_Fonte DESC
        ) AS rn
    FROM
        Base
),

ViagensValidas AS (
    -- Mantem apenas a linha valida e descarte duplicatas
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

-- Agregacao final no grao canônico exigido pela API
SELECT
    ano,
    mes,
    ID_Centro AS centro,
    Unidade AS unidade,
    'VEICULOS_RECEBIDOS' AS indicador,              --> slug
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
