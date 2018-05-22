package ru.taxofon.entity;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class TaxofonList {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    private String tlfnum;
    private String krdid;
    private String lon;
    private String lat;
    private String numsam;
    private String type;
    private String adres;
    private String version;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private List<DamageList> damageLists = new ArrayList<>();

    public List<DamageList> getDamageLists() {
        return damageLists;
    }

    public void setDamageLists(List<DamageList> damageLists) {
        this.damageLists = damageLists;
    }

    public List<DamageList> addDamageList(DamageList damageList){
        List<DamageList> listDL = getDamageLists();
        listDL.add(damageList);
        return listDL;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getAdres() {
        return adres;
    }

    public void setAdres(String adres) {
        this.adres = adres;
    }

    public long getId() {
        return id;
    }

    public String getLon() {
        return lon;
    }

    public void setLon(String lon) {
        this.lon = lon;
    }

    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getTlfnum() {
        return tlfnum;
    }

    public void setTlfnum(String tlfnum) {
        this.tlfnum = tlfnum;
    }

    public String getKrdid() {
        return krdid;
    }

    public void setKrdid(String krdid) {
        this.krdid = krdid;
    }

    public String getNumsam() {
        return numsam;
    }

    public void setNumsam(String numsam) {
        this.numsam = numsam;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
