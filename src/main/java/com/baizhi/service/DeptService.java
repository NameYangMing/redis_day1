package com.baizhi.service;

import com.baizhi.entity.Dept;

import java.util.List;

public interface DeptService {
    /*增加*/
    void insertOne(Dept dept);

    /*查询所有*/
    List<Dept> selectAll();

    //查询分页
    List<Dept> findByPage(Integer page, Integer rows);

    /*查询总条数*/
    Long findTotals();
}
