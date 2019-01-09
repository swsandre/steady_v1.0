package swshahn.com.steady.database.dao;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Author: Rene Hahn
 * Description: Use this class to acquire a DataSource connection without user credentials.
 *
 * Change Log:
 * 08.01.2019, Rene Hahn - Initial Creation
 */
public class DataSourceDAOFactory extends DAOFactory {
    private DataSource dataSource;

    DataSourceDAOFactory(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}
