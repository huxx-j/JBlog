package com.huxx.dao;

import com.huxx.vo.CategoryVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CategoryDao {

    @Autowired
    SqlSession sqlSession;

    public List<CategoryVo> category(String id){
        return sqlSession.selectList("cate.category", id);
    }

    public int createCate(CategoryVo categoryVo){
        sqlSession.insert("cate.create",categoryVo);
        return categoryVo.getCateNo();
    }

    public List<CategoryVo> cateModify(String id){
        return sqlSession.selectList("cate.cateModify", id);
    }

    public CategoryVo select(int no) {
        System.out.println(no);
        return sqlSession.selectOne("cate.ajaxAdd", no);
    }

    public int cateDel(int cateNo) {
        return sqlSession.delete("cate.del", cateNo);
    }

    public int getFirstCate(String id) {
        return sqlSession.selectOne("cate.getFirstCate", id);
    }
}
