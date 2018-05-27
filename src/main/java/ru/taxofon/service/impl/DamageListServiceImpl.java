package ru.taxofon.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.taxofon.dao.DamageListDao;
import ru.taxofon.entity.DamageList;
import ru.taxofon.service.DamageListService;

import java.util.List;

@Service("damageListService")
public class DamageListServiceImpl implements DamageListService {
    @Autowired
    private DamageListDao damageListDao;

    @Override
    public DamageList addDamageList(DamageList damageList) {
        return damageListDao.create(damageList);
    }

    @Override
    public List<DamageList> getAllDamageLists() {
        return damageListDao.getList();
    }

    @Override
    public DamageList getDamageListById(long id) {
        return damageListDao.getById(id);
    }

    @Override
    public DamageList deleteDamageList(long id) {
        return damageListDao.delete(damageListDao.getById(id));
    }

    @Override
    public DamageList updDamageList(DamageList damageList) {
        return damageListDao.update(damageList);
    }

    @Override
    public List<DamageList> getDamageByTlfNum(String tlfnum, boolean closed) {
        return damageListDao.getDamageByTlfNum(tlfnum, closed);
    }

    @Override
    public List<DamageList> getDamageByDescription(String description, boolean closed) {
        return damageListDao.getDamageByDescription(description, closed);
    }

    @Override
    public List<DamageList> getDamageAll(boolean closed) {
        return damageListDao.getDamageAll(closed);
    }
}
