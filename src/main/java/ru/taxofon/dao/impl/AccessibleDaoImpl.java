package ru.taxofon.dao.impl;

import ru.taxofon.dao.AccessibleDao;
import ru.taxofon.entity.Accessible;

public class AccessibleDaoImpl extends BasicDaoImpl<Accessible> implements AccessibleDao {
    public AccessibleDaoImpl(Class<Accessible> entityClass) {
        super(entityClass);
    }
}
