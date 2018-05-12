package ru.taxofon.dao.impl;

import ru.taxofon.dao.TaxofonListDao;
import ru.taxofon.entity.TaxofonList;

public class TaxofonListDaoImpl  extends BasicDaoImpl<TaxofonList> implements TaxofonListDao {
    public TaxofonListDaoImpl(Class<TaxofonList> entityClass) {
        super(entityClass);
    }
}