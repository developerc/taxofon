package ru.taxofon.dao.impl;

import ru.taxofon.dao.DamageListDao;
import ru.taxofon.entity.DamageList;

public class DamageListDaoImpl extends BasicDaoImpl<DamageList> implements DamageListDao {
    public DamageListDaoImpl(Class<DamageList> entityClass) {
        super(entityClass);
    }
}
