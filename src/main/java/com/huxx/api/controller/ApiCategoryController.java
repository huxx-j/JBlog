package com.huxx.api.controller;

import com.huxx.service.CategoryService;
import com.huxx.vo.CategoryVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping(value = "/api/cate", method = RequestMethod.POST)
public class ApiCategoryController {

    @Autowired
    CategoryService categoryService;

    @ResponseBody
    @RequestMapping(value = "/list", method = RequestMethod.POST)
    public List<CategoryVo> cateList(@RequestParam("id") String id){
        return categoryService.cateModify(id);
    }

    @ResponseBody
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public CategoryVo add(@RequestBody CategoryVo categoryVo){
        return categoryService.cateAdd(categoryVo);
    }

    @ResponseBody
    @RequestMapping(value = "/del",method = RequestMethod.POST)
    public int del(@RequestParam("cateNo") int cateNo) {
        return categoryService.cateDel(cateNo);
    }
}
