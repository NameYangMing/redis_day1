package com.baizhi.controller;

import com.baizhi.entity.Dept;
import com.baizhi.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/all")
public class DeptController {

    @Autowired
    private DeptService deptService;

    /*查询所有*/
    //展示所有
    @RequestMapping("/findAll")
    public @ResponseBody
    Map<String, Object> findAll(String name, Integer page, Integer rows) {

        Map<String, Object> results = new HashMap<String, Object>();
        //当前页数据
        List<Dept> emps = deptService.findByPage(page, rows);
        //总记录数
        Long totals = deptService.findTotals();
        results.put("total", totals);
        results.put("rows", emps);
        return results;

    }

    /*增加*/
    @RequestMapping("/save")
    public @ResponseBody
    Map<String, Object> save(Dept dept) {
        HashMap<String, Object> result = new HashMap<String, Object>();
        try {
            deptService.insertOne(dept);
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", e.getMessage());
        }

        return result;
    }

}
