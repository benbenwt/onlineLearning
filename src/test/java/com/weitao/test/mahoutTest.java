package com.weitao.test;

import com.weitao.utils.Mahout;
import org.apache.mahout.cf.taste.common.TasteException;
import org.apache.mahout.cf.taste.recommender.RecommendedItem;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class mahoutTest {
    @Autowired
    Mahout mahout;
    @Test
    public void testMahout() throws TasteException {
        List<RecommendedItem> list=mahout.recommendByUser(1,2);
        for(RecommendedItem item:list)
        {
            System.out.println(item);
        }
    }
    @Test
    public void testMahout1() throws TasteException {
        List<RecommendedItem> list=mahout.recommendByItem(1,2);
        for(RecommendedItem item:list)
        {
            System.out.println(item);
        }
    }
}
