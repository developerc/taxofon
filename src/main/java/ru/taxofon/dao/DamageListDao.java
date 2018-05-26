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
}
