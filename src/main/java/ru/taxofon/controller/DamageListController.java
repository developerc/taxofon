package ru.taxofon.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import ru.taxofon.entity.DamageList;
import ru.taxofon.service.DamageListService;

import java.util.List;

@Controller
@RequestMapping("/damage")
public class DamageListController {
    @Autowired
    private DamageListService damageListService;

    @RequestMapping(value = "/add", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
    @ResponseBody
    public DamageList addEmployee(@RequestBody DamageList damageList){
        return damageListService.addDamageList(damageList);
    }

    @RequestMapping(value = "/all", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public List<DamageList> getDamageLists(){
        return damageListService.getAllDamageLists();
    }

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public DamageList getDamageListById(@PathVariable(value = "id") String id){
        // exception
        return damageListService.getDamageListById(Long.parseLong(id));
    }


    @RequestMapping(value = "/get/tlfnum/{tlfnum}/closed/{closed}", method = RequestMethod.GET, produces = "application/json;charset=utf-8")
    @ResponseBody
    public List<DamageList> getDamageByTlfNum(@PathVariable(value = "tlfnum") String tlfnum, @PathVariable(value = "closed") boolean closed){
        // exception
        return damageListService.getDamageByTlfNum(tlfnum, closed);
    }

    // localhost:8080/cat/delete?id=5&name=Jack
    @RequestMapping(value = "/delete", method = RequestMethod.DELETE, produces = "application/json;charset=utf-8")
    @ResponseBody
    public DamageList deleteDamageList(@RequestParam(value = "id") String id) {
        return damageListService.deleteDamageList(Long.parseLong(id));
    }

    @RequestMapping(value = "/upd", method = RequestMethod.PUT, produces = "application/json;charset=utf-8")
    @ResponseBody
    public DamageList updDamageList(@RequestBody DamageList damageList){
        return damageListService.updDamageList(damageList);
    }
}
