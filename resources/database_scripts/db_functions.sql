-- Database Function Definitions
-- Author: Andre Hahn
-- Date: 04.01.2019
-- Changes:
-- 04.01.2019 Andre Hahn - Initial creation.
-- 09.01.2019 Andre Hahn - Creating the function insertcontact.

CREATE FUNCTION contacts.insertcontact(p_client_id INTEGER, p_note TEXT, p_cidatsupplier VARCHAR(10), p_creuser VARCHAR(8), p_lmuser VARCHAR(8), p_cors CHAR(1)) RETURNS BIGINT AS $$
DECLARE
    v_nextcustomerid INTEGER DEFAULT 10000;
    v_nextsupplierid INTEGER DEFAULT 70000;
    v_currcustomerid INTEGER;
    v_currsupplierid INTEGER;
    v_stmt TEXT;
    v_row_count INTEGER;
    v_id BIGINT;
BEGIN

    IF p_cors = 'C' THEN
        SELECT max(customerid) INTO STRICT v_currcustomerid FROM contacts.contacts WHERE clients_id = p_client_id;

        -- At least one contact is already there. Increment customerid by 1.
        IF v_currcustomerid is not null THEN
            v_nextcustomerid := v_currcustomerid + 1;
        END IF;

        v_stmt := 'INSERT INTO contacts.contacts(clients_id, note, customerid, supplierid, cidatsupplier, creuser, lmuser) VALUES (' || p_client_id || ',' ||
                        coalesce('''' || p_note || '''', 'NULL') || ',' || v_nextcustomerid || ', NULL,' || coalesce('''' || p_cidatsupplier || '''', 'NULL') ||
                        ',' || coalesce('''' || p_creuser || '''', 'NULL') || ',' || coalesce('''' || p_lmuser || '''', 'NULL') || ') RETURNING id ;';

    END IF;

    IF p_cors = 'S' THEN
        SELECT max(supplierid) INTO STRICT v_currsupplierid FROM contacts.contacts WHERE clients_id = p_client_id;

        -- At least one contact is already there. Increment supplierid by 1.
        IF v_currsupplierid is not null THEN
            v_nextsupplierid := v_currsupplierid + 1;
        END IF;

        v_stmt := 'INSERT INTO contacts.contacts(clients_id, note, customerid, supplierid, cidatsupplier, creuser, lmuser) VALUES (' || p_client_id || ',' ||
                        coalesce('''' || p_note || '''', 'NULL') || ', NULL,' || v_nextsupplierid || ',' || coalesce('''' || p_cidatsupplier || '''', 'NULL') ||
                        ',' || coalesce('''' || p_creuser || '''', 'NULL') || ',' || coalsece('''' || p_lmuser || '''', 'NULL') || ') RETURNING id ;';

    END IF;
    EXECUTE v_stmt INTO v_id;
    RETURN v_id;
END;
$$ LANGUAGE plpgsql;



INSERT INTO contacts.contacts (clients_id, note, customerid, supplierid, cidatsupplier, creuser, lmuser) VALUES (2, 'TEST', 10007, NULL, NULL, 'ahahn', 'ahahn');
commit;

select contacts.insertcontact(2,'TEST',NULL,'ahahn','ahahn','C');