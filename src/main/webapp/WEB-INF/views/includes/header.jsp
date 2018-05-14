<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Huxx_j
  Date: 2018. 5. 8.
  Time: 오후 4:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- 메인해더 -->
<a href="${pageContext.request.contextPath}/">
    <img class="logo" src="${pageContext.request.contextPath}/assets/images/logo.jpg">
</a>
<ul class="menu">
    <c:choose>
        <c:when test="${empty authUser}">
            <li><a href="${pageContext.request.contextPath}/user/login">로그인</a></li>
            <li><a href="${pageContext.request.contextPath}/user/join">회원가입</a></li>
        </c:when>
        <c:otherwise>
            <li><a href="${pageContext.request.contextPath}/user/logout">로그아웃</a></li>
            <li><a href="${pageContext.request.contextPath}/${authUser.id}">내블로그</a></li>
        </c:otherwise>
    </c:choose>
</ul>
