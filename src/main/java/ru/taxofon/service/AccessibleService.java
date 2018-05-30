package ru.taxofon.service;

import ru.taxofon.entity.Accessible;

import java.util.List;

public interface AccessibleService {
    /**
     * method for add accessible
     * @param accessible = new accessible for adding into DB
     * @return created accessible
     * **/
    Accessible addAccessible(Accessible accessible);

    /**
     * method for receiving all Accessibles
     *
     * @return all damageDescriptions
     */
    List<Accessible> getAllAccessibles();

    /**
     * method for receive specify damageList by id
     *
     * @param id = uniq accessible id
     * @return specify Accessible by id
     */
    Accessible getAccessibleById(long id);

    /**
     * method for damageList delete
     *
     * @param id = Accessible's id for delete
     * @return removed Accessible
     */
    Accessible deleteAccessible(long id);

    /**
     * method for update damageList
     *
     * @param accessible = update existing accessible in DB
     * @return updated accessible
     */
    Accessible updAccessible(Accessible accessible);
}
