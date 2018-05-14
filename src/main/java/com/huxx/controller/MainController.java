package com.huxx.controller;

import com.huxx.service.BlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainController {
    @Autowired
    BlogService blogService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String main() {
        return "/main/index";
    }

    @RequestMapping(value = "/blog_search", method = RequestMethod.GET)
    public String blog_Search(@RequestParam("keyword") String keyword, @RequestParam("which") String which, Model model) {
        model.addAttribute("blog_s",blogService.blog_Search(keyword, which));
        return "/main/index";
    }
}
