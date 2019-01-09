package swshahn.com.steady.database.dao;

import java.sql.*;

public final class DAOUtil {
    private DAOUtil() {

    }

    /**
     * Returns a PreparedStatement of the given connection, set with the given SQL query and the given
     * parameter values.
     *
     * @param connection          The connection to create the PreparedStatement from.
     * @param sql                 The SQL query to construct the PreparedStatement with.
     * @param returnGeneratedKeys Set whether to return generated Keys or not.
     * @param values              The parameter values to be set in the created PreparedStatement.
     * @return The PreparedStatement of the given connection.
     * @throws SQLException Is something fails during creating the PreparedStatement.
     */
    public static PreparedStatement prepareStatement(Connection connection, String sql, boolean returnGeneratedKeys,
                                                     Object... values) throws SQLException {
        PreparedStatement statement = connection.prepareStatement(sql,
                returnGeneratedKeys ? Statement.RETURN_GENERATED_KEYS : Statement.NO_GENERATED_KEYS);
        setValues(statement, values);
        return statement;
    }

    /**
     * Set the given parameter values in the given PreparedStatement.
     *
     * @param statement The PreparedStatement to set the given parameter values in.
     * @param values    The parameter values to be set in the created PreparedStatement.
     * @throws SQLException If somethings fails during setting the PreparedStatement values.
     */
    public static void setValues(PreparedStatement statement, Object... values) throws SQLException {
        for (int i = 0; i < values.length; i++) {
            statement.setObject(i + 1, values[i]);
        }
    }

    /**
     * Convert the given java date into a sql date.
     *
     * @param date Java date value to be converted.
     * @return The SQL Date representation of the given Java Date.
     */
    public static Date toSqlDate(java.util.Date date) {

        return (date != null) ? new Date(date.getTime()) : null;
    }
}
