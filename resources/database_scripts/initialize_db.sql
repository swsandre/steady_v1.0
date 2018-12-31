-- Database initialization script
-- Author: Andre Hahn
-- Date: 08.12.2018
-- Changes:
-- 08.12.2018 Andre Hahn - Initial creation. Create table invoice, lineitem. Populating these tables with copy commands.
-- 31.12.2018 Andre Hahn - Initial creation of the table responsible for contact management.

-- Start psql with the option -s for single-step mode
-- run this script with "\i pathto/initialize_db.sql"


\echo "---------------------------------------------------------------------------------------"
\echo "This script initializes the development database"
\echo "Starting ..."
\echo "INFO: Connecting to postgres"
\echo "EXECUTE: \c postgres"
\c postgres

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Drop database steady_dev if exists"
\echo "EXECUTE: DROP DATABASE IF EXISTS steady_dev;"
DROP DATABASE IF EXISTS steady_dev;

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Drop user steady_user if exists"
\echo "EXECUT: DROP USER IF EXISTS steady_user;"
DROP USER IF EXISTS steady_user;


\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Create user steady_user"
\echo "EXECUTE: CREATE USER steady_user WITH NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN NOREPLICATION NOBYPASSRLS CONNECTION LIMIT 2 PASSWORD 'start123';"
CREATE USER steady_user WITH NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN NOREPLICATION NOBYPASSRLS CONNECTION LIMIT 2 PASSWORD 'start123';

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Create database steady_dev"
\echo "EXECUTE: CREATE DATABASE steady_dev WITH OWNER=steady_user CONNECTION LIMIT = 2;"
CREATE DATABASE steady_dev WITH OWNER=steady_user CONNECTION LIMIT = 2;

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Connecting to steady_dev"
\echo "EXECUTE: \c steady_dev"
\c steady_dev

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating enum type addr_type"
\echo "EXECUTE: CREATE TYPE addr_type AS ENUM ('Rechnungsadresse', 'Lieferadresse');"
CREATE TYPE addr_type AS ENUM ('Rechnungsadresse', 'Lieferadresse');

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating enum type callnumber_type"
\echo "EXECUTE: CREATE TYPE callnumber_type AS ENUM ('Geschäftlich', 'Mobil', 'Fax', 'Privat', 'Büro');"
CREATE TYPE callnumber_type AS ENUM ('Geschäftlich', 'Mobil', 'Fax', 'Privat', 'Büro', 'Alternativ');

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating enum type email_type"
\echo "EXECUTE: CREATE TYPE email_type AS ENUM ('Geschäftlich', 'Privat', 'Büro', 'Alternativ');"
CREATE TYPE email_type AS ENUM ('Geschäftlich', 'Privat', 'Büro', 'Alternativ');

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating enum type web_type"
\echo "EXECUTE: CREATE TYPE web_type AS ENUM ('Webseite', 'Skype', 'Messenger', 'Blog', 'Twitter', 'Facebook', 'Sonstiges');"
CREATE TYPE web_type AS ENUM ('Webseite', 'Skype', 'Messenger', 'Blog', 'Twitter', 'Facebook', 'Sonstiges');

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table countries"
\echo "EXECUTE: CREATE TABLE countries ("
\echo "         id SERIAL PRIMARY KEY,"
\echo "         code VARCHAR(2) NOT NULL,
\echo "         country VARCHAR(32) NOT NULL,"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE countries (
id SMALLSERIAL PRIMARY KEY,
code VARCHAR(2) NOT NULL,
country VARCHAR(32) NOT NULL,
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table contacts"
\echo "EXECUTE: CREATE TABLE contacts ("
\echo "         id SERIAL PRIMARY KEY,"
\echo "         note TEXT,"
\echo "         customerid VARCHAR(10),"
\echo "         supplierid VARCHAR(10),"
\echo "         cidatsupplier VARCHAR(10),"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE contacts (
id SERIAL PRIMARY KEY,
note TEXT,
customerid VARCHAR(10),
supplierid VARCHAR(10),
cidatsupplier VARCHAR(10),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table address"
\echo "EXECUTE: CREATE TABLE address ("
\echo "         id SERIAL PRIMARY KEY,"
\echo "         type addr_type NOT NULL,"
\echo "         addr_additional VARCHAR(20),"
\echo "         street_postbox VARCHAR(32),"
\echo "         postalcode VARCHAR(10),"
\echo "         city VARCHAR(32),"
\echo "         country_id SMALLINT NOT NULL REFERENCES countries (id),"
\echo "         contact_id INTEGER NOT NULL REFERENCES contacts (id),"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE address (
id SERIAL PRIMARY KEY,
type addr_type NOT NULL,
addr_additional VARCHAR(20),
street_postbox VARCHAR(32),
postalcode VARCHAR(10),
city VARCHAR(32),
country_id SMALLINT NOT NULL REFERENCES countries (id),
contact_id INTEGER NOT NULL REFERENCES contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table callnumber"
\echo "EXECUTE: CREATE TABLE callnumber ("
\echo "         id SERIAL PRIMARY KEY,"
\echo "         type callnumber_type NOT NULL,"
\echo "         number VARCHAR(16) NOT NULL,"
\echo "         contact_id INTEGER NOT NULL REFERENCES contacts (id),"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE callnumber (
id SERIAL PRIMARY KEY,
type callnumber_type NOT NULL,
number VARCHAR(16) NOT NULL,
contact_id INTEGER NOT NULL REFERENCES contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table email"
\echo "EXECUTE: CREATE TABLE email ("
\echo "         id SERIAL PRIMARY KEY,"
\echo "         type email_type NOT NULL,"
\echo "         email VARCHAR(32) NOT NULL,"
\echo "         contact_id INTEGER NOT NULL REFERENCES contacts (id),"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE email (
id SERIAL PRIMARY KEY,
type email_type NOT NULL,
email VARCHAR(32) NOT NULL,
contact_id INTEGER NOT NULL REFERENCES contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table web"
\echo "EXECUTE: CREATE TABLE web ("
\echo "         id SERIAL PRIMARY KEY,"
\echo "         type email_type NOT NULL,"
\echo "         email VARCHAR(32) NOT NULL,"
\echo "         contact_id INTEGER NOT NULL REFERENCES contacts (id),"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE web (
id SERIAL PRIMARY KEY,
type email_type NOT NULL,
email VARCHAR(32) NOT NULL,
contact_id INTEGER NOT NULL REFERENCES contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating bankaccount"
\echo "EXECUTE: CREATE TABLE bankaccount ("
\echo "         id SERIAL PRIMARY KEY,"
\echo "         iban VARCHAR(34) NOT NULL,"
\echo "         bic VARCHAR(11) NOT NULL,"
\echo "         contact_id INTEGER NOT NULL REFERENCES contacts (id),"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE bankaccount (
id SERIAL PRIMARY KEY,
iban VARCHAR(34) NOT NULL,
bic VARCHAR(11) NOT NULL,
contact_id INTEGER NOT NULL REFERENCES contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating company"
\echo "EXECUTE: CREATE TABLE company ("
\echo "         id SERIAL PRIMARY KEY,"
\echo "         name VARCHAR(32) NOT NULL,"
\echo "         taxnumber VARCHAR(13),"
\echo "         salestaxid VARCHAR(14),"
\echo "         contact_id INTEGER NOT NULL REFERENCES contacts (id),"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE company (
id SERIAL PRIMARY KEY,
name VARCHAR(32) NOT NULL,
taxnumber VARCHAR(13),
salestaxid VARCHAR(14),
contact_id INTEGER NOT NULL REFERENCES contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);


-- Inserting example data
\copy invoice (id, inv_num,inv_date,inv_type,total) from '/projects/steady_v1.0/ressources/example_data/invoices.csv' CSV;
\copy lineitem (id, invoice_id,line_num,net_amount,vat,gross_amount) from '/projects/steady_v1.0/ressources/example_data/lineitems.csv' CSV;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE invoice TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE lineitem TO steady_user;