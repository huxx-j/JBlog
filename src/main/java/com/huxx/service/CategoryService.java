package com.huxx.service;

import com.huxx.dao.CategoryDao;
import com.huxx.dao.PostDao;
import com.huxx.vo.CategoryVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {

    @Autowired
    CategoryDao categoryDao;
    @Autowired
    PostDao postDao;

    public List<CategoryVo> category(String id){
        return categoryDao.category(id);
    }

    public List<CategoryVo> cateModify(String id){
        return categoryDao.cateModify(id);
    }

    public CategoryVo cateAdd(CategoryVo categoryVo){
        int c = categoryDao.createCate(categoryVo);
        System.out.println(c);
        if (c != 0) {
            categoryVo = categoryDao.select(c);
            System.out.println(categoryVo.toString());
            return categoryVo;
        } else {
            return null;
        }
    }

    public int cateDel(int cateNo) {
        int postCnt = postDao.postCount(cateNo);
        if (postCnt==0) {
            int c = categoryDao.cateDel(cateNo);
            if (c>0) {
                return cateNo;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    }

}
