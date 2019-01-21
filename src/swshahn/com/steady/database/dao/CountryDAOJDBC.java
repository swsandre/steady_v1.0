package swshahn.com.steady.database.dao;

import swshahn.com.steady.database.dao.interfaces.CountryDAO;
import swshahn.com.steady.model.Country;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static swshahn.com.steady.database.dao.DAOUtil.prepareStatement;

/**
 * Author: Rene Hahn
 * Description: This class represents a concrete JDBC implementation of the {@link swshahn.com.steady.database.dao.interfaces.CountryDAO} interface.
 * <p>
 * Change Log:
 * 08.01.2019, Rene Hahn - Initial Creation
 */
public class CountryDAOJDBC implements CountryDAO {
    private static final String COUNTRY_TABLE_NAME = "bmdata.countries";
    private static final String SYSTEM_FIELDS = "creuser, credat, lmuser, lastmodified";

    private static final String SQL_FIND_BY_ID =
            "SELECT id, code, name, " + SYSTEM_FIELDS + " FROM " + COUNTRY_TABLE_NAME + " WHERE id = ?";
    private static final String SQL_FIND_BY_CODE =
            "SELECT id, code, name, " + SYSTEM_FIELDS + " FROM " + COUNTRY_TABLE_NAME + " WHERE code = ?";
    private static final String SQL_FIND_BY_NAME =
            "SELECT id, code, name, " + SYSTEM_FIELDS + " FROM " + COUNTRY_TABLE_NAME + " WHERE name = ?";
    private static final String SQL_LIST_ALL_COUNTRIES =
            "SELECT id, code, name, " + SYSTEM_FIELDS + " FROM " + COUNTRY_TABLE_NAME + " ORDER BY name";


    private DAOFactory daoFactory;

    /**
     * Construct a Country DAO for the given DAOFactory. Package private so it can be constructed
     * inside the DAO Package only.
     *
     * @param daoFactory The DAOFactory to construct this Country DAO for.
     */
    CountryDAOJDBC(DAOFactory daoFactory) {
        this.daoFactory = daoFactory;
    }

    @Override
    public Country find(Long id) throws DAOException {
        return find(SQL_FIND_BY_ID, id);
    }

    @Override
    public Country findByCode(String code) throws DAOException {
        return find(SQL_FIND_BY_CODE, code);
    }

    @Override
    public Country findByName(String name) throws DAOException {
        return find(SQL_FIND_BY_NAME, name);
    }

    /**
     * Returns the Country from the databse matching the given SQL query with the given values.
     *
     * @param sql    The SQL query to be executed in the database.
     * @param values The PreparedStatement values to be set.
     * @return The Country from the database matching the given SQL query with the given values.
     * @throws DAOException If something fails at database level.
     */
    private Country find(String sql, Object... values) throws DAOException {
        Country country = null;

        try (
                Connection connection = daoFactory.getConnection();
                PreparedStatement statement = prepareStatement(connection, sql, false, values);
                ResultSet resultSet = statement.executeQuery();
        ) {
            if (resultSet.next()) {
                country = mapAttributes(resultSet);
            }
        } catch (SQLException e) {
            throw new DAOException(e);
        }

        return country;
    }

    @Override
    public List<Country> list() throws DAOException {
        List<Country> countries = new ArrayList<>();

        try (
                Connection connection = daoFactory.getConnection();
                PreparedStatement statement = connection.prepareStatement(SQL_LIST_ALL_COUNTRIES);
                ResultSet resultSet = statement.executeQuery();
        ) {
            if (resultSet.next()) {
                countries.add(mapAttributes(resultSet));
            }
        } catch (SQLException e) {
            throw new DAOException(e);
        }

        return countries;
    }

    /**
     * Map the current row of a given ResultSet to a Country instance.
     *
     * @param resultSet The ResultSet of which the current row is to be mapped to a Country.
     * @return The mapped Country from the current row of the given ResultSet.
     * @throws SQLException If something fails at database level.
     */
    private static Country mapAttributes(ResultSet resultSet) throws SQLException {
        Country country = new Country();
        country.setId(resultSet.getLong("id"));
        country.setCode(resultSet.getString("code"));
        country.setName(resultSet.getString("name"));
        country.setCreuser(resultSet.getString("creuser"));
        country.setCredat(resultSet.getDate("credat"));
        country.setLmuser(resultSet.getString("lmuser"));
        country.setLastmodified(resultSet.getDate("lastmodified"));
        return country;
    }
}
