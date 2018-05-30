package ru.taxofon.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Accessible {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    private String accDamage;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getAccDamage() {
        return accDamage;
    }

    public void setAccDamage(String accDamage) {
        this.accDamage = accDamage;
    }
}
