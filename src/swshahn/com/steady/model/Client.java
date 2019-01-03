package swshahn.com.steady.model;

import java.io.Serializable;

/**
 * Author: Rene Hahn
 * Description: Class represents the Client model. This model class can be used throughout all
 * layers, the data layer, the controller layer and the view layer.
 *
 * Change Log:
 * 03.01.2019, Rene Hahn - Initial Creation
 */
public class Client extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /* Properties */
    private String name;
    private Country country;
    private String language;
    private Currency currency;
    private String timezone;

    /* Getters and Setters */
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Country getCountry() {
        return country;
    }

    public void setCountry(Country country) {
        this.country = country;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public Currency getCurrency() {
        return currency;
    }

    public void setCurrency(Currency currency) {
        this.currency = currency;
    }

    public String getTimezone() {
        return timezone;
    }

    public void setTimezone(String timezone) {
        this.timezone = timezone;
    }

    /* Object overrides */
    @Override
    public boolean equals(Object other) {
        return (other instanceof Client) && (super.getId() != null)
                ? super.getId().equals(((Client)other).getId())
                : (other == this);
    }

    @Override
    public int hashCode() {
        return (super.getId() != null) ? (this.getClass().hashCode() + super.getId().hashCode()) : super.hashCode();
    }

    @Override
    public String toString() {
        return String.format("Client[id=%d,name=%s,country=%s,language=%s,currency=%s,timezone=%s,creuser=%s,credat=%s,lmuser=%s,lastmodified=%s]",
                getId(),
                getName(),
                getCountry().toString(),
                getLanguage(),
                getCurrency().toString(),
                getTimezone(),
                getCreuser(),
                getCredat(),
                getLmuser(),
                getLastmodified());
    }
}
