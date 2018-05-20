package ru.taxofon.controller;

import org.junit.Test;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;
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

    @Test
    public void addTaxofonAndCheck(){
        TaxofonList taxofon = createTaxofon();
    }

    @Test
    public void updTaxofonCore(){
        RestTemplate template = new RestTemplate();
        ResponseEntity<TaxofonList> responseEntity = template.exchange(
                ROOT + GET_BY_ID + "/1",
                HttpMethod.GET,
                null,
                TaxofonList.class
        );
        assertEquals("OK", responseEntity.getStatusCode().getReasonPhrase());
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

        taxofon.setAdres("Адрес1");
        taxofon.setKrdid("250");
        taxofon.setLat("45.123");
        taxofon.setLon("34.765");
        taxofon.setTlfnum("95111");
        taxofon.setType("УТЭК-2");
        return taxofon;
    }
}
