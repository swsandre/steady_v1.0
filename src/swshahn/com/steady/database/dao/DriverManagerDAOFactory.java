package swshahn.com.steady.database.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Author: Rene Hahn
 * Description: Concrete Factory class for acquiring a database connection via DriverManager.
 *
 * Change Log:
 * 04.01.2019, Rene Hahn - Initial Creation
 */

public class DriverManagerDAOFactory extends DAOFactory {
    private String url;
    private String username;
    private String password;

    public DriverManagerDAOFactory(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }

    @Override
    Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }
}
