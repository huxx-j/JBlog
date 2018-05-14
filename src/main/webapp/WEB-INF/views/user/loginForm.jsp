<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
</head>
<body>
	<div class="center-content">

		<c:import url="/WEB-INF/views/includes/header.jsp"/>
		
		<form class="login-form" method="post" action="${pageContext.request.contextPath}/user/log_in">
			<input type="hidden" name="b_id" value="${id}">
      		<label>아이디</label> 
      		<input type="text" name="id">
      		
      		<label>패스워드</label> 
      		<input type="text" name="password">

			<c:if test="${'fail' eq param.result}">
				<p class="form-error">
					로그인 실패<br>
					아이디/패스워드를 확인해 주세요
				</p>
			</c:if>

      		<input type="submit" value="로그인">
		</form>
		
	</div>
</body>

</html>