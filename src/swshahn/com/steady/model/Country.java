package swshahn.com.steady.model;

import java.io.Serializable;

/**
 * Author: Rene Hahn
 * Description: Class represents the country model. This model class can be used throughout all
 * layers, the data layer, the controller layer and the view layer.
 *
 * Change Log:
 * 02.01.2019, Rene Hahn - Initial Creation
 */

public class Country extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /* Properties */
    private String code;
    private String country;

    /* Getters and Setters */
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    /* Object overrides */
    @Override
    public boolean equals(Object other) {
        return (other instanceof Country) && (super.getId() != null)
                ? super.getId().equals(((Country)other).getId())
                : (other == this);
    }

    @Override
    public int hashCode() {
        return (super.getId() != null) ? (this.getClass().hashCode() + super.getId().hashCode()) : super.hashCode();
    }

    @Override
    public String toString() {
        return String.format("Country[id=%d,code=%s,country=%s,creuser=%s,credat=%t,lmuser=%s,lastmodified=%t]",
                getId(),
                getCode(),
                getCountry(),
                getCreuser(),
                getCredat(),
                getLmuser(),
                getLastmodified());
    }
}
