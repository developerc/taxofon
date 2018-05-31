package ru.taxofon.service;

import ru.taxofon.entity.AccTax;

import java.util.List;

public interface AccTaxService {
    /**
     * method for add accessible
     * @param accTax = new accessible for adding into DB
     * @return created accessible
     * **/
    AccTax addAccessible(AccTax accTax);

    /**
     * method for receiving all Accessibles
     *
     * @return all damageDescriptions
     */
    List<AccTax> getAllAccessibles();

    /**
     * method for receive specify damageList by id
     *
     * @param id = uniq accessible id
     * @return specify Accessible by id
     */
    AccTax getAccessibleById(long id);

    /**
     * method for damageList delete
     *
     * @param id = Accessible's id for delete
     * @return removed Accessible
     */
    AccTax deleteAccessible(long id);

    /**
     * method for update damageList
     *
     * @param accTax = update existing accessible in DB
     * @return updated accessible
     */
    AccTax updAccessible(AccTax accTax);

    /**
     * method for update damageList
     *
     * @param description = description of damage
     * @return searched entity
     */
    List<AccTax> getAccTaxByDescription(String description);
}
