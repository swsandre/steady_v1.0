package swshahn.com.steady.model;

import java.io.Serializable;

/**
 * Author: Rene Hahn
 * Description: Class represents the currency model. This model class can be used throughout all
 * layers, the data layer, the controller layer and the view layer.
 *
 * Change Log:
 * 03.01.2019, Rene Hahn - Initial Creation
 * 03.01.2019, Rene Hahn - Property currency changed to name
 */

public class Currency extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /* Properties */
    private String code;
    private String name;

    /* Getters and Setters */
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String currency) {
        this.name = name;
    }

    /* Object overrides */
    @Override
    public boolean equals(Object other) {
        return (other instanceof Currency) && (super.getId() != null)
                ? super.getId().equals(((Currency)other).getId())
                : (other == this);
    }

    @Override
    public int hashCode() {
        return (super.getId() != null) ? (this.getClass().hashCode() + super.getId().hashCode()) : super.hashCode();
    }

    @Override
    public String toString() {
        return String.format("Currency[id=%d,code=%s,name=%s,creuser=%s,credat=%s,lmuser=%s,lastmodified=%s]",
                getId(),
                getCode(),
                getName(),
                getCreuser(),
                getCredat(),
                getLmuser(),
                getLastmodified());
    }
}
