package swshahn.com.steady.main;
import swshahn.com.steady.database.DatabaseConnection;
import swshahn.com.steady.database.DatabaseReader;
import swshahn.com.steady.model.Country;

import java.sql.Connection;
import java.text.SimpleDateFormat;

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
        /*
        System.out.println("Steady - Accounting Application");
        DatabaseReader dbr = new DatabaseReader();
        dbr.getInvoiceByNumber(1);
        */

        Country country = new Country();
        country.setId(12345L);
        country.setCode("DE");
        country.setCountry("Germany");
        country.setCreuser("rhahn");
        country.setCredat(new SimpleDateFormat("yyyy-MM-dd").parse("2019-01-21"));
        country.setLmuser("rhahn");
        country.setLastmodified(new SimpleDateFormat("yyyy-MM-dd").parse("2029-01-02"));

        System.out.println("First Country: " + country.toString());
    }
}
