package com.baizhi.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baizhi.dao.DeptDao;
import com.baizhi.entity.Dept;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import redis.clients.jedis.Jedis;

import java.util.List;

@Service
@Transactional
public class DeptServiceImpl implements DeptService {

    @Autowired
    private DeptDao deptDao;

    /*增加*/
    @Override
    public void insertOne(Dept dept) {

        Jedis jedis = null;
        try {
            jedis = new Jedis("192.168.190.128", 7000);
            deptDao.insert(dept);
            //每次增加之前先删除缓存内容
            jedis.del("com.baizhi.service.DeptService");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("redis Connection exception...");
        } finally {
            jedis.close();
        }
    }

    /*查询所有*/
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<Dept> selectAll() {
        List<Dept> all = deptDao.findAll();
        return all;
    }

    /*分页查询所有*/
    @Override
    public List<Dept> findByPage(Integer page, Integer rows) {
        Jedis jedis = null;
        try {
            //将数据整理放在hash类型的集合里
            String key = "findAll" + page + "-" + rows;
            //Jedis是redis的java版本的客户端实现。
            jedis = new Jedis("192.168.190.128", 7000);
            //判断是否存在
            if (jedis.hexists("com.baizhi.service.DeptService", key)) {
                //存在,直接从redis缓存里面取
                String s = jedis.hget("com.baizhi.service.DeptService", key);
                List<Dept> depts = JSONObject.parseArray(s, Dept.class);
                return depts;
            } else {
                //不存在,查询数据库
                int start = (page - 1) * rows;
                List<Dept> list = deptDao.findByPage(start, rows);
                //将list集合转换成json，并存进redis缓存中
                String s = JSON.toJSONString(list);
                jedis.hset("com.baizhi.service.DeptService", key, s);
                return list;
            }
        } catch (Exception e) {
            //如果服务器宕机，则还是从数据库里查询数据
            int start = (page - 1) * rows;
            return deptDao.findByPage(start, rows);
        } finally {
            //关闭流
            jedis.close();
        }
    }

    /*查询总条数*/
    @Override
    public Long findTotals() {
        Long totals = deptDao.findTotals();
        return totals;
    }


}
