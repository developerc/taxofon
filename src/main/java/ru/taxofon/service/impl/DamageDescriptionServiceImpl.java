package ru.taxofon.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.taxofon.dao.DamageDescriptionDao;
import ru.taxofon.entity.DamageDescription;
import ru.taxofon.service.DamageDescriptionService;

import java.util.List;

@Service("damageDescriptionService")
public class DamageDescriptionServiceImpl implements DamageDescriptionService {
    @Autowired
    private DamageDescriptionDao damageDescriptionDao;

    @Override
    public DamageDescription addDamageDescription(DamageDescription damageDescription) {
        return damageDescriptionDao.create(damageDescription);
    }

    @Override
    public List<DamageDescription> getAllDamageDescriptions() {
        return damageDescriptionDao.getList();
    }

    @Override
    public DamageDescription getDamageDescriptionById(long id) {
        return damageDescriptionDao.getById(id);
    }

    @Override
    public DamageDescription deleteDamageDescription(long id) {
        return damageDescriptionDao.delete(damageDescriptionDao.getById(id));
    }

    @Override
    public DamageDescription updDamageDescription(DamageDescription damageDescription) {
        return damageDescriptionDao.update(damageDescription);
    }
}
