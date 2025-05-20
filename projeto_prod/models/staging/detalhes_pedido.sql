with detalhes as (
    select 
    od.order_id, od.product_id, od.unit_price, od.quantity, pr.product_name, pr.supplier_id, pr.category_id,
    od.unit_price * od.quantity as total
    from {{source('sources', 'orderdetails')}} as od 
    left join {{source('sources', 'products')}} as pr on od.product_id = pr.product_id
)

select *,
(d.unit_price * d.quantity) - total as discount
from detalhes d


