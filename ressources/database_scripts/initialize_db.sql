-- Database initialization script
-- Author: Andre Hahn
-- Date: 08.12.2018
-- Changes:
-- 08.12.2018 Andre Hahn - Initial creation. Create table invoice, lineitem. Populating these tables with copy commands.

-- Start psql with the option -s for single-step mode
-- run this script with "\i pathto/initialize_db.sql"

-- Delete Objects if they already exist
DROP DATABASE IF EXISTS steady_dev;
DROP USER IF EXISTS steady_user;

-- Create database object user and database
CREATE USER steady_user WITH NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN NOREPLICATION NOBYPASSRLS CONNECTION LIMIT 2 PASSWORD 'start123';
CREATE DATABASE steady_dev WITH OWNER=steady_user CONNECTION LIMIT = 2;

-- Switch to database steady_dev
\c steady_dev

-- Create type
CREATE TYPE invtype AS ENUM ('hotel', 'train', 'local train', 'cab', 'office supplies', 'other');

-- Create tables
CREATE TABLE invoice (
id int PRIMARY KEY,
inv_num varchar(80) NOT NULL,
inv_date date NOT NULL,
inv_type invtype NOT NULL,
total decimal(12,2) NOT NULL
);

CREATE TABLE lineitem (
id int PRIMARY KEY,
invoice_id int REFERENCES invoice (id),
line_num smallint NOT NULL,
net_amount decimal(12,2) NOT NULL,
vat decimal(12,2) NOT NULL,
gross_amount decimal(12,2) NOT NULL
);

-- Inserting example data
\copy invoice (id, inv_num,inv_date,inv_type,total) from '/projects/steady_v1.0/ressources/example_data/invoices.csv' CSV;
\copy lineitem (id, invoice_id,line_num,net_amount,vat,gross_amount) from '/projects/steady_v1.0/ressources/example_data/lineitems.csv' CSV;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE invoice TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE lineitem TO steady_user;