<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JBlog</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>

    <style type="text/css">
        table {
            width: 74%;
            border: solid 2px coral;
            border-radius: 5px;
            margin-left: 9%;
            border-collapse: collapse;
        }
        td {
            border-bottom: rgba(255, 127, 80, 0.24) 1px solid;
        }

        .b_id {
            width: 30%;
            padding: 5px;
            padding-left: 10px;
        }

        .b_title {
            width: 80%;
            border-left: solid 2px coral;
            padding: 5px;
            padding-left: 10px;
        }
    </style>
</head>
<body>
<div class="center-content">

    <c:import url="/WEB-INF/views/includes/header.jsp"/>

    <form action="${pageContext.request.contextPath}/blog_search" method="post" class="search-form">
        <fieldset>
            <input type="text" name="keyword" value="${param.keyword}"/>
            <input id="s_Btn" type="submit" value="검색"/>
        </fieldset>
        <fieldset>
            <input type="radio" name="which" value="blog-title"> <label>블로그 제목</label>
            <input type="radio" name="which" value="blog-user" checked> <label>블로거</label>
        </fieldset>
    </form>
    <c:if test="${empty blog_s}">
        <h4 class="no_Result" style="margin-left: 9%" align="left">_Search Result</h4>
        <h4 class="no_Result">검색 결과가 없습니다.</h4>
    </c:if>

    <c:if test="${!empty blog_s}">
        <h4 style="margin-left: 9%" align="left">_Search Result</h4>
        <table>
            <tr>
                <td class="b_id" align="left">Blogger ID</td>
                <td class="b_title" align="left">Blog Title</td>
            </tr>
            <c:forEach items="${blog_s}" var="vo">
                <tr>
                    <td class="b_id" align="left"><a href="${pageContext.request.contextPath}/${vo.id}">${vo.id}</a>
                    </td>
                    <td class="b_title" align="left"><a
                            href="${pageContext.request.contextPath}/${vo.id}">${vo.blogTitle}</a></td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
</div>
</body>

<script type="text/javascript">
    $(document).ready(function () {
       if ("" == $("[name=keyword]").val()){
           $(".no_Result").remove();
       }
    });

    $("#s_Btn").on("click",function () {
        var spe_Char = /[`~!@#$%^&*()_+|]/; //금지할 특수문자 리스트([]안에 넣어주면 됨)
       if ($("[name=keyword]").val()=="") {
           alert("검색할 단어를 입력하세요.");
           return false;
       } else if(spe_Char.test($("[name=keyword]").val())) { //특수문자가 들어간 문자열을 검색못하게 하는 코드
           alert("특수문자는 검색하실수 없습니다.");
           return false;
       }
    });


</script>

</html>