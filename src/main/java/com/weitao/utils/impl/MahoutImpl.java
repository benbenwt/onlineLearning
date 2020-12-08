package com.weitao.utils.impl;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import com.weitao.utils.Mahout;
import org.apache.mahout.cf.taste.common.TasteException;
import org.apache.mahout.cf.taste.impl.model.jdbc.MySQLJDBCDataModel;
import org.apache.mahout.cf.taste.impl.neighborhood.NearestNUserNeighborhood;
import org.apache.mahout.cf.taste.impl.recommender.GenericItemBasedRecommender;
import org.apache.mahout.cf.taste.impl.recommender.GenericUserBasedRecommender;
import org.apache.mahout.cf.taste.impl.similarity.PearsonCorrelationSimilarity;
import org.apache.mahout.cf.taste.neighborhood.UserNeighborhood;
import org.apache.mahout.cf.taste.recommender.RecommendedItem;
import org.apache.mahout.cf.taste.recommender.Recommender;
import org.apache.mahout.cf.taste.similarity.ItemSimilarity;
import org.apache.mahout.cf.taste.similarity.UserSimilarity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


import java.io.IOException;
import java.util.List;
@Component
public class MahoutImpl implements Mahout {
    @Autowired
    ComboPooledDataSource dataSource;

    public List<RecommendedItem> recommendByUser(Integer uid, Integer howMany) throws TasteException {
        MySQLJDBCDataModel dataModel=new MySQLJDBCDataModel(dataSource,"comments","uId","cId","star",null);
        UserSimilarity similarity=new PearsonCorrelationSimilarity(dataModel);
        UserNeighborhood neighborhood=new NearestNUserNeighborhood(2,similarity,dataModel);
        Recommender recommender=new GenericUserBasedRecommender(dataModel,neighborhood,similarity);

        return recommender.recommend(uid,howMany);
    }


    public List<RecommendedItem> recommendByItem(Integer cid, Integer howMany) throws TasteException {
        List<RecommendedItem> recommendations = null;
        MySQLJDBCDataModel model = new MySQLJDBCDataModel(dataSource,"comments","uId","cId","star",null);//构造数据模型
        ItemSimilarity similarity = new PearsonCorrelationSimilarity(model);//计算内容相似度
        Recommender recommender = new GenericItemBasedRecommender(model, similarity);//构造推荐引擎
        recommendations = recommender.recommend(cid,howMany);
        return recommendations;
    }




}
