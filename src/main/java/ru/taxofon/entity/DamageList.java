package ru.taxofon.entity;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
public class DamageList {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    private String tlfnum;
    private String description;
    private LocalDateTime dateTimeBegin;
    private LocalDateTime dateTimeEnd;
    private String krdid;

    /*@ManyToOne
    private TaxofonList taxofonList;


    public TaxofonList getTaxofonList() {
        return taxofonList;
    }

    public void setTaxofonList(TaxofonList taxofonList) {
        this.taxofonList = taxofonList;
    }*/

    public LocalDateTime getDateTimeBegin() {
        return dateTimeBegin;
    }

    public void setDateTimeBegin(LocalDateTime dateTimeBegin) {
        this.dateTimeBegin = dateTimeBegin;
    }

    public LocalDateTime getDateTimeEnd() {
        return dateTimeEnd;
    }

    public void setDateTimeEnd(LocalDateTime dateTimeEnd) {
        this.dateTimeEnd = dateTimeEnd;
    }


    public String getKrdid() {
        return krdid;
    }

    public void setKrdid(String krdid) {
        this.krdid = krdid;
    }

    public long getId() {
        return id;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "DamageList{" +
                "id=" + id +
                ", tlfnum='" + tlfnum + '\'' +
                ", description='" + description + '\'' +
                ", dateTimeBegin=" + dateTimeBegin +
                ", dateTimeEnd=" + dateTimeEnd +
                ", krdid='" + krdid + '\'' +
                '}';
    }
}
