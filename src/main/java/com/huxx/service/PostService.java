package com.huxx.service;

import com.huxx.dao.CategoryDao;
import com.huxx.dao.PostDao;
import com.huxx.vo.PostVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PostService {

    @Autowired
    PostDao postDao;
    @Autowired
    CategoryDao categoryDao;

    public void addPost(PostVo postVo) {
        postDao.addPost(postVo);
    }

    public Map<String, Object> getList(Object object, int crtPage) {
        List<PostVo> list;
        String id;
        int cateNo;

        //페이징 시작
        crtPage = (crtPage<0)?(crtPage=1):crtPage;

        // 한페이지에 보여줄 게시글 개수
        int listCnt = 5;

        int end = listCnt * crtPage;
        int begin = end - (listCnt-1);

        //Object로 받은 변수 각각 타입으로 변환해서 처리하는 if
        if (object.getClass() == java.lang.String.class) { //블로그 메인 포스트 리스트
            id= (String)object;
            cateNo = categoryDao.getFirstCate(id);
        } else { //카테고리 클릭시 포스트 리스트
            cateNo = (int)object;
        }

        Map<String, Object> listMap = new HashMap<>();
        listMap.put("begin",begin);
        listMap.put("end",end);
        listMap.put("cateNo",cateNo);

        list = postDao.getList(listMap);

        int totalCnt = postDao.postCount(cateNo);

        int pageBtnCnt = 5;

        int endPageBtnNo = (int)(Math.ceil(crtPage/(double)pageBtnCnt)) * 5;
        int startPageBtnNo= endPageBtnNo - (pageBtnCnt-1);

        boolean next = false;
        if (endPageBtnNo * listCnt < totalCnt) { //이동할 페이지가 남아 있다면 보이게 처리
            next = true;
        } else { //이동할 페이지가 남아 있지 않으면 마지막 버튼 값 계산
            endPageBtnNo = (int) (Math.ceil(totalCnt / (double) listCnt));
        }

        boolean prev = false;
        if (startPageBtnNo != 1) {
            prev = true;
        }

        Map<String, Object> return_Map = new HashMap<>();
        return_Map.put("cateNo", cateNo);
        return_Map.put("list", list);
        return_Map.put("next", next);
        return_Map.put("prev",prev);
        return_Map.put("startPageBtnNo",startPageBtnNo);
        return_Map.put("endPageBtnNo", endPageBtnNo);

        return return_Map;
    }

    //블로그 메인페이지 접속시 첫 카테고리의 최신글
    public PostVo getLastestPost(String id) { //2
        Map<String, Integer> map = new HashMap<>();
        map.put("cateNo",categoryDao.getFirstCate(id)); //5
        map.put("postNo",0);
        return postDao.getCatePost(map); //3
    }

    //블로그카테고리 리스트에서 글 클릭할때
    public PostVo getCatePost(int cateNo, int postNo) {
        Map<String, Integer> map = new HashMap<>();
        map.put("cateNo",cateNo);
        map.put("postNo",postNo);
        return postDao.getCatePost(map); //3
    }
}
