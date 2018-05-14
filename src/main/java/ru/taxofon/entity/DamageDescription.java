package ru.taxofon.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class DamageDescription {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    private String itemDamage;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getItemDamage() {
        return itemDamage;
    }

    public void setItemDamage(String itemDamage) {
        this.itemDamage = itemDamage;
    }
}
