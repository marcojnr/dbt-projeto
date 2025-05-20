-- cria um relatório de pedidos detalhado, onde cada linha mostra:
-- O produto vendido, sua categoria e fornecedor, quantidade e desconto aplicados,
-- quem comprou (cliente), quem vendeu (funcionário) e há quanto tempo trabalha e quando foi feito o pedido.
with prod as (
    select 
    ct.CategoryName as category,
    sp.company_name as suppliers,
    pd.product_name,
    pd.unit_price,
    pd.product_id
    from {{ source('sources', 'products') }} as pd
    left join {{ source('sources', 'suppliers') }} as sp on pd.supplier_id = sp.supplier_id 
    left join {{ source('sources', 'categories') }} as ct on pd.category_id = ct.CategoryID
),
ordertai as (
    select 
    pd.*,
    dt.order_id,
    dt.quantity,
    dt.discount
    from {{ ref('detalhes_pedido') }} as dt
    left join prod as pd on pd.product_id = dt.product_id
)
, ordrs as (
    select 
    o.order_date,
    o.order_id,
    c.company_name as customer,
    e.full_name as employee,
    e.age,
    e.lengthofservice
    from {{ source('sources', 'orders') }} as o
    left join {{ ref('clientes') }} as c on o.customer_id = c.customer_id
    left join {{ ref('funcionarios') }}  as e on o.employee_id = e.employee_id
    left join {{ source('sources', 'shippers') }}as s on o.ship_via = s.shipper_id
)
, final_join as (
    select od.*, o.order_date, o.customer, o.employee, o.age, o.lengthofservice
    from ordertai as od
    inner join ordrs as o on (od.order_id = o.order_id)
)
select *
from final_join

