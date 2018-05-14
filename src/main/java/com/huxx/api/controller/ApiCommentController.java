package com.huxx.api.controller;

import com.huxx.service.CommentService;
import com.huxx.vo.CommentVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping(value = "/api/cmt")
public class ApiCommentController {

    @Autowired
    CommentService commentService;

    @ResponseBody
    @RequestMapping(value = "/list", method = RequestMethod.POST)
    public List<CommentVo> getList(@RequestParam("postNo") int postNo){
        return commentService.getList(postNo);
    }

    @ResponseBody
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public CommentVo addCmt(@RequestBody CommentVo commentVo) {
        return commentService.addCmt(commentVo);
    }

    @ResponseBody
    @RequestMapping(value = "/del", method = RequestMethod.POST)
    public int del(@RequestParam int cmtNo) {
        return commentService.del(cmtNo);
    }
}
