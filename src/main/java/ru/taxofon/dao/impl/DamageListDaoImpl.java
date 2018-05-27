package ru.taxofon.dao.impl;

import ru.taxofon.dao.DamageListDao;
import ru.taxofon.entity.DamageList;

import javax.persistence.Query;
import java.util.List;

public class DamageListDaoImpl extends BasicDaoImpl<DamageList> implements DamageListDao {
    public DamageListDaoImpl(Class<DamageList> entityClass) {
        super(entityClass);
    }

    @Override
    public List<DamageList> getDamageByTlfNum(String tlfNum, boolean closed) {
        Query query;
        if (closed){
            query = getSessionFactory().createQuery("SELECT d FROM DamageList as d WHERE d.tlfnum = :tlfnum");
        } else {
            query = getSessionFactory().createQuery("SELECT d FROM DamageList as d WHERE d.tlfnum = :tlfnum AND d.dateTimeEnd = null");
        }
        query.setParameter("tlfnum", tlfNum);
        return query.getResultList();
    }

    @Override
    public List<DamageList> getDamageByDescription(String description, boolean closed) {
        Query query;
        if (closed){
            query = getSessionFactory().createQuery("SELECT d FROM DamageList as d WHERE d.description = :description");
        } else {
            query = getSessionFactory().createQuery("SELECT d FROM DamageList as d WHERE d.description = :description AND d.dateTimeEnd = null");
        }
        query.setParameter("description", description);
        return query.getResultList();
    }

    @Override
    public List<DamageList> getDamageAll(boolean closed) {
        Query query;
        if (closed){
            query = getSessionFactory().createQuery("SELECT d FROM DamageList as d");
        } else {
            query = getSessionFactory().createQuery("SELECT d FROM DamageList as d WHERE  d.dateTimeEnd = null");
        }
        return query.getResultList();
    }
}
