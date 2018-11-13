package com.baizhi.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Dept {
    private int id;
    private int no;
    private String name;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createDate;
    private int number;
    private String mark;

    public Dept() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
    }


    public Dept(int id, int no, String name, Date createDate, int number, String mark) {
        this.id = id;
        this.no = no;
        this.name = name;
        this.createDate = createDate;
        this.number = number;
        this.mark = mark;
    }

    @Override
    public String toString() {
        return "Dept{" +
                "id=" + id +
                ", no=" + no +
                ", name='" + name + '\'' +
                ", createDate=" + createDate +
                ", number=" + number +
                ", mark='" + mark + '\'' +
                '}';
    }
}
