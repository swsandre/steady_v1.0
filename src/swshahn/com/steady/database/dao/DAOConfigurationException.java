package swshahn.com.steady.database.dao;

/**
 * Author: Rene Hahn
 * Description: Class represents an exception in the DAO configuration which cannot be resolved at runtime,
 * such as a missing resource in the classpath, a missing property in the properties file, ecetera.
 *
 * Change Log:
 * 03.01.2019, Rene Hahn - Initial Creation
 */
public class DAOConfigurationException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public DAOConfigurationException(String message) {
        super(message);
    }

    public DAOConfigurationException(Throwable cause) {
        super(cause);
    }

    public DAOConfigurationException(String message, Throwable cause){
        super(message, cause);
    }
}
