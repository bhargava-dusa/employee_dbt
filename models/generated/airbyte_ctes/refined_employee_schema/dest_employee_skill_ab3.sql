{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_refined_employee_schema",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('dest_employee_skill_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'employee_id',
        'skill_id',
    ]) }} as _airbyte_dest_employee_skill_hashid,
    tmp.*
from {{ ref('dest_employee_skill_ab2') }} tmp
-- dest_employee_skill
where 1 = 1

