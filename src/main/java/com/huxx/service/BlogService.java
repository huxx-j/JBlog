package com.huxx.service;

import com.huxx.dao.BlogDao;
import com.huxx.vo.BlogVo;
import com.huxx.vo.CategoryVo;
import com.huxx.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class BlogService {

    @Autowired
    BlogDao blogDao;

    public BlogVo main(String id) {
        return blogDao.main(id);
    }



    public void basicModify(BlogVo blogVo, MultipartFile file) {
        if (!file.isEmpty()) {
            String exName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            String logoFile = blogVo.getId() + "_logo" + exName;
            blogVo.setLogoFile(logoFile);
            blogDao.basicModify(blogVo);

            String filePath = "/Users/huxx_j/Documents/upload/blog_logo/" + logoFile;

            try {
                byte[] fileData = file.getBytes();
                OutputStream outputStream = new FileOutputStream(filePath);
                BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(outputStream);
                bufferedOutputStream.write(fileData);
                if (bufferedOutputStream != null) { //파일쓰기가 끝나고 연결이 돼있으면 연결을 끊는거
                    bufferedOutputStream.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else {
            blogDao.basicModify(blogVo);
        }
    }
}
