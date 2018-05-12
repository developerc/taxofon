package ru.taxofon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import ru.taxofon.entity.TaxofonList;
import ru.taxofon.service.TaxofonListService;

import java.util.List;

@Controller
@RequestMapping("/taxofon")
public class TaxofonListController {
    @Autowired
    private TaxofonListService taxofonListService;

    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
    @ResponseBody
    public TaxofonList addEmployee(@RequestBody TaxofonList taxofonList){
        return taxofonListService.addTaxofonList(taxofonList);
    }

    @RequestMapping(value = "/all", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public List<TaxofonList> getAllTaxofonLists(){
        return taxofonListService.getAllTaxofonLists();
    }

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public TaxofonList getTaxofonListById(@PathVariable(value = "id") String id){
        // exception
        return taxofonListService.getTaxofonListById(Long.parseLong(id));
    }

    // localhost:8080/cat/delete?id=5&name=Jack
    @RequestMapping(value = "/delete", method = RequestMethod.DELETE, produces = "application/json;charset=utf-8")
    @ResponseBody
    public TaxofonList deleteTaxofonList(@RequestParam(value = "id") String id) {
        return taxofonListService.deleteTaxofonList(Long.parseLong(id));
    }

    @RequestMapping(value = "/upd", method = RequestMethod.PUT, produces = "application/json;charset=utf-8")
    @ResponseBody
    public TaxofonList updTaxofonList(@RequestBody TaxofonList taxofonList){
        return taxofonListService.updTaxofonList(taxofonList);
    }
}
