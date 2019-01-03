package swshahn.com.steady.database.dao.interfaces;

import swshahn.com.steady.database.dao.DAOException;
import swshahn.com.steady.model.Country;

import java.util.List;

/**
 * This interface represents a contract for a DAO for the {@link swshahn.com.steady.model.Country} model.
 */

public interface CountryDAO {

    /**
     * Returns the country from the database matching the given id, otherwise returns null.
     * @param id The id of the country to be returned.
     * @return The country from the database matching the given id, otherwise null.
     * @throws DAOException If something fails at database level.
     */
    public Country find(Long id) throws DAOException;

    /**
     * Returns the country from the database matching the given country code, otherwise returns null.
     * @param code The code of the country to be returned.
     * @return The country from the database matching the given country code, otherwise null.
     * @throws DAOException If something fails at database level.
     */
    public Country findByCode(String code) throws DAOException;

    /**
     * Returns the country from the database matching the given country name, otherwise returns null.
     * @param name The name of the country to be returned.
     * @return The country from the database matching the given name, otherwise null.
     * @throws DAOException If something fails at database level.
     */
    public Country findByName(String name) throws DAOException;

    /**
     * Returns a list of all Countries from the database. The list is never null. It is
     * empty when the database does not contain any country.
     * @return A list of all countries contained in the database.
     * @throws DAOException If something fails at database level.
     */
    public List<Country> list() throws DAOException;

    /**
     * Creates the given country in the database. The country id must be null, otherwise
     * it will throw an IllegalArgumentException. After creating, the DAO will set the
     * obtained id in the given country.
     * @param country The country to be created in the database.
     * @throws IllegalArgumentException If the country id is not null.
     * @throws DAOException If something fails at database level.
     */
    public void create(Country country) throws IllegalArgumentException, DAOException;

    /**
     * Updates the given country in the database. The country id must not be null, otherwise
     * it will throw an IllegalArgumentException.
     * @param country The country to be updated in the database.
     * @throws IllegalArgumentException If the country id is null.
     * @throws DAOException If something fails at database level.
     */
    public void update(Country country) throws IllegalArgumentException, DAOException;

    /**
     * Deletes the given country in the database. The country id must not be null, otherwise
     * it will throw an IllegalArgumentException. After deleting, the DAO will set the id
     * of the given country to null.
     * @param country The country to be deleted in the database.
     * @throws IllegalArgumentException If the country id is null.
     * @throws DAOException If something fails at database level.
     */
    public void delete(Country country) throws IllegalArgumentException, DAOException;
}
