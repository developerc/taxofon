package ru.taxofon.service;

import ru.taxofon.entity.DamageList;

import java.util.List;

public interface DamageListService {
    /**
     * method for add damageList
     *
     * @param damageList = new damageList for creation in DB
     * @return created DamageList
     */
    DamageList addDamageList(DamageList damageList);

    /**
     * method for receiving all damageLists
     *
     * @return all damageLists
     */
    List<DamageList> getAllDamageLists();

    /**
     * method for receive specify damageList by id
     *
     * @param id = uniq damageList id
     * @return specify damageList by id
     */
    DamageList getDamageListById(long id);

    /**
     * method for damageList delete
     *
     * @param id = damageList's id for delete
     * @return removed damageList
     */
    DamageList deleteDamageList(long id);

    /**
     * method for update damageList
     *
     * @param damageList = update existing damageList in DB
     * @return updated damageList
     */
    DamageList updDamageList(DamageList damageList);
}
