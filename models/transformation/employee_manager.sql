with employee as (
    select 
        employee_id as id,
        manager_id as m_id,
        concat(first_name, ' ', last_name) full_name
    from {{ ref('dest_employee') }}
),

final as (
    select 
        e.full_name as employee_name,
        m.full_name as manager_name
    from employee e
    left join employee m on e.m_id = m.id
)

select * from final