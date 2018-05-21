package ru.taxofon.controller;

import org.junit.Test;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;
import ru.taxofon.entity.DamageList;
import ru.taxofon.entity.TaxofonList;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThat;

public class TaxofonListControllerIntegrationTest {
    private static final String ROOT = "http://localhost:8080/taxofon";
    private static final String ADD = "/add";
    private static final String ALL = "/all";
    private static final String GET_BY_ID = "/get";
    private static final String DELETE = "/delete";
    private static final String PUT = "/upd";

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

        DamageList damageList = new DamageList();
        damageList.setTlfnum(responseEntity.getBody().getTlfnum());
        damageList.setDescription("линейная неисправность");
        System.out.println("responseEntity=" +responseEntity.getBody().getId() + " " + responseEntity.getBody().getTlfnum() + " " + responseEntity.getBody().getDamageLists());
        responseEntity.getBody().addDamageList(damageList);
        System.out.println("responseEntity_new=" +responseEntity.getBody().getId() + " " + responseEntity.getBody().getTlfnum() + " " + responseEntity.getBody().getDamageLists());
        System.out.println("damageList=" + damageList);
//        responseEntity.getBody().setDamageLists(responseEntity.getBody().getDamageLists().add);

        //делаем Update таксофону новыми параметрами
//        responseEntity.getBody().setTlfnum("95333");
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
        taxofon.setTlfnum("95222");
        taxofon.setType("УТЭК-2");
        return taxofon;
    }
}
