{% test non_negative(model, column_name) %}
WITH non_negative_test AS (
    SELECT {{ adapter.quote(column_name) }} AS val
    FROM {{ model }}
)
SELECT *
FROM non_negative_test
WHERE TRY_CAST(val AS DOUBLE) < 0  -- DuckDB: invalid values ​​become NULL and pass
{% endtest %}