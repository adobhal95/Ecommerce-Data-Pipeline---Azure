/*
* SQL Script: table_creation.sql
* Description: This script creates the necessary tables for tracking website sessions,
* pageviews, orders, products, order items, and refunds.
* It also includes commands to drop existing tables if they exist to avoid conflicts.
* Note: Adjust data types and constraints as needed based on specific requirements. As i am using, 
* PostgreSQL as database, BIGSERIAL is used for auto-incrementing primary keys.
*/

-- =========================
-- Create Database Schema
-- =========================
CREATE DATABASE ecommerce_db;
CREATE SCHEMA IF NOT EXISTS ecommerce;

-- =========================
-- Use the Created Schema and Database
-- =========================
Use ecommerce_db;
Use ecommerce;


-- =========================
-- DROP TABLES IF THEY EXIST
-- =========================
drop table if exists website_sessions;
drop table if exists website_pageviews;
drop table if exists orders;
drop table if exists products;
drop table if exists order_items;
drop table if exists order_item_refunds;

-- =========================
-- WEBSITE SESSIONS
-- =========================
CREATE TABLE website_sessions (
    website_session_id BIGSERIAL PRIMARY KEY,
    created_at         TIMESTAMP NOT NULL,
    user_id            BIGINT NOT NULL,
    is_repeat_session  SMALLINT NOT NULL,
    utm_source         VARCHAR(12),
    utm_campaign       VARCHAR(20),
    utm_content        VARCHAR(15),
    device_type        VARCHAR(15),
    http_referer       VARCHAR(30)
);

CREATE INDEX idx_website_sessions_user_id
    ON website_sessions(user_id);


-- =========================
-- WEBSITE PAGEVIEWS
-- =========================
CREATE TABLE website_pageviews (
    website_pageview_id BIGSERIAL PRIMARY KEY,
    created_at          TIMESTAMP NOT NULL,
    website_session_id  BIGINT NOT NULL,
    pageview_url        VARCHAR(50) NOT NULL
);

CREATE INDEX idx_website_pageviews_website_session_id
    ON website_pageviews(website_session_id);


-- =========================
-- PRODUCTS
-- =========================
CREATE TABLE products (
    product_id   BIGSERIAL PRIMARY KEY,
    created_at   TIMESTAMP NOT NULL,
    product_name VARCHAR(50) NOT NULL
);


-- =========================
-- ORDERS
-- =========================
CREATE TABLE orders (
    order_id            BIGSERIAL PRIMARY KEY,
    created_at          TIMESTAMP NOT NULL,
    website_session_id  BIGINT NOT NULL,
    user_id             BIGINT NOT NULL,
    primary_product_id  SMALLINT NOT NULL,
    items_purchased     SMALLINT NOT NULL,
    price_usd           NUMERIC(6,2) NOT NULL,
    cogs_usd            NUMERIC(6,2) NOT NULL
);

CREATE INDEX idx_orders_website_session_id
    ON orders(website_session_id);


-- =========================
-- ORDER ITEMS
-- =========================
CREATE TABLE order_items (
    order_item_id    BIGSERIAL PRIMARY KEY,
    created_at       TIMESTAMP NOT NULL,
    order_id         BIGINT NOT NULL,
    product_id       SMALLINT NOT NULL,
    is_primary_item  SMALLINT NOT NULL,
    price_usd        NUMERIC(6,2) NOT NULL,
    cogs_usd         NUMERIC(6,2) NOT NULL
);

CREATE INDEX idx_order_items_order_id
    ON order_items(order_id);


-- =========================
-- ORDER ITEM REFUNDS
-- =========================
CREATE TABLE order_item_refunds (
    order_item_refund_id BIGSERIAL PRIMARY KEY,
    created_at           TIMESTAMP NOT NULL,
    order_item_id        BIGINT NOT NULL,
    order_id             BIGINT NOT NULL,
    refund_amount_usd    NUMERIC(6,2) NOT NULL
);

CREATE INDEX idx_order_item_refunds_order_id
    ON order_item_refunds(order_id);

CREATE INDEX idx_order_item_refunds_order_item_id
    ON order_item_refunds(order_item_id);
