package swshahn.com.steady.database;

import java.sql.*;

/**
 * Reads records from Database.
 */
public class DatabaseReader {

    private static Connection readerCon;
    private PreparedStatement stmt;
    private ResultSet rs;

    {
        rs = null;
        stmt = null;
    }


    static {
        readerCon = null;
    }

    public DatabaseReader(){
        readerCon = DatabaseConnection.getConnection();
    }

    public void getInvoiceByNumber(int invNumber){
        if(new DatabaseConnection().connectionAvailable() == true) {
            try {
                stmt = readerCon.prepareStatement("SELECT * FROM invoice WHERE id=?");
                stmt.setInt(1, invNumber);
                rs =  stmt.executeQuery();
                while(rs.next()){
                    System.out.print("Column 1 returned ");
                    System.out.println(rs.getString(1));
                    System.out.println("Column 2 returned ");
                    System.out.println(rs.getString(2));
                    System.out.println("Column 3 returned ");
                    System.out.println(rs.getString(3));
                    System.out.println("Column 4 returned ");
                    System.out.println(rs.getString(4));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
