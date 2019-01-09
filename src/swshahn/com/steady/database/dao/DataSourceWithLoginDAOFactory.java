package swshahn.com.steady.database.dao;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Author: Rene Hahn
 * Description: Use this class to acquire a DataSource connection with user credentials provided.
 *
 * Change Log:
 * 08.01.2019, Rene Hahn - Initial Creation
 */
public class DataSourceWithLoginDAOFactory extends DAOFactory {

    private DataSource dataSource;
    private String username;
    private String password;

    DataSourceWithLoginDAOFactory(DataSource dataSource, String username, String password) {
        this.dataSource = dataSource;
        this.username = username;
        this.password = password;
    }

    @Override
    Connection getConnection() throws SQLException {
        return dataSource.getConnection(username, password);
    }
}
