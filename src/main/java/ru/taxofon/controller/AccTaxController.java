package ru.taxofon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import ru.taxofon.entity.AccTax;
import ru.taxofon.service.AccTaxService;

import java.util.List;

@Controller
@RequestMapping("/acctax")
public class AccTaxController {
    @Autowired
    private AccTaxService accTaxService;

    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
    @ResponseBody
    public AccTax addAccTax(@RequestBody AccTax accTax){
        return accTaxService.addAccessible(accTax);
    }

    @RequestMapping(value = "/all", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public List<AccTax> getAccTax(){
        return accTaxService.getAllAccessibles();
    }

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public AccTax getAccessibleById(@PathVariable(value = "id") String id){
        // exception
        return accTaxService.getAccessibleById(Long.parseLong(id));
    }

    @RequestMapping(value = "/get/description/{description}", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public List<AccTax> getAccTaxByDescription(@PathVariable(value = "description") String description){
        // exception
        return accTaxService.getAccTaxByDescription(description);
    }

    // localhost:8080/cat/delete?id=5&name=Jack
    @RequestMapping(value = "/delete", method = RequestMethod.DELETE, produces = "application/json;charset=utf-8")
    @ResponseBody
    public AccTax deleteAccTax(@RequestParam(value = "id") String id) {
        return accTaxService.deleteAccessible(Long.parseLong(id));
    }

    @RequestMapping(value = "/upd", method = RequestMethod.PUT, produces = "application/json;charset=utf-8")
    @ResponseBody
    public AccTax updAccTax(@RequestBody AccTax accTax){
        return accTaxService.updAccessible(accTax);
    }
}
