package swshahn.com.steady.main;
import swshahn.com.steady.database.DatabaseConnection;
import swshahn.com.steady.database.DatabaseReader;
import swshahn.com.steady.database.dao.DAOProperties;
import swshahn.com.steady.model.Client;
import swshahn.com.steady.model.Country;
import swshahn.com.steady.model.Currency;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Date;

import static swshahn.com.steady.database.DatabaseConnection.*;

/**
 * Author: Andre Hahn
 * Description: Entry point of the application.
 *
 * Change Log:
 * 07.12.2018, Andre Hahn - Initial Creation
 */

public class SteadyMain {
    public static void main(String args[]) throws Exception {
        /*
        System.out.println("Steady - Accounting Application");
        DatabaseReader dbr = new DatabaseReader();
        dbr.getInvoiceByNumber(1);
        */
        String stmt = "Herr Frank " + null;
        System.out.println(stmt);

        DAOProperties properties = new DAOProperties("steady.jdbc");
        String url = properties.getProperty("url", true);
        String driver = properties.getProperty("driver", true);
        String username = properties.getProperty("username", true);
        String password = properties.getProperty("password", true);

        System.out.println("Property url: " + url);
        System.out.println("Property driver: " + driver);
        System.out.println("Property username: " + username);
        System.out.println("Property password: " + password);

        Country country = new Country();
        country.setId(12345L);
        country.setCode("DE");
        country.setName("Germany");
        country.setCreuser("rhahn");
        country.setCredat(new SimpleDateFormat("dd.MM.yyyy").parse("02.01.2019"));
        country.setLmuser("rhahn");
        country.setLastmodified(new SimpleDateFormat("dd.MM.yyyy").parse("03.01.2019"));

        System.out.println("First Country: " + country.toString());

        Currency currency = new Currency();
        currency.setId(23456L);
        currency.setCode("EUR");
        currency.setName("European Euro");
        currency.setCreuser("rhahn");
        currency.setCredat(new SimpleDateFormat("dd.MM.yyyy").parse("02.01.2019"));
        currency.setLmuser("rhahn");
        currency.setLastmodified(new SimpleDateFormat("dd.MM.yyyy").parse("03.01.2019"));

        System.out.println("First Currency: " + currency.toString());

        Client client = new Client();
        client.setName("Software Services Hahn GbR");
        client.setCountry(country);
        client.setLanguage("german");
        client.setCurrency(currency);
        client.setTimezone("CET Central European Time (UTC + 01:00)");
        client.setCreuser("rhahn");
        client.setCredat(new SimpleDateFormat("dd.MM.yyyy").parse("02.01.2019"));
        client.setLmuser("rhahn");
        client.setLastmodified(new SimpleDateFormat("dd.MM.yyyy").parse("03.01.2019"));

        System.out.println("First Client: " + client);
    }
}
