package ru.taxofon.dao.impl;

import ru.taxofon.dao.DamageDescriptionDao;
import ru.taxofon.entity.DamageDescription;

public class DamageDescriptionDaoImpl extends BasicDaoImpl<DamageDescription> implements DamageDescriptionDao {
    public DamageDescriptionDaoImpl(Class<DamageDescription> entityClass) {
        super(entityClass);
    }
}
