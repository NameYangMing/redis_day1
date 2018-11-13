package com.baizhi.text;

import com.baizhi.entity.Dept;
import com.baizhi.service.DeptService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring.xml")
public class textProject {

    @Autowired
    private DeptService deptService;

    @Test
    public void text1() {
        Dept dept = new Dept();
        dept.setNo(10);
        dept.setName("研究部");
        dept.setCreateDate(new Date());
        dept.setNumber(8);
        dept.setMark("此部门的人嘴甜吗？人长的最帅。。。");

        deptService.insertOne(dept);
    }

    @Test
    public void test2() {
        List<Dept> depts = deptService.selectAll();
        for (Dept dept : depts) {
            System.out.println(dept);
        }
    }

}
