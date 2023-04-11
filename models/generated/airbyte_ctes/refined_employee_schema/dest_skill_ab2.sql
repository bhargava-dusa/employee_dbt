{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_refined_employee_schema",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('dest_skill_ab1') }}
select
    cast(skill_name as {{ dbt_utils.type_string() }}) as skill_name,
    cast(skill_id as {{ dbt_utils.type_bigint() }}) as skill_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('dest_skill_ab1') }}
-- dest_skill
where 1 = 1

