package ru.taxofon.service;

import ru.taxofon.entity.TaxofonList;

import java.util.List;

public interface TaxofonListService {

    /**
     * method for add taxofonList
     *
     * @param taxofonList = new taxofonList for creation in DB
     * @return created taxofonList
     */
    TaxofonList addTaxofonList(TaxofonList taxofonList);

    /**
     * method for receiving all taxofonLists
     *
     * @return all taxofonLists
     */
    List<TaxofonList> getAllTaxofonLists();

    /**
     * method for receive specify taxofonList by id
     *
     * @param id = uniq taxofonList id
     * @return specify taxofonList by id
     */
    TaxofonList getTaxofonListById(long id);

    /**
     * method for taxofonList delete
     *
     * @param id = taxofonList's id for delete
     * @return removed taxofonList
     */
    TaxofonList deleteTaxofonList(long id);

    /**
     * method for update taxofonList
     *
     * @param taxofonList = update existing taxofonList in DB
     * @return updated taxofonList
     */
    TaxofonList updTaxofonList(TaxofonList taxofonList);
}
