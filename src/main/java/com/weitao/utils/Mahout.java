package com.weitao.utils;

import org.apache.mahout.cf.taste.common.TasteException;
import org.apache.mahout.cf.taste.recommender.RecommendedItem;

import java.util.List;

public interface Mahout {
    List<RecommendedItem> recommendByUser(Integer uid, Integer howMany) throws TasteException;
    List<RecommendedItem> recommendByItem(Integer cid, Integer howMany) throws TasteException;
}
