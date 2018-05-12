package ru.taxofon.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class DamageList {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    private String tlfnum;

    private String description;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getTlfnum() {
        return tlfnum;
    }

    public void setTlfnum(String tlfnum) {
        this.tlfnum = tlfnum;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
