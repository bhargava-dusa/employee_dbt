{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_refined_employee_schema",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('dest_project_ab1') }}
select
    cast({{ empty_string_to_null('end_date') }} as {{ type_date() }}) as end_date,
    cast(project_id as {{ dbt_utils.type_bigint() }}) as project_id,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(project_name as {{ dbt_utils.type_string() }}) as project_name,
    cast({{ empty_string_to_null('start_date') }} as {{ type_date() }}) as start_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('dest_project_ab1') }}
-- dest_project
where 1 = 1

