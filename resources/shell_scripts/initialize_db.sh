#!/bin/bash

echo "Drop database steady_dev if it exists."
dropdb --if-exists steady_dev
if [[ $? != 0 ]]; then
    echo "Could not drop database steady_dev."
    echo 1
    exit
fi

echo "Drop user steady_user it it exists."
dropuser --if-exists steady_user
if [[ $? != 0 ]]; then
    echo "Could not drop user steady_user."
    echo 1
    exit
fi

echo "Creating the user steady_user."
psql -c "CREATE USER steady_user WITH NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN NOREPLICATION NOBYPASSRLS CONNECTION LIMIT 10 PASSWORD 'start123';" -o ./log/create_user.log
if [[ $? != 0 ]]; then
    echo "User steady_user could not be created!".
    echo 1
    exit
fi

echo "Creating the database steady_dev."
psql -c "CREATE DATABASE steady_dev WITH OWNER=steady_user CONNECTION LIMIT = 10;" -o ./log/create_db.log
if [[ $? != 0 ]]; then
    echo "Database steady_dev could not be created."
    echo 1
    exit
fi

echo "Creating the table structure."
psql -d steady_dev -f ../database_scripts/create_structure.sql -o ./log/create_structure.log
if [[ $? != 0 ]]; then
    echo "Tables could not be created."
    echo 1
    exit
fi

echo "Grant user steady_user."
psql -d steady_dev -f ../database_scripts/grants.sql -o ./log/grant_user.log
if [[ $? != 0 ]]; then
    echo "steady_user counld not be grant to the object(s)."
    echo 1
    exit
fi

echo "Create the functions."
psql -d steady_dev -f ../database_scripts/functions.sql -o ./log/create_functions.log
if [[ $? != 0 ]]; then
    echo "Functions could not be created."
    echo 1
    exit
fi

echo "Load example data."
psql -d steady_dev -f ../database_scripts/example_data.sql -o ./log/load_data.log
if [[ $? != 0 ]]; then
    echo "Example data could not be loaded."
    echo 1
    exit
fi

echo "Done."
exit 0