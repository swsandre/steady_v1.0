SET search_path TO config, tmdata, bmdata, contacts, public;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE countries TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE currencies TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE clients TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE contacts TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE addresses TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE callnumbers TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE webaddresses TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE bankaccounts TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE companies TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE contactpersons TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE conditions TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE persons TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE messages TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE actionlog TO steady_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE errorlog TO steady_user;
GRANT USAGE ON ALL sequences IN schema config TO steady_user;
GRANT USAGE ON ALL sequences IN schema bmdata TO steady_user;
GRANT USAGE ON ALL sequences IN schema contacts TO steady_user;
GRANT USAGE ON ALL sequences IN schema tmdata TO steady_user;
