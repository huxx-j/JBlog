package com.huxx.dao;

import com.huxx.vo.UserVo;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao {

    @Autowired
    SqlSession sqlSession;

    public void add (UserVo userVo) {
        sqlSession.insert("user.add", userVo);
    }

    public UserVo login (UserVo userVo) {
        return sqlSession.selectOne("user.login", userVo);
    }

    public UserVo idCheck(String id) {
        return sqlSession.selectOne("user.idCheck", id);
    }
}
