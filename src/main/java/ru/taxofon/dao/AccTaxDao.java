package ru.taxofon.dao;

import ru.taxofon.entity.AccTax;

import java.util.List;

public interface AccTaxDao extends BasicDao<AccTax> {
    /**
     * method for finding damage by description
     *@param accDamage = description of damage
     *@return list damages with success parameters
     * **/
    List<AccTax> getAccTaxDamageByDescription(String accDamage);
}
