package ru.taxofon.dao.impl;

import ru.taxofon.dao.AccTaxDao;
import ru.taxofon.entity.AccTax;

import javax.persistence.Query;
import java.util.List;

public class AccTaxDaoImpl extends BasicDaoImpl<AccTax> implements AccTaxDao {
    public AccTaxDaoImpl(Class<AccTax> entityClass) {
        super(entityClass);
    }

    @Override
    public List<AccTax> getAccTaxDamageByDescription(String accDamage) {
        Query query = getSessionFactory().createQuery("SELECT a FROM AccTax as a WHERE a.accDamage = :accDamage");
        query.setParameter("accDamage", accDamage);
        return query.getResultList();
    }
}
