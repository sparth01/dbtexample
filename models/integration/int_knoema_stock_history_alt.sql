with stock_history as (
 
    select  company_symbol, 
        company_name, 
        stock_exchange_name, 
        stock_date, 
        data_source_name,indicator_name, stock_value from {{ ref('stg_knoema_stock_history') }}
        where indicator_name IN ('Close', 'Open','High','Low', 'Volume', 'Change %') 
        and company_symbol IN ('AAPL','CRM')
 
),
pivoted as (
    select * from stock_history 
        pivot(sum(stock_value) for indicator_name in ('Close', 'Open','High','Low', 'Volume', 'Change %')
            ) 
)
select * from pivoted