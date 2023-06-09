{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_refined_employee_schema",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('dest_employee_ab1') }}
select
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(manager_id as {{ dbt_utils.type_bigint() }}) as manager_id,
    cast(employee_id as {{ dbt_utils.type_bigint() }}) as employee_id,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast({{ empty_string_to_null('hire_date') }} as {{ type_date() }}) as hire_date,
    cast(department as {{ dbt_utils.type_string() }}) as department,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('dest_employee_ab1') }}
-- dest_employee
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

