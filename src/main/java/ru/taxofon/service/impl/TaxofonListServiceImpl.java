package ru.taxofon.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.taxofon.dao.TaxofonListDao;
import ru.taxofon.entity.TaxofonList;
import ru.taxofon.service.TaxofonListService;

import java.util.List;

@Service("taxofonListService")
public class TaxofonListServiceImpl implements TaxofonListService{
    @Autowired
    private TaxofonListDao taxofonListDao;

    @Override
    public TaxofonList addTaxofonList(TaxofonList taxofonList) {
        return taxofonListDao.create(taxofonList);
    }

    @Override
    public List<TaxofonList> getAllTaxofonLists() {
        return taxofonListDao.getList();
    }

    @Override
    public TaxofonList getTaxofonListById(long id) {
        return taxofonListDao.getById(id);
    }

    @Override
    public TaxofonList deleteTaxofonList(long id) {
        return taxofonListDao.delete(taxofonListDao.getById(id));
    }

    @Override
    public TaxofonList updTaxofonList(TaxofonList taxofonList) {
        return taxofonListDao.update(taxofonList);
    }
}
