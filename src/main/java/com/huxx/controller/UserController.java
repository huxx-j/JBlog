package com.huxx.controller;

import com.huxx.service.UserService;
import com.huxx.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "/user")
public class UserController {

    @Autowired
    UserService userService;

    @RequestMapping(value = "/join", method = RequestMethod.GET)
    public String joinForm(){
        return "user/joinForm";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginForm(){
        return "user/loginForm";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String add(@ModelAttribute UserVo userVo){
        System.out.println("cont : "+userVo.toString());
        userService.add(userVo);
        return "user/joinSuccess";
    }

    @RequestMapping(value = "/log_in", method = RequestMethod.POST)
    public String login(HttpSession session, @ModelAttribute UserVo userVo, @RequestParam("b_id") String id){
        UserVo authUser = userService.login(userVo);
        if (authUser != null) {
            session.setAttribute("authUser", authUser);
            return "redirect:/"+id;
        } else {
            return "redirect:login?result=fail";
        }
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.removeAttribute("authUser");
        session.invalidate();
        return "redirect:/";
    }

    @RequestMapping(value = "/logout/{id}", method = RequestMethod.GET)
    public String logoutBlog(@PathVariable String id, HttpSession session) {
        session.removeAttribute("authUser");
        session.invalidate();
        return "redirect:/"+id;
    }

    @RequestMapping(value = "/login/{id}")
    public String loginBlog(@PathVariable String id, Model model){
        model.addAttribute("id",id);
        return "user/loginForm";
    }
}
