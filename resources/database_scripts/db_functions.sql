-- Database Function Definitions
-- Author: Andre Hahn
-- Date: 04.01.2019
-- Changes:
-- 04.01.2019 Andre Hahn - Initial creation.

CREATE FUNCTION insertContact(client_id INTEGER, note TEXT, cidatsupplier VARCHAR(10), creuser VARCHAR(8), lmuser VARCHAR(8)) RETURNS void AS $$
DECLARE
    maxcustomerid INTEGER DEFAULT 10000;
    maxsupplierid INTEGER DEFAULT 70000;
BEGIN
END;
$$ LANGUAGE plpgsql;