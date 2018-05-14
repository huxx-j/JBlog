package com.huxx.dao;

import com.huxx.vo.CommentVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CommentDao {

    @Autowired
    SqlSession sqlSession;

    public List<CommentVo> getList(int postNo) {
        return sqlSession.selectList("cmt.getList", postNo);
    }

    public int addCmt (CommentVo commentVo) {
        sqlSession.insert("cmt.addCmt",commentVo);
        return commentVo.getCmtNo();
    }

    public CommentVo select(int cmtNo) {
        return sqlSession.selectOne("cmt.select", cmtNo);
    }

    public int del (int cmtNo) {
        return sqlSession.delete("cmt.del", cmtNo);
    }
}
