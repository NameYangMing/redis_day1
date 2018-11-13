package com.baizhi.text;


//用来操作redis中key相关的命令

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import redis.clients.jedis.Jedis;

import java.util.Set;

public class textAll {

    private Jedis jedis;

    @Before
    public void before() {
        //创建redis连接
        jedis = new Jedis("192.168.190.128", 7000);
        //选择要操作的库
        jedis.select(0);

    }


    @Test
    public void text() {
        Set<String> keys = jedis.keys("*");
        for (String key : keys) {
            System.out.println(key);
        }

    }


    @After
    public void after() {
        jedis.close();
        System.out.println("*****************");
    }

}
