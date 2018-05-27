package ru.taxofon.dao;

import ru.taxofon.entity.DamageList;

import java.util.List;

public interface DamageListDao extends BasicDao<DamageList> {

    /**
     * method for finding damage by telephone number
     *@param tlfNum = telephone number of taxofon
     *@param closed = true if taxofon has been repaired
     *@return list taxofons with success parameters
     * **/
    List<DamageList> getDamageByTlfNum(String tlfNum, boolean closed);

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
