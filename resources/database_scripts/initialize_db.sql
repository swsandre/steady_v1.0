-- Database initialization script
-- Author: Andre Hahn
-- Date: 08.12.2018
-- Changes:
-- 08.12.2018 Andre Hahn - Initial creation. Create table invoice, lineitem. Populating these tables with copy commands.
-- 31.12.2018 Andre Hahn - Initial creation of the table responsible for contact management.
-- 03.01.2019 Andre Hahn - Test data created and \copy commands added to the script. Schemas bmdata, contacts, config added.
-- 03.01.2019 Andre Hahn - Renamed column countries.country to countries.name and currencies.currency to currencies.name.
-- 03.01.2019 Andre Hahn - Changed the SCHEMA search_path to config, bmdata, contacts, public.
-- 04.01.2019 Andre Hahn - Changed the datatypes of contacts.customerid and contacts.supplierid from VARCHAR(10) to INTEGER.
--                         It makes it easier to increment the id in the stored procedure insertContact. And change the copy commands
--                         to handle null values (NULL as '').
-- 16.01.2019 Andre Hahn - Created the table actionlog. And used the metacommand \p for printing the last buffer (statement).

-- Start psql with the option -s for single-step mode
-- run this script with "\i pathto/initialize_db.sql"





\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Populate tables with test data."
\echo
\echo "TABLE: countries"
\copy countries (code, name, creuser, lmuser) from '/projects/steady_v1.0/resources/example_data/countries.csv' DELIMITER ',' NULL as '' CSV;
\echo "TABLE: currencies"
\copy currencies (code, name,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/currencies.csv' DELIMITER ',' NULL as '' CSV;
\echo "TABLE: clients"
\copy clients (name, country_id,language,currency_id,timezone,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/clients.csv' CSV;
\echo "TABLE: contacts"
\copy contacts (clients_id, note,customerid,supplierid,cidatsupplier,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/contacts.csv' DELIMITER ',' NULL as '' CSV;
\echo "TABLE: addresses"
\copy addresses (clients_id, type,addr_additional,street_postbox,postalcode,city,country_id,contact_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/addresses.csv' DELIMITER ',' NULL as '' CSV;
\echo "TABLE: callnumbers"
\copy callnumbers (clients_id, type,number,contact_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/callnumbers.csv' DELIMITER ',' NULL as '' CSV;
\echo "TABLE: emails"
\copy emails (clients_id, type,email,contact_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/emails.csv' DELIMITER ',' NULL as '' CSV;
\echo "TABLE: webaddresses"
\copy webaddresses (clients_id, type,webaddress,contact_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/webaddresses.csv' DELIMITER ',' NULL as '' CSV;
\echo "TABLE: bankaccounts"
\copy bankaccounts (clients_id, iban,bic,contact_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/bankaccounts.csv' DELIMITER ',' NULL as '' CSV;
\echo "TABLE: companies"
\copy companies (clients_id, name,taxnumber,salestaxid,taxfree,contact_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/companies.csv' DELIMITER ',' NULL as '' CSV;
\echo "TABLE: contactpersons"
\copy contactpersons (clients_id, title,firstname,lastname,callnumber,email,company_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/contactpersons.csv' DELIMITER ',' NULL as '' CSV;
\echo "TABLE: conditions"
\copy conditions (clients_id, discount,cop,cod,contact_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/conditions.csv' DELIMITER ',' NULL as '' CSV;
\echo "TABLE: persons"
\copy persons (clients_id, title,firstname,lastname,contact_id,creuser,lmuser) from '/projects/steady_v1.0/resources/example_data/persons.csv' DELIMITER ',' NULL as '' CSV;

\echo
\echo
\echo "---------------------------------------------------------------------------------------"
\echo "INFO: Processed."