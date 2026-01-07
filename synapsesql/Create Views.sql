-- Fact Table: Orders & Revenue
CREATE VIEW gold.fact_orders AS
SELECT
    o.order_id,
    o.user_id,
    CAST(o.created_at AS DATE) AS order_date,
    COUNT(oi.order_item_id) AS items_count,
    SUM(oi.price_usd) AS gross_revenue,
    SUM(ISNULL(r.refund_amount_usd, 0)) AS refund_amount,
    SUM(oi.price_usd) - SUM(ISNULL(r.refund_amount_usd, 0)) AS net_revenue
FROM gold.ext_orders o
LEFT JOIN gold.ext_order_items oi
    ON o.order_id = oi.order_id
LEFT JOIN gold.ext_order_item_refunds r
    ON oi.order_item_id = r.order_item_id
GROUP BY
    o.order_id,
    o.user_id,
    CAST(o.created_at AS DATE);

-- Fact Table: Website Sessions
CREATE VIEW gold.fact_sessions 
AS
SELECT
    s.website_session_id,
    s.user_id,
    CAST(s.created_at AS DATE) AS session_date, -- Use CAST for T-SQL
    s.utm_source,
    s.utm_campaign,
    COUNT(p.website_pageview_id) AS pageviews
FROM gold.ext_website_sessions s
LEFT JOIN gold.ext_website_pageviews p
    ON s.website_session_id = p.website_session_id
GROUP BY
    s.website_session_id,
    s.user_id,
    CAST(s.created_at AS DATE),               -- Grouping must match the CAST
    s.utm_source,
    s.utm_campaign;

-- Dim Table: Products
CREATE VIEW gold.dim_products
AS
SELECT
    product_id,
    product_name,
    created_at
FROM gold.ext_products;

-- Dim Table: Dates
CREATE VIEW gold.dim_date 
AS
SELECT DISTINCT
    CAST(created_at AS DATE) AS [date],      -- T-SQL uses CAST to get just the Date
    YEAR(created_at) AS [year],              -- YEAR() is supported
    MONTH(created_at) AS [month],            -- MONTH() is supported
    DAY(created_at) AS [day],                -- DAY() is supported
    DATEPART(WEEK, created_at) AS [week]     -- Use DATEPART with 'WEEK' for week of year
FROM gold.ext_orders;



