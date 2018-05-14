package com.huxx.api.controller;

import com.huxx.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/api/user")
public class ApiUserController {

    @Autowired
    UserService userService;

    @ResponseBody
    @RequestMapping(value = "/idcheck", method = RequestMethod.POST)
    public String isExists(@RequestParam("id") String id) {
        return userService.idCheck(id);
    }
}
