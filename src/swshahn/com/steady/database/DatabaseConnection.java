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
    private static Connection con;

    /**
     * Creates a static connection object to postgresql.
     * Return: DatabaseConnection object
     */
    public static Connection getDBConnection(){
        if(con != null) {
            return con;
        } else {
            try {
                con = DriverManager.getConnection(url, username, password);
                System.out.println("Connection established.");

            } catch (SQLException e) {
                System.out.println("Connection failed.");
                e.printStackTrace();
            }
            return con;
        }
    }
}
