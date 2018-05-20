package ru.taxofon.controller;

import org.junit.Test;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.web.client.RestTemplate;
import ru.taxofon.entity.DamageList;
import ru.taxofon.entity.TaxofonList;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

public class DamageListControllerIntegrationTest {
    private static final String ROOT = "http://localhost:8080/damage";
    private static final String ADD = "/add";
    private static final String ALL = "/all";
    private static final String GET_BY_ID = "/get";
    private static final String DELETE = "/delete";

    @Test
    public void addDamageAndTest(){
        DamageList damage = createDamage();
    }

    private DamageList createDamage() {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON_UTF8);

        DamageList damage = prefillDamage();

        HttpEntity entity = new HttpEntity(damage, headers);
        RestTemplate template = new RestTemplate();

        DamageList receivedDamageList = template.exchange(
                ROOT + ADD,
                HttpMethod.POST,
                entity,
                DamageList.class
        ).getBody();

        assertNotNull(receivedDamageList.getDescription());
        assertEquals(damage.getDescription(), receivedDamageList.getDescription());

        return receivedDamageList;
    }

    private DamageList prefillDamage() {
        DamageList damage = new DamageList();

        damage.setDescription("Какая-то неисправность");
        damage.setTlfnum("97111");
       // damage.setTaxofonList(taxofon);
        return damage;
    }
}
