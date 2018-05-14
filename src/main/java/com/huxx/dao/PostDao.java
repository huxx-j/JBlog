package com.huxx.dao;

import com.huxx.vo.PostVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class PostDao {

    @Autowired
    SqlSession sqlSession;

    public int postCount(int cateNo) {
        return sqlSession.selectOne("post.count", cateNo);
    }

    public void addPost(PostVo postVo) {
        sqlSession.insert("post.addPost", postVo);
    }

    public PostVo getCatePost(Map<String, Integer> map) {
        return sqlSession.selectOne("post.getCP",map);
    }

    public List<PostVo> getList(Map<String, Object> listMap) {
        return sqlSession.selectList("post.getList", listMap);
    }
}
