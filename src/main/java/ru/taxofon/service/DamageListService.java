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

    /**
     * method for finding damage by telephone number
     *@param tlfnum = telephone number of taxofon
     *@param closed = true if taxofon has been repaired
     *@return list taxofons with success parameters
     * **/
    List<DamageList> getDamageByTlfNum(String tlfnum, boolean closed);

    /**
     * method for finding damage by description
     *@param description =  description of damage
     *@param closed = true if taxofon has been repaired
     *@return list taxofons with success parameters
     **/
    List<DamageList> getDamageByDescription(String description, boolean closed);

    /**
     * method for finding all damage closed or not
     *@param closed = true if taxofon has been repaired
     *@return list taxofons with success parameter
     **/
    List<DamageList> getDamageAll(boolean closed);
}
