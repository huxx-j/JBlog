<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JBlog</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
    <script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
</head>
<body>
<div id="container">

    <c:import url="/WEB-INF/views/includes/blogheader.jsp"/>


    <div id="wrapper">
        <div id="content" class="full-screen">
            <ul class="admin-menu">
                <li class="selected"><a href="${pageContext.request.contextPath}/${authUser.id}/admin/basic">기본설정</a></li>
                <li><a href="${pageContext.request.contextPath}/${authUser.id}/admin/category">카테고리</a></li>
                <li><a href="${pageContext.request.contextPath}/${authUser.id}/admin/write">글작성</a></li>
            </ul>

            <form action="${pageContext.request.contextPath}/${authUser.id}/basicmod" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${authUser.id}">
                <table class="admin-config">
                    <tr>
                        <td class="t">블로그 제목</td>
                        <td><input type="text" size="40" name="blogTitle" value="${main.blogTitle}"></td>
                    </tr>
                    <tr>
                        <td class="t">로고이미지</td>
                        <td>
                            <c:choose>
                                <c:when test="${main.logoFile != 'default'}">
                                    <img src="/blog/logo/${main.logoFile}">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/assets/images/spring-logo.jpg">
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td class="t">&nbsp;</td>
                        <td><input type="file" name="file"></td>
                    </tr>
                    <tr>
                        <td class="t">&nbsp;</td>
                        <td class="s"><input type="submit" value="기본설정 변경"></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>


    <c:import url="/WEB-INF/views/includes/footer.jsp"/>

</div>
</body>

</html>