-- schemas
CREATE SCHEMA bmdata AUTHORIZATION steady_user;
CREATE SCHEMA contacts AUTHORIZATION steady_user;
CREATE SCHEMA config AUTHORIZATION steady_user;
CREATE SCHEMA tmdata AUTHORIZATION steady_user;

-- schema search path
SET search_path TO config, tmdata, bmdata, contacts, public;

-- types
CREATE TYPE contacts.addr_type AS ENUM ('Rechnungsadresse', 'Lieferadresse');
CREATE TYPE contacts.callnumber_type AS ENUM ('Geschäftlich', 'Mobil', 'Fax', 'Privat', 'Büro', 'Alternativ');
CREATE TYPE contacts.email_type AS ENUM ('Geschäftlich', 'Privat', 'Büro', 'Alternativ');
CREATE TYPE contacts.web_type AS ENUM ('Webseite', 'Skype', 'Messenger', 'Blog', 'Twitter', 'Facebook', 'Sonstiges');
CREATE TYPE contacts.title_type AS ENUM ('Herr', 'Frau');
CREATE TYPE tmdata.action_type AS ENUM ('INSERT', 'UPDATE', 'DELETE');
CREATE TYPE tmdata.message_type AS ENUM ('INFO', 'ERROR');

-- tables
CREATE TABLE tmdata.messages (
id SMALLINT UNIQUE NOT NULL,
message_type message_type NOT NULL,
message TEXT NOT NULL
);

CREATE TABLE tmdata.actionlog (
id BIGSERIAL PRIMARY KEY,
logts TIMESTAMP NOT NULL DEFAULT NOW(),
action_user VARCHAR(8) NOT NULL,
action action_type NOT NULL,
sql_statement VARCHAR(512) NOT NULL
);

CREATE TABLE tmdata.errorlog (
id BIGSERIAL PRIMARY KEY,
logts TIMESTAMP NOT NULL DEFAULT NOW(),
actionlog_id BIGINT NOT NULL REFERENCES actionlog (id),
message_id SMALLINT NOT NULL REFERENCES messages (id)
);

CREATE TABLE bmdata.countries (
id SMALLSERIAL PRIMARY KEY,
code CHAR(2) NOT NULL,
name VARCHAR(32) NOT NULL,
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE bmdata.currencies (
id SMALLSERIAL PRIMARY KEY,
code CHAR(3) NOT NULL,
name VARCHAR(32) NOT NULL,
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE config.clients (
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

CREATE TABLE contacts.contacts (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES clients (id),
note TEXT,
customerid INTEGER,   -- customerid must be generated. Must be mandant specific.
supplierid INTEGER,   -- supplierid must be generated. Must be mandant specific.
cidatsupplier VARCHAR(10),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE contacts.addresses (
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

CREATE TABLE contacts.callnumbers (
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

CREATE TABLE contacts.emails (
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

CREATE TABLE contacts.webaddresses (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES clients (id),
type web_type NOT NULL,
webaddress VARCHAR(32) NOT NULL,
contact_id INTEGER NOT NULL REFERENCES contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE contacts.bankaccounts (
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

CREATE TABLE contacts.companies (
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

CREATE TABLE contacts.contactpersons (
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

CREATE TABLE contacts.conditions (
id BIGSERIAL PRIMARY KEY,
clients_id INTEGER NOT NULL REFERENCES clients (id),
discount NUMERIC(5,2) NOT NULL CHECK (discount <= 100.00 AND discount >= 0.00),
cop VARCHAR(16),
cod VARCHAR(16),
contact_id INTEGER NOT NULL REFERENCES contacts (id),
creuser VARCHAR(8) NOT NULL,
credat TIMESTAMP NOT NULL DEFAULT NOW(),
lmuser VARCHAR(8) NOT NULL,
lastmodified TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE contacts.persons (
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