package ru.taxofon.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
}
