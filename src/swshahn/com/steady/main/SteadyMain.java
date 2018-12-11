package swshahn.com.steady.main;
import swshahn.com.steady.database.DatabaseConnection;
import swshahn.com.steady.database.DatabaseReader;

import java.sql.Connection;

import static swshahn.com.steady.database.DatabaseConnection.*;

/**
 * Author: Andre Hahn
 * Description: Entry point of the application.
 *
 * Change Log:
 * 07.12.2018, Andre Hahn - Initial Creation
 */

public class SteadyMain {
    public static void main(String args[]){
        System.out.println("Steady - Accounting Application");
        DatabaseReader dbr = new DatabaseReader();
        dbr.getInvoiceByNumber(1);
    }
}
