package com.huxx.service;

import com.huxx.dao.CommentDao;
import com.huxx.vo.CommentVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {

    @Autowired
    CommentDao commentDao;

    public List<CommentVo> getList(int postNo) {
        return commentDao.getList(postNo);
    }

    public CommentVo addCmt(CommentVo commentVo) {
        return commentDao.select(commentDao.addCmt(commentVo));
    }

    public int del (int cmtNo) {
        return commentDao.del(cmtNo);
    }
}
