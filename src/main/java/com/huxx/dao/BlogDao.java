package com.huxx.dao;

import com.huxx.vo.BlogVo;
import com.huxx.vo.CategoryVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sound.midi.Soundbank;
import java.util.List;
import java.util.Map;

@Repository
public class BlogDao {

    @Autowired
    SqlSession sqlSession;

    public void createBlog(BlogVo blogVo) {
        sqlSession.insert("blog.new", blogVo);
    }

    public BlogVo main(String id) {
        return sqlSession.selectOne("blog.main", id);
    }

    public void basicModify(BlogVo blogVo) {
        sqlSession.update("blog.basicModify", blogVo);
    }

    public List<BlogVo> blog_Search(Map<String, String> map) {
        List<BlogVo> list = sqlSession.selectList("blog.blog_Search", map);
        return list;
    }

}
