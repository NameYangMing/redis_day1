package com.baizhi.dao;

import com.baizhi.entity.Dept;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DeptDao {
    /*增加*/
    void insert(Dept dept);

    /*查询所有*/
    List<Dept> findAll();

    //参数1：起始条数  参数2：每页显示的记录数
    List<Dept> findByPage(@Param("start") Integer start, @Param("rows") Integer rows);

    //查询总条数
    Long findTotals();
}
