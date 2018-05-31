package ru.taxofon.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.taxofon.dao.AccTaxDao;
import ru.taxofon.entity.AccTax;
import ru.taxofon.service.AccTaxService;

import java.util.List;

@Service("accessibleService")
public class AccTaxServiceImpl implements AccTaxService {
    @Autowired
    private AccTaxDao accTaxDao;

    @Override
    public AccTax addAccessible(AccTax accTax) {
        return accTaxDao.create(accTax);
    }

    @Override
    public List<AccTax> getAllAccessibles() {
        return accTaxDao.getList();
    }

    @Override
    public AccTax getAccessibleById(long id) {
        return accTaxDao.getById(id);
    }

    @Override
    public AccTax deleteAccessible(long id) {
        return accTaxDao.delete(accTaxDao.getById(id));
    }

    @Override
    public AccTax updAccessible(AccTax accTax) {
        return accTaxDao.update(accTax);
    }

    @Override
    public List<AccTax> getAccTaxByDescription(String description) {
        return accTaxDao.getAccTaxDamageByDescription(description);
    }
}
