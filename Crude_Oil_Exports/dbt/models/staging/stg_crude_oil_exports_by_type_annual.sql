{{ config(materialized='table') }}

WITH source_data AS (
    SELECT *
    FROM read_csv_auto('{{ env_var("RAW_DATA_PATH") }}/crude-oil-exports-by-type-annual.csv')
)

SELECT
    CAST("Year" AS INTEGER) AS "year",
    LOWER(TRIM("Oil Type")) AS oil_type,
    CAST("Volume (m3/d)" AS DOUBLE) AS volume_cubic_meters_per_day,
    CAST("Volume (bbl/d)" AS DOUBLE) AS volume_barrels_per_day
FROM source_data
WHERE oil_type <> 'total'
    AND (
        "year" IS NOT NULL
        OR volume_cubic_meters_per_day IS NOT NULL
        OR volume_barrels_per_day IS NOT NULL
    )