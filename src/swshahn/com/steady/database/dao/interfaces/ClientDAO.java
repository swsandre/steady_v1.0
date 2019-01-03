package swshahn.com.steady.database.dao.interfaces;

import swshahn.com.steady.database.dao.DAOException;
import swshahn.com.steady.model.Client;

import java.util.List;

/**
 * This interface represents a contract for a DAO for the {@link swshahn.com.steady.model.Currency} model.
 *
 * Change Log:
 * 03.01.2019, Rene Hahn - Initial Creation
 */

public interface ClientDAO {

    /**
     * Returns the client from the database matching the given id, otherwise it returns null.
     * @param id The id of the client to be returned.
     * @return The client matching the given id, otherwise null.
     * @throws DAOException If something fails at database level.
     */
    public Client find(Long id) throws DAOException;

    /**
     * Returns a list of clients from the database matching the given name, otherwise it
     * returns an empty list.
     * @param name The name of the clients to be returned.
     * @return A list of clients matching the given client name, otherwise an empty list.
     * @throws DAOException If something fails at database level.
     */
    public List<Client> findByName(String name) throws DAOException;

    /**
     * Returns a list of all clients in the database. The list is never null. It is empty when
     * the database does not contain any clients.
     * @return A list of all clients. The list is empty if no client exists in the database.
     * @throws DAOException If something fails at database level.
     */
    public List<Client> list() throws DAOException;

    /**
     * Creates the given client in the database. The id must be null, otherwise it
     * will throw an IllegalArgumentException. After creating, the DAO will set the
     * obtained id in the given client.
     * @param client The client to be created in the database.
     * @throws IllegalArgumentException If the client id is not null.
     * @throws DAOException If something fails at database level.
     */
    public void create(Client client) throws IllegalArgumentException, DAOException;

    /**
     * Updates the given client in the database. The id must not be null, otherwise it
     * will throw an IllegalArgumentException.
     * @param client The client to be updated in the database.
     * @throws IllegalArgumentException If the client id is null.
     * @throws DAOException If something fails at database level.
     */
    public void update(Client client) throws IllegalArgumentException, DAOException;

    /**
     * Deletes the given client in the database. The id must not be null, otherwise it
     * will throw an IllegalArgumentException.
     * @param client The client to be deleted in the databse.
     * @throws IllegalArgumentException If the client id is null.
     * @throws DAOException If something fails at database level.
     */
    public void delete(Client client) throws IllegalArgumentException, DAOException;
}
