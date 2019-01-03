package swshahn.com.steady.database.dao.interfaces;

import swshahn.com.steady.database.dao.DAOException;
import swshahn.com.steady.model.Currency;

import java.util.List;

/**
 * This interface represents a contract for a DAO for the {@link swshahn.com.steady.model.Currency} model.
 */

public interface CurrencyDAO {

    /**
     * Returns the currency matching the given id from the database, otherwise returns null.
     * @param id The id of the currency to be returned.
     * @return The currency matching the given id, otherwise null.
     * @throws DAOException If something fails at database level.
     */
    public Currency find(Long id) throws DAOException;

    /**
     * Returns the currency from the database matching the given currency code, otherwise returns null.
     * @param code The currency code of the currency to be returned.
     * @return The currency matching the given code, otherwise null.
     * @throws DAOException If something fails at database level.
     */
    public Currency findByCode(String code) throws DAOException;

    /**
     * Returns the currency from the database matching the given currency name, otherwise returns null.
     * @param name The name of the currency to be returned.
     * @return The currency matching the given currency name, otherwise null.
     * @throws DAOException If something fails at database level.
     */
    public Currency findByName(String name) throws DAOException;

    /**
     * Returns a list of all currencies in the database. The list is never null. It is empty when
     * the database does not contain any currency.
     * @return A list of currencies contained in the database.
     * @throws DAOException If something fails at database level.
     */
    public List<Currency> list() throws DAOException;

    /**
     * Creates the given currency in the database. The id must be null, otherwise
     * it will throw an IllegalArgumentException. After creating, the DAO will
     * set the obtained id in the given currency.
     * @param currency The currency to be created in the database.
     * @throws IllegalArgumentException If the id is not null.
     * @throws DAOException If something fails at database level.
     */
    public void create(Currency currency) throws IllegalArgumentException, DAOException;

    /**
     * Updates the given currency in the database. The id must not be null, otherwise
     * it will throw an IllegalArgumentException.
     * @param currency The currency to be updated in the database.
     * @throws IllegalArgumentException If the id is null.
     * @throws DAOException If something fails at database level.
     */
    public void update(Currency currency) throws IllegalArgumentException, DAOException;

    /**
     * Deletes the given currency in the database. The id must not be null, otherwise
     * it will throw an IllegalArgumentException.
     * @param currency The currency to be deleted in the database.
     * @throws IllegalArgumentException If the id is null.
     * @throws DAOException If something fails at database level.
     */
    public void delete(Currency currency) throws IllegalArgumentException, DAOException;
}
