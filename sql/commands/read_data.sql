/*
*   SQL commands to read data from CSV files into corresponding tables
*   using PostgreSQL COPY command.
*   Note: Adjust file paths as needed based on your environment.
*/


COPY website_sessions
FROM '/absolute/path/website_sessions.csv'
DELIMITER ','
CSV HEADER;

COPY website_pageviews
FROM '/absolute/path/website_pageviews.csv'
DELIMITER ','
CSV HEADER;

COPY products
FROM '/absolute/path/products.csv'
DELIMITER ','
CSV HEADER;

COPY orders
FROM '/absolute/path/orders.csv'
DELIMITER ','
CSV HEADER;

COPY order_items
FROM '/absolute/path/order_items.csv'
DELIMITER ','
CSV HEADER;

COPY order_item_refunds
FROM '/absolute/path/order_item_refunds.csv'
DELIMITER ','
CSV HEADER;
