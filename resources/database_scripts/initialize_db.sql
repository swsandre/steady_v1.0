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
\echo "INFO: Creating enum type title_type"
\echo "EXECUTE: CREATE TYPE title_type AS ENUM ('Herr', 'Frau');"
CREATE TYPE title_type AS ENUM ('Herr', 'Frau');

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating enum type cop_type"
\echo "EXECUTE: CREATE TYPE cop_type AS ENUM ('0 T: Zahlbar sofort, rein netto');"
CREATE TYPE cop_type AS ENUM ('0 T: Zahlbar sofort, rein netto');

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating enum type cod_type"
\echo "EXECUTE: CREATE TYPE cod_type AS ENUM ('Lieferung frei Haus.');"
CREATE TYPE cod_type AS ENUM ('Lieferung frei Haus.');

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table countries"
\echo "EXECUTE: CREATE TABLE countries ("
\echo "         id BIGSERIAL PRIMARY KEY,"
\echo "         code CHAR(2) NOT NULL,"
\echo "         country VARCHAR(32) NOT NULL,"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE countries (
id SMALLSERIAL PRIMARY KEY,
code CHAR(2) NOT NULL,
country VARCHAR(32) NOT NULL,
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table currencies"
\echo "EXECUTE: CREATE TABLE currencies ("
\echo "         id BIGSERIAL PRIMARY KEY,"
\echo "         code CHAR(3) NOT NULL,"
\echo "         currency VARCHAR(32) NOT NULL,"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE currencies (
id SMALLSERIAL PRIMARY KEY,
code CHAR(3) NOT NULL,
currency VARCHAR(32) NOT NULL,
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table clients"
\echo "EXECUTE: CREATE TABLE clients ("
\echo "         id BIGSERIAL PRIMARY KEY,"
\echo "         name VARCHAR(128) NOT NULL,"
\echo "         country_id SMALLINT NOT NULL REFERENCES countries (id),"
\echo "         language VARCHAR(32) NOT NULL,"
\echo "         currency_id SMALLINT NOT NULL REFERENCES currencies (id),"
\echo "         timezone VARCHAR(64) NOT NULL,"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE clients (
id BIGSERIAL PRIMARY KEY,
name VARCHAR(128) NOT NULL,
country_id SMALLINT NOT NULL REFERENCES countries (id),
language VARCHAR(32) NOT NULL,
currency_id SMALLINT NOT NULL REFERENCES currencies (id),
timezone VARCHAR(64) NOT NULL, -- Wie sieht der Wert in diesem Feld aus?
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
\echo "         id BIGSERIAL PRIMARY KEY,"
\echo "         clients_id INTEGER NOT NULL REFERENCES clients (id),"
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
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES clients (id),
note TEXT,
customerid VARCHAR(10),   -- customerid must be generated. Must be mandant specific.
supplierid VARCHAR(10),   -- supplierid must be generated. Must be mandant specific.
cidatsupplier VARCHAR(10),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table addresses"
\echo "EXECUTE: CREATE TABLE addresses ("
\echo "         id BIGSERIAL PRIMARY KEY,"
\echo "         clients_id INTEGER NOT NULL REFERENCES clients (id),"
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
CREATE TABLE addresses (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES clients (id),
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
\echo "INFO: Creating table callnumbers"
\echo "EXECUTE: CREATE TABLE callnumbers ("
\echo "         id BIGSERIAL PRIMARY KEY,"
\echo "         clients_id INTEGER NOT NULL REFERENCES clients (id),"
\echo "         type callnumber_type NOT NULL,"
\echo "         number VARCHAR(16) NOT NULL,"
\echo "         contact_id INTEGER NOT NULL REFERENCES contacts (id),"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE callnumbers (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES clients (id),
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
\echo "INFO: Creating table emails"
\echo "EXECUTE: CREATE TABLE emails ("
\echo "         id BIGSERIAL PRIMARY KEY,"
\echo "         clients_id INTEGER NOT NULL REFERENCES clients (id),"
\echo "         type email_type NOT NULL,"
\echo "         email VARCHAR(32) NOT NULL CHECK (position('@' in email) > 0),"
\echo "         contact_id INTEGER NOT NULL REFERENCES contacts (id),"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE emails (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES clients (id),
type email_type NOT NULL,
email VARCHAR(32) NOT NULL CHECK (position('@' in email) > 0),
contact_id INTEGER NOT NULL REFERENCES contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table webadresses"
\echo "EXECUTE: CREATE TABLE webadresses ("
\echo "         id BIGSERIAL PRIMARY KEY,"
\echo "         clients_id INTEGER NOT NULL REFERENCES clients (id),"
\echo "         type email_type NOT NULL,"
\echo "         email VARCHAR(32) NOT NULL,"
\echo "         contact_id INTEGER NOT NULL REFERENCES contacts (id),"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE webadresses (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES clients (id),
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
\echo "INFO: Creating table bankaccounts"
\echo "EXECUTE: CREATE TABLE bankaccounts ("
\echo "         id BIGSERIAL PRIMARY KEY,"
\echo "         clients_id INTEGER NOT NULL REFERENCES clients (id),"
\echo "         iban VARCHAR(34) NOT NULL,"
\echo "         bic VARCHAR(11) NOT NULL,"
\echo "         contact_id INTEGER NOT NULL REFERENCES contacts (id),"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE bankaccounts (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES clients (id),
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
\echo "INFO: Creating table companies"
\echo "EXECUTE: CREATE TABLE compaies ("
\echo "         id BIGSERIAL PRIMARY KEY,"
\echo "         clients_id INTEGER NOT NULL REFERENCES clients (id),"
\echo "         name VARCHAR(32) NOT NULL,"
\echo "         taxnumber VARCHAR(13),"
\echo "         salestaxid VARCHAR(14),"
\echo "         contact_id INTEGER NOT NULL REFERENCES contacts (id),"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE companies (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES clients (id),
name VARCHAR(32) NOT NULL,
taxnumber VARCHAR(13),
salestaxid VARCHAR(14),
taxfree BOOLEAN NOT NULL DEFAULT false,
contact_id INTEGER NOT NULL REFERENCES contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table contactpersons"
\echo "EXECUTE: CREATE TABLE contactpersons ("
\echo "         id BIGSERIAL PRIMARY KEY,"
\echo "         clients_id INTEGER NOT NULL REFERENCES clients (id),"
\echo "         title title_type NOT NULL,"
\echo "         firstname VARCHAR(32) NOT NULL,"
\echo "         lastname VARCHAR(32) NOT NULL,"
\echo "         callnumber VARCHAR(16),"
\echo "         email VARCHAR(32),"
\echo "         company_id INTEGER NOT NULL REFERENCES companies (id),"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE contactpersons (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES clients (id),
title title_type NOT NULL,
firstname VARCHAR(32) NOT NULL,
lastname VARCHAR(32) NOT NULL,
callnumber VARCHAR(16),
email VARCHAR(32),
company_id INTEGER NOT NULL REFERENCES companies (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table conditions"
\echo "EXECUTE: CREATE TABLE conditions ("
\echo "         id BIGSERIAL PRIMARY KEY,"
\echo "         clients_id INTEGER NOT NULL REFERENCES clients (id),"
\echo "         discount NUMERIC(5,2) NOT NULL CHECK (discount <= 100.00 AND discount >= 0.00),"
\echo "         cop cop_type,"
\echo "         cod cod_type,"
\echo "         contact_id INTEGER NOT NULL REFERENCES contacts (id),"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE conditions (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES clients (id),
discount NUMERIC(5,2) NOT NULL CHECK (discount <= 100.00 AND discount >= 0.00),
cop cop_type,
cod cod_type,
contact_id INTEGER NOT NULL REFERENCES contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table persons"
\echo "EXECUTE: CREATE TABLE persons ("
\echo "         id BIGSERIAL PRIMARY KEY,"
\echo "         clients_id INTEGER NOT NULL REFERENCES clients (id),"
\echo "         title title_type NOT NULL,"
\echo "         firstname VARCHAR(32) NOT NULL,"
\echo "         lastname VARCHAR(32) NOT NULL,"
\echo "         contact_id INTEGER NOT NULL REFERENCES contacts (id),"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE persons (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES clients (id),
title title_type NOT NULL,
firstname VARCHAR(32) NOT NULL,
lastname VARCHAR(32) NOT NULL,
contact_id INTEGER NOT NULL REFERENCES contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Grant steady_user SELECT, INSERT, UPDATE, DELETE to all created tables."
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE countries TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE currencies TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE clients TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE contacts TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE addresses TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE callnumbers TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE webadresses TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE bankaccounts TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE companies TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE contactpersons TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE conditions TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE persons TO steady_user;

-- Inserting example data
\copy countries (code, country, creuser, lmuser) from '/projects/steady_v1.0/resources/example_data/countries.csv' CSV;
\copy currencies (code, currency,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/currencies.csv' CSV;
\copy clients (name, country_id,language,currency_id,timezone,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/clients.csv' CSV;