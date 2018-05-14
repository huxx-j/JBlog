<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Huxx_j
  Date: 2018. 5. 8.
  Time: 오후 9:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 블로그 해더 -->
<div id="header">
    <h1><a href="/${main.id}">${main.blogTitle}</a></h1>
    <ul>

        <c:choose>
            <c:when test="${empty authUser}">
                <li><a href="/user/login/${main.id}">로그인</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="/user/logout/${main.id}">로그아웃</a></li>
                <c:if test="${authUser.id == main.id}">
                    <li><a href="/${authUser.id}/admin/basic">내블로그 관리</a></li>
                </c:if>

            </c:otherwise>
        </c:choose>

    </ul>
</div>
