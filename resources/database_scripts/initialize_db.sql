-- Database initialization script
-- Author: Andre Hahn
-- Date: 08.12.2018
-- Changes:
-- 08.12.2018 Andre Hahn - Initial creation. Create table invoice, lineitem. Populating these tables with copy commands.
-- 31.12.2018 Andre Hahn - Initial creation of the table responsible for contact management.
-- 03.01.2019 Andre Hahn - Test data created and \copy commands added to the script. Schemas bmdata, contacts, config added.

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
\echo "INFO: Create schemas"
CREATE SCHEMA bmdata AUTHORIZATION steady_user;
CREATE SCHEMA contacts AUTHORIZATION steady_user;
CREATE SCHEMA config AUTHORIZATION steady_user;

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
\echo "EXECUTE: CREATE TYPE contacts.addr_type AS ENUM ('Rechnungsadresse', 'Lieferadresse');"
CREATE TYPE contacts.addr_type AS ENUM ('Rechnungsadresse', 'Lieferadresse');

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating enum type callnumber_type"
\echo "EXECUTE: CREATE TYPE contacts.callnumber_type AS ENUM ('Geschäftlich', 'Mobil', 'Fax', 'Privat', 'Büro');"
CREATE TYPE contacts.callnumber_type AS ENUM ('Geschäftlich', 'Mobil', 'Fax', 'Privat', 'Büro', 'Alternativ');

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating enum type email_type"
\echo "EXECUTE: CREATE TYPE contacts.email_type AS ENUM ('Geschäftlich', 'Privat', 'Büro', 'Alternativ');"
CREATE TYPE contacts.email_type AS ENUM ('Geschäftlich', 'Privat', 'Büro', 'Alternativ');

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating enum type web_type"
\echo "EXECUTE: CREATE TYPE contacts.web_type AS ENUM ('Webseite', 'Skype', 'Messenger', 'Blog', 'Twitter', 'Facebook', 'Sonstiges');"
CREATE TYPE contacts.web_type AS ENUM ('Webseite', 'Skype', 'Messenger', 'Blog', 'Twitter', 'Facebook', 'Sonstiges');

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating enum type title_type"
\echo "EXECUTE: CREATE TYPE contacts.title_type AS ENUM ('Herr', 'Frau');"
CREATE TYPE contacts.title_type AS ENUM ('Herr', 'Frau');

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table countries"
\echo "EXECUTE: CREATE TABLE bmdata.countries ("
\echo "         id BIGSERIAL PRIMARY KEY,"
\echo "         code CHAR(2) NOT NULL,"
\echo "         country VARCHAR(32) NOT NULL,"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE bmdata.countries (
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
\echo "EXECUTE: CREATE TABLE bmdata.currencies ("
\echo "         id BIGSERIAL PRIMARY KEY,"
\echo "         code CHAR(3) NOT NULL,"
\echo "         currency VARCHAR(32) NOT NULL,"
\echo "         creuser VARCHAR(8) NOT NULL,"
\echo "         credat TIMESTAMP NOT NULL DEFAULT NOW(),"
\echo "         lmuser VARCHAR(8) NOT NULL,"
\echo "         lastmodified TIMESTAMP NOT NULL DEFAULT NOW()"
\echo "         );"
CREATE TABLE bmdata.currencies (
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
\echo "EXECUTE: CREATE TABLE config.clients ("
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
CREATE TABLE config.clients (
id BIGSERIAL PRIMARY KEY,
name VARCHAR(128) NOT NULL,
country_id SMALLINT NOT NULL REFERENCES bmdata.countries (id),
language VARCHAR(32) NOT NULL,
currency_id SMALLINT NOT NULL REFERENCES bmdata.currencies (id),
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
\echo "EXECUTE: CREATE TABLE contacts.contacts ("
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
CREATE TABLE contacts.contacts (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES config.clients (id),
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
\echo "EXECUTE: CREATE TABLE contacts.addresses ("
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
CREATE TABLE contacts.addresses (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES config.clients (id),
type contacts.addr_type NOT NULL,
addr_additional VARCHAR(20),
street_postbox VARCHAR(32),
postalcode VARCHAR(10),
city VARCHAR(32),
country_id SMALLINT NOT NULL REFERENCES bmdata.countries (id),
contact_id INTEGER NOT NULL REFERENCES contacts.contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table callnumbers"
\echo "EXECUTE: CREATE TABLE contacts.callnumbers ("
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
CREATE TABLE contacts.callnumbers (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES config.clients (id),
type contacts.callnumber_type NOT NULL,
number VARCHAR(16) NOT NULL,
contact_id INTEGER NOT NULL REFERENCES contacts.contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table emails"
\echo "EXECUTE: CREATE TABLE contacts.emails ("
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
CREATE TABLE contacts.emails (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES config.clients (id),
type contacts.email_type NOT NULL,
email VARCHAR(32) NOT NULL CHECK (position('@' in email) > 0),
contact_id INTEGER NOT NULL REFERENCES contacts.contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table webaddresses"
\echo "EXECUTE: CREATE TABLE contacts.webaddresses ("
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
CREATE TABLE contacts.webaddresses (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES config.clients (id),
type contacts.web_type NOT NULL,
webaddress VARCHAR(32) NOT NULL,
contact_id INTEGER NOT NULL REFERENCES contacts.contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table bankaccounts"
\echo "EXECUTE: CREATE TABLE contacts.bankaccounts ("
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
CREATE TABLE contacts.bankaccounts (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES config.clients (id),
iban VARCHAR(34) NOT NULL,
bic VARCHAR(11) NOT NULL,
contact_id INTEGER NOT NULL REFERENCES contacts.contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table companies"
\echo "EXECUTE: CREATE TABLE contacts.compaies ("
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
CREATE TABLE contacts.companies (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES config.clients (id),
name VARCHAR(32) NOT NULL,
taxnumber VARCHAR(13),
salestaxid VARCHAR(14),
taxfree BOOLEAN NOT NULL DEFAULT false,
contact_id INTEGER NOT NULL REFERENCES contacts.contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table contactpersons"
\echo "EXECUTE: CREATE TABLE contacts.contactpersons ("
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
CREATE TABLE contacts.contactpersons (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES config.clients (id),
title contacts.title_type NOT NULL,
firstname VARCHAR(32) NOT NULL,
lastname VARCHAR(32) NOT NULL,
callnumber VARCHAR(16),
email VARCHAR(32),
company_id INTEGER NOT NULL REFERENCES contacts.companies (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table conditions"
\echo "EXECUTE: CREATE TABLE contacts.conditions ("
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
CREATE TABLE contacts.conditions (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES config.clients (id),
discount NUMERIC(5,2) NOT NULL CHECK (discount <= 100.00 AND discount >= 0.00),
cop VARCHAR(16),
cod VARCHAR(16),
contact_id INTEGER NOT NULL REFERENCES contacts.contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Creating table persons"
\echo "EXECUTE: CREATE TABLE contacts.persons ("
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
CREATE TABLE contacts.persons (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES config.clients (id),
title contacts.title_type NOT NULL,
firstname VARCHAR(32) NOT NULL,
lastname VARCHAR(32) NOT NULL,
contact_id INTEGER NOT NULL REFERENCES contacts.contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Grant steady_user SELECT, INSERT, UPDATE, DELETE to all created tables."
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE bmdata.countries TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE bmdata.currencies TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE config.clients TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE contacts.contacts TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE contacts.addresses TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE contacts.callnumbers TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE contacts.webaddresses TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE contacts.bankaccounts TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE contacts.companies TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE contacts.contactpersons TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE contacts.conditions TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE contacts.persons TO steady_user;


\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Populate tables with test data."
\echo
\echo "TABLE: countries"
\copy bmdata.countries (code, country, creuser, lmuser) from '/projects/steady_v1.0/resources/example_data/countries.csv' CSV;
\echo "TABLE: currencies"
\copy bmdata.currencies (code, currency,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/currencies.csv' CSV;
\echo "TABLE: clients"
\copy config.clients (name, country_id,language,currency_id,timezone,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/clients.csv' CSV;
\echo "TABLE: contacts"
\copy contacts.contacts (clients_id, note,customerid,supplierid,cidatsupplier,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/contacts.csv' CSV;
\echo "TABLE: addresses"
\copy contacts.addresses (clients_id, type,addr_additional,street_postbox,postalcode,city,country_id,contact_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/addresses.csv' CSV;
\echo "TABLE: callnumbers"
\copy contacts.callnumbers (clients_id, type,number,contact_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/callnumbers.csv' CSV;
\echo "TABLE: emails"
\copy contacts.emails (clients_id, type,email,contact_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/emails.csv' CSV;
\echo "TABLE: webaddresses"
\copy contacts.webaddresses (clients_id, type,webaddress,contact_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/webaddresses.csv' CSV;
\echo "TABLE: bankaccounts"
\copy contacts.bankaccounts (clients_id, iban,bic,contact_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/bankaccounts.csv' CSV;
\echo "TABLE: companies"
\copy contacts.companies (clients_id, name,taxnumber,salestaxid,taxfree,contact_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/companies.csv' CSV;
\echo "TABLE: contactpersons"
\copy contacts.contactpersons (clients_id, title,firstname,lastname,callnumber,email,company_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/contactpersons.csv' CSV;
\echo "TABLE: conditions"
\copy contacts.conditions (clients_id, discount,cop,cod,contact_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/conditions.csv' CSV;
\echo "TABLE: persons"
\copy contacts.persons (clients_id, title,firstname,lastname,contact_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/persons.csv' CSV;

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Processed."