package ru.taxofon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AppController {

    @RequestMapping("/")
    public String helloPage(){
        return "index";
    }

    @RequestMapping("/damagetype")
    public String damageType(){
        return "damagetype";
    }

    @RequestMapping("/statistika")
    public String statistika(){
        return "statistika";
    }

    @RequestMapping("/map")
    public String mapPage(){
        return "map";
    }

    @RequestMapping("/help")
    public String calendarPage(){
        return "help";
    }
}
