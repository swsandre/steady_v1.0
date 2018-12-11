package swshahn.com.steady.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Author: Andre Hahn
 * Description: Creates the Database Connection (PostgreSQL)
 *
 * Change Log:
 * 07.12.2018, Andre Hahn - Initial Creation
 * 09.12.2018, Andre Hahn - method getDBConnection created. Return a static connection object.
 */

public class DatabaseConnection {

    // Connection parameter.
    private static String url = "jdbc:postgresql://localhost:5432/steady_dev";
    private static String username = "steady_user";
    private static String password = "start123";
    private static Connection con = null;

    /**
     * Creates a static connection object to postgresql.
     * Return: DatabaseConnection object
     */
    static Connection createPostgreSQLConnection() {
        try {
            con = DriverManager.getConnection(url, username, password);
            System.out.println("Connection established. 1");

        } catch (SQLException e) {
            System.out.println("Connection failed. 1");
            e.printStackTrace();
        }
        return con;
    }

    public static Connection getConnection(){
        return createPostgreSQLConnection();
    }

    public Boolean connectionAvailable() {
        return con != null;
    }

    public void closeConnection(){
        try {
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
