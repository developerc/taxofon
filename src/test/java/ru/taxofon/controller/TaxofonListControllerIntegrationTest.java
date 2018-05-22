package ru.taxofon.controller;

import org.junit.Test;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;
import ru.taxofon.entity.DamageList;
import ru.taxofon.entity.TaxofonList;

import java.time.LocalDateTime;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;

public class TaxofonListControllerIntegrationTest {
    private static final String ROOT_DAMAGE = "http://localhost:8080/damage";
    private static final String ROOT = "http://localhost:8080/taxofon";
    private static final String ADD = "/add";
    private static final String ALL = "/all";
    private static final String GET_BY_ID = "/get";
    private static final String DELETE = "/delete";
    private static final String PUT = "/upd";

    @Test
    public void getAllTaxofon(){
        RestTemplate template = new RestTemplate();
        ResponseEntity<List<TaxofonList>> listResponseEntity = template.exchange(
                ROOT + ALL,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<TaxofonList>>() {
                }
        );
        List<TaxofonList> list = listResponseEntity.getBody();
        System.out.println(list.get(0).getId() + " " + list.get(0).getTlfnum() + " " + list.get(0).getDamageLists());
    }

    @Test
    public void addTaxofonAndCheck(){
        TaxofonList taxofon = createTaxofon();
    }

    @Test
    public void updTaxofonCore(){
        RestTemplate template = new RestTemplate();
        //получим экземпляр таксофона от сервера
        ResponseEntity<TaxofonList> responseEntity = template.exchange(
                ROOT + GET_BY_ID + "/1",
                HttpMethod.GET,
                null,
                TaxofonList.class
        );
        assertEquals("OK", responseEntity.getStatusCode().getReasonPhrase());
        System.out.println("tlfnum=" + responseEntity.getBody().getTlfnum());

//        DamageList damageList = new DamageList();
//        damageList.setTlfnum(responseEntity.getBody().getTlfnum());
//        damageList.setDescription("линейная неисправность");

        //создадим неисправность
        DamageList damageList = addCustomDamageList();
        System.out.println("responseEntity=" +responseEntity.getBody().getId() + " " + responseEntity.getBody().getTlfnum() + " " + responseEntity.getBody().getDamageLists());
        //к таксофону приклеим неисправность
        responseEntity.getBody().addDamageList(damageList);
        System.out.println("responseEntity_new=" +responseEntity.getBody().getId() + " " + responseEntity.getBody().getTlfnum() + " " + responseEntity.getBody().getDamageLists());
        System.out.println("damageList=" + damageList);
//        responseEntity.getBody().setDamageLists(responseEntity.getBody().getDamageLists().add);

//        responseEntity.getBody().setTlfnum("95333");
        //делаем Update таксофону новыми параметрами
        ResponseEntity<TaxofonList> responseEntity2 = template.exchange(
          ROOT + PUT,
          HttpMethod.PUT,
          responseEntity,
                TaxofonList.class
        );
        System.out.println("responseEntity2=" +responseEntity2.getBody().getId() + " " + responseEntity2.getBody().getTlfnum() + " " + responseEntity2.getBody().getDamageLists());
    }

    private TaxofonList createTaxofon() {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON_UTF8);

        TaxofonList taxofon = prefillTaxofon();

        HttpEntity entity = new HttpEntity(taxofon, headers);
        RestTemplate template = new RestTemplate();

        TaxofonList receivedTaxofonList = template.exchange(
                ROOT + ADD,
                HttpMethod.POST,
                entity,
                TaxofonList.class
        ).getBody();

        assertNotNull(receivedTaxofonList.getTlfnum());
        assertEquals(taxofon.getTlfnum(), receivedTaxofonList.getTlfnum());

        return receivedTaxofonList;
    }

    private TaxofonList prefillTaxofon() {
        TaxofonList taxofon = new TaxofonList();

        taxofon.setAdres("Адрес2");
        taxofon.setKrdid("251");
        taxofon.setLat("45.123");
        taxofon.setLon("34.765");
        taxofon.setTlfnum("95111");
        taxofon.setType("УТЭК-2");
        return taxofon;
    }

    //----- Create DamageList Entity ----- создаем некоторую неисправность, добавляется запись в таблице DamageList
    private DamageList addCustomDamageList(){
        DamageList damage = createDamage();
        return damage;
    }

    private DamageList createDamage() {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON_UTF8);

        DamageList damage = prefillDamage();

        HttpEntity entity = new HttpEntity(damage, headers);
        RestTemplate template = new RestTemplate();

        DamageList receivedDamageList = template.exchange(
                ROOT_DAMAGE + ADD,
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

        damage.setDescription("Какая-то неисправность4");
        damage.setTlfnum("95444");
        damage.setKrdid("Здесь будет адрес таксофона2");
        damage.setDateTimeBegin(LocalDateTime.now());
        return damage;
    }
}
