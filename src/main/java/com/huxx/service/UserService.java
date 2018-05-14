package com.huxx.service;

import com.huxx.dao.BlogDao;
import com.huxx.dao.CategoryDao;
import com.huxx.dao.UserDao;
import com.huxx.vo.BlogVo;
import com.huxx.vo.CategoryVo;
import com.huxx.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
public class UserService {

    @Autowired
    UserDao userDao;
    @Autowired
    BlogDao blogDao;
    @Autowired
    CategoryDao categoryDao;

    @Transactional
    public void add(UserVo userVo) {
        userDao.add(userVo);

        BlogVo blogVo = new BlogVo(userVo.getId(),userVo.getUserName()+"의 블로그 입니다.", "default");
        blogDao.createBlog(blogVo);

        CategoryVo categoryVo = new CategoryVo(userVo.getId(),"미분류","기본으로 만들어지는 카테고리 입니다.");
        categoryDao.createCate(categoryVo);

    }

    public UserVo login(UserVo userVo) {
        return userDao.login(userVo);
    }

    public String idCheck(String id){
         UserVo userVo = userDao.idCheck(id);
         if (userVo != null) {
             return "x";
         } else {
             return "o";
         }
    }
}
