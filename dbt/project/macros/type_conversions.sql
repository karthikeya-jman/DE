{% macro to_date(input_date) %}
    CAST({{input_date}} AS DATE)
{% endmacro %}

{% macro to_varchar(input_col) %}
     CAST({{input_col}} AS VARCHAR) 
{% endmacro %}

{% macro to_int(input_col) %}
     CAST({{input_col}} AS INT) 
{% endmacro %}

{% macro to_float(input_col) %}
     CAST({{input_col}} AS FLOAT) 
{% endmacro %}