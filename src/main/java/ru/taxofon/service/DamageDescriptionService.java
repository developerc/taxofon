package ru.taxofon.service;

import ru.taxofon.entity.DamageDescription;

import java.util.List;

public interface DamageDescriptionService {
    /**
     * method for add damageDescription
     *
     * @param damageDescription = new damageDescription for creation in DB
     * @return created damageDescription
     */
    DamageDescription addDamageDescription(DamageDescription damageDescription);

    /**
     * method for receiving all DamageDescriptions
     *
     * @return all damageDescriptions
     */
    List<DamageDescription> getAllDamageDescriptions();

    /**
     * method for receive specify damageList by id
     *
     * @param id = uniq damageDescription id
     * @return specify damageDescription by id
     */
    DamageDescription getDamageDescriptionById(long id);

    /**
     * method for damageList delete
     *
     * @param id = damageDescription's id for delete
     * @return removed damageDescription
     */
    DamageDescription deleteDamageDescription(long id);

    /**
     * method for update damageList
     *
     * @param damageDescription = update existing damageDescription in DB
     * @return updated damageDescription
     */
    DamageDescription updDamageDescription(DamageDescription damageDescription);
}
