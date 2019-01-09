package swshahn.com.steady.database.dao;

import swshahn.com.steady.database.dao.interfaces.CountryDAO;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Author: Rene Hahn
 * Description: Abstract class uses factory pattern to instantiate objects for acquiring
 * database connections via
 * - Driver Manager (DriverManagerDAOFactory.cls),
 * - Data Source with Login (DataSourceWithLoginDAOFactory.cls),
 * - Data Source without Login (DataSourceDAOFactory.cls).
 * Consumer calls getInstance() and passes the database name.
 * <p>
 * Change Log:
 * 04.01.2019, Rene Hahn - Initial Creation
 */

public abstract class DAOFactory {
    private static final String PROPERTY_URL = "url";
    private static final String PROPERTY_DRIVER = "driver";
    private static final String PROPERTY_USERNAME = "username";
    private static final String PROPERTY_PASSWORD = "password";
    private static final String PROPERTY_SUBKEY_JDBC = "jdbc";

    public static DAOFactory getInstance(String dbname) throws DAOConfigurationException {
        if (dbname == null) {
            throw new DAOConfigurationException("Database name is null.");
        }

        DAOProperties properties = new DAOProperties(dbname + "." + PROPERTY_SUBKEY_JDBC);
        String url = properties.getProperty(PROPERTY_URL, true);
        String driver = properties.getProperty(PROPERTY_DRIVER, false);
        String password = properties.getProperty(PROPERTY_PASSWORD, false);
        String username = properties.getProperty(PROPERTY_USERNAME, password != null);

        DAOFactory instance;

        // If driver is specified then load it to let it register itself with DriverManager.
        if (driver != null) {
            try {
                Class.forName(driver);
            } catch (ClassNotFoundException e) {
                throw new DAOConfigurationException(
                        "Driver class " + driver + " is missing in classpath.", e
                );
            }
            instance = new DriverManagerDAOFactory(url, username, password);

            // Else assume URL as DataSource lookup it in JNDI.
        } else {
            DataSource dataSource;

            try {
                dataSource = (DataSource) new InitialContext().lookup(url);
            } catch (NamingException e) {
                throw new DAOConfigurationException(
                        "DataSource is " + url + " is missing in JNDI.", e
                );
            }

            if (username != null) {
                instance = new DataSourceWithLoginDAOFactory(dataSource, username, password);
            } else {
                instance = new DataSourceDAOFactory(dataSource);
            }
        }

        return instance;
    }

    /**
     * Returns a connection to the database. Package private so it can be used inside the dao package only.
     *
     * @return A connection to the database.
     * @throws SQLException If acquiring the connection fails.
     */
    abstract Connection getConnection() throws SQLException;

    /**
     * Returns the Country DAO associated with the current DAOFactory.
     *
     * @return The Country DAO associated with the current DAOFactory.
     */
    public CountryDAO getCountryDAO() {
        return new CountryDAOJDBC(this);
    }
}
