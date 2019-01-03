package swshahn.com.steady.model;

import java.util.Date;
/**
 * Author: Rene Hahn
 * Description: Class represents the base entity of the steady model and provides common attributes and methods.
 * All other Entity classes in package model must extend this abstract class.
 *
 * Change Log:
 * 02.01.2019, Rene Hahn - Initial Creation
 */
public abstract class BaseEntity {

    /* Properties */
    private Long id;
    private String creuser;
    private Date credat;
    private String lmuser;
    private Date lastmodified;


    /* Getters and Setters */
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCreuser() {
        return creuser;
    }

    public void setCreuser(String creuser) {
        this.creuser = creuser;
    }

    public Date getCredat() {
        return credat;
    }

    public void setCredat(Date credat) {
        this.credat = credat;
    }

    public String getLmuser() {
        return lmuser;
    }

    public void setLmuser(String lmuser) {
        this.lmuser = lmuser;
    }

    public Date getLastmodified() {
        return lastmodified;
    }

    public void setLastmodified(Date lastmodified) {
        this.lastmodified = lastmodified;
    }
}

