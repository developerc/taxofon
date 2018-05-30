package ru.taxofon.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.taxofon.dao.AccessibleDao;
import ru.taxofon.entity.Accessible;
import ru.taxofon.service.AccessibleService;

import java.util.List;

@Service("accessibleService")
public class AccessibleServiceImpl implements AccessibleService {
    @Autowired
    private AccessibleDao accessibleDao;

    @Override
    public Accessible addAccessible(Accessible accessible) {
        return null;
    }

    @Override
    public List<Accessible> getAllAccessibles() {
        return null;
    }

    @Override
    public Accessible getAccessibleById(long id) {
        return null;
    }

    @Override
    public Accessible deleteAccessible(long id) {
        return null;
    }

    @Override
    public Accessible updAccessible(Accessible accessible) {
        return null;
    }
}
