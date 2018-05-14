package com.huxx.controller;

import com.huxx.service.BlogService;
import com.huxx.service.CategoryService;
import com.huxx.service.PostService;
import com.huxx.vo.BlogVo;
import com.huxx.vo.PostVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "/{id}")
public class BlogController {

    @Autowired
    BlogService blogService;
    @Autowired
    CategoryService categoryService;
    @Autowired
    PostService postService;

        /*페이징 ing*/
    @RequestMapping(value = "",method = RequestMethod.GET)
    public String blogMain(@PathVariable String id, Model model, @RequestParam(value = "crtPage", required = false, defaultValue = "1") int crtPage) {
        model.addAttribute("main",blogService.main(id)); //블로그 기본 정보 불러오기(타이틀,로고)
        model.addAttribute("cate",categoryService.category(id)); //카테고리 불러오기
        model.addAttribute("pl",postService.getList(id, crtPage)); //1 메인 포스트 리스트
        model.addAttribute("p",postService.getLastestPost(id)); //2 가장 최근 포스트 불러오기
        return "blog/blog-main";
    }

    @RequestMapping(value = "/{cateNo}", method = RequestMethod.GET)
    public String getCatePostList(@PathVariable String id, @PathVariable int cateNo, Model model, @RequestParam(value = "crtPage", required = false, defaultValue = "1") int crtPage) {
        model.addAttribute("main",blogService.main(id));
        model.addAttribute("cate",categoryService.category(id));
        model.addAttribute("pl", postService.getList(cateNo, crtPage)); //3 카테고리 포스트 리스트 불러오기
        model.addAttribute("p",postService.getCatePost(cateNo,0));  //4 카테고리 포스트 가져오기

        return "blog/blog-main";
    }

    @RequestMapping(value = "/{cateNo}/post{postNo}", method = RequestMethod.GET)
    public String getPost(@PathVariable String id, @PathVariable int postNo, @PathVariable int cateNo, Model model, @RequestParam(value = "crtPage", required = false, defaultValue = "1") int crtPage) {
        model.addAttribute("main",blogService.main(id));
        model.addAttribute("cate",categoryService.category(id));
        model.addAttribute("pl", postService.getList(cateNo, crtPage)); //3
        model.addAttribute("p",postService.getCatePost(cateNo,postNo)); //4

        return "blog/blog-main";
    }

    @RequestMapping(value = "/admin/basic", method = RequestMethod.GET)
    public String adminBasic(@PathVariable String id, Model model, HttpSession session) {
        if(session.getAttribute("authUser")==null){
            return "redirect:/user/login";
        } else {
            model.addAttribute("main", blogService.main(id));
            return "blog/admin/blog-admin-basic";
        }
    }

    @RequestMapping(value = "/admin/category", method = RequestMethod.GET)
    public String adminCate(@PathVariable String id, Model model,HttpSession session) {
        if(session.getAttribute("authUser")==null){
            return "redirect:/user/login";
        } else {
            model.addAttribute("main", blogService.main(id));
            return "blog/admin/blog-admin-cate";
        }
    }

    @RequestMapping(value = "/admin/write", method = RequestMethod.GET)
    public String adminWrite(@PathVariable String id, Model model, HttpSession session) {
        if(session.getAttribute("authUser")==null){
            return "redirect:/user/login";
        } else {
            model.addAttribute("main", blogService.main(id));
            model.addAttribute("cate", categoryService.category(id));
            return "blog/admin/blog-admin-write";
        }
    }

    @RequestMapping(value = "/basicmod", method = RequestMethod.POST)
    public String basicModify(@ModelAttribute BlogVo blogVo, @RequestParam("file") MultipartFile file) {
        blogService.basicModify(blogVo,file);
        return "redirect:admin/basic";
    }

    @RequestMapping(value = "/addPost", method = RequestMethod.POST)
    public String addPost(@ModelAttribute PostVo postVo, @PathVariable String id){
        postService.addPost(postVo);
        return "redirect:/"+id+"/admin/write";
    }
}