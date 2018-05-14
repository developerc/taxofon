package ru.taxofon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import ru.taxofon.entity.DamageDescription;
import ru.taxofon.service.DamageDescriptionService;

import java.util.List;

@Controller
@RequestMapping("/dmgdescription")
public class DamageDescriptionController {
    @Autowired
    private DamageDescriptionService damageDescriptionService;

    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
    @ResponseBody
    public DamageDescription addEmployee(@RequestBody DamageDescription damageDescription){
        return damageDescriptionService.addDamageDescription(damageDescription);
    }

    @RequestMapping(value = "/all", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public List<DamageDescription> getDamageDescriptions(){
        return damageDescriptionService.getAllDamageDescriptions();
    }

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public DamageDescription getDamageDescriptionById(@PathVariable(value = "id") String id){
        // exception
        return damageDescriptionService.getDamageDescriptionById(Long.parseLong(id));
    }

    // localhost:8080/cat/delete?id=5&name=Jack
    @RequestMapping(value = "/delete", method = RequestMethod.DELETE, produces = "application/json;charset=utf-8")
    @ResponseBody
    public DamageDescription deleteDamageDescription(@RequestParam(value = "id") String id) {
        return damageDescriptionService.deleteDamageDescription(Long.parseLong(id));
    }

    @RequestMapping(value = "/upd", method = RequestMethod.PUT, produces = "application/json;charset=utf-8")
    @ResponseBody
    public DamageDescription updDamageDescription(@RequestBody DamageDescription damageDescription){
        return damageDescriptionService.updDamageDescription(damageDescription);
    }
}
