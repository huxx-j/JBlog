<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
				<input type="hidden" id="id" value="${authUser.id}">
				<ul class="admin-menu">
					<li><a href="/${authUser.id}/admin/basic">기본설정</a></li>
					<li class="selected"><a href="/${authUser.id}/admin/category">카테고리</a></li>
					<li><a href="/${authUser.id}/admin/write">글작성</a></li>
				</ul>
				
		      	<table class="admin-cat">
		      		<thead>
			      		<tr>
			      			<th>번호</th>
			      			<th>카테고리명</th>
			      			<th>포스트 수</th>
			      			<th>설명</th>
			      			<th>삭제</th>      			
			      		</tr>
		      		</thead>
		      		<tbody id=cateList>

					</tbody>
				</table>
      	
      			<h4 class="n-c">새로운 카테고리 추가</h4>
		      	<table id="admin-cat-add" >
		      		<tr>
		      			<td class="t">카테고리명</td>

		      			<td><input type="text" name="name" value=""></td>
		      		</tr>
		      		<tr>
		      			<td class="t">설명</td>
		      			<td><input type="text" name="desc"></td>
		      		</tr>
		      		<tr>
		      			<td class="s">&nbsp;</td>
		      			<td><input id="btnAddCate" type="button" value="카테고리 추가"></td>
		      		</tr>      		      		
		      	</table> 
		      	
			</div>
		</div>

		<c:import url="/WEB-INF/views/includes/footer.jsp"/>
	</div>
</body>

<script type="text/javascript">
    $(document).ready(function () {
        fetchList();
    });

    function fetchList() {
        var id = $("#id").val();
        $.ajax({
            url: "/api/cate/list",
            type: "post",
			data: {"id": id},
            dataType: "json",
            success: function (list) {
                for(var i =0; i<list.length; i++) {
                    render(list[i])
                }
            },
            error: function (XHR, status, error) {
                console.error(status + " : " + error);
            }
        });
    }

    function render(categoryVo) {
        var str = "";
        str += "<tr id='"+categoryVo.cateNo+"'>";
        str += "<td>"+categoryVo.cateNo+"</td>";
        str += "<td>"+categoryVo.cateName+"</td>";
        str += "<td>"+categoryVo.postCnt+"</td>";
        str += "<td>"+categoryVo.description+"</td>";
        str += "<td>";
        str += "<img class='"+categoryVo.cateNo+"' src='${pageContext.request.contextPath}/assets/images/delete.jpg'>";
		str += "</td>";
        str += "</tr>";

        $("#cateList").prepend(str);
    }

    $("#btnAddCate").on("click", function () {
        categoryVo = {cateName: $("[name=name]").val(),
            			description: $("[name=desc]").val(),
						id: $("#id").val()};

        $.ajax({
            url: "/api/cate/add",
            type: "post",
            contentType: "application/json",
            data: JSON.stringify(categoryVo),
            dataType: "json",
            success: function (categoryVo) {
                    render(categoryVo);
                    $("[name=desc]").val("");
					$("[name=name]").val("");

            },
            error: function (XHR, status, error) {
                console.error(status + " : " + error);
            }
        });
    });

    $("tbody").on("click", "img", function () {
		var cateNo = $(this).attr("class");
        $.ajax({
            url: "/api/cate/del",
            type: "post",
            // contentType: "application/json",
            data: {"cateNo" : cateNo},
            dataType: "json",
            success: function (result) {
                if(result==0) {
                    alert("삭제할 수 없습니다.");
				} else {
                    $("#"+result).remove();
				}
            },
            error: function (XHR, status, error) {
                console.error(status + " : " + error);
            }
        });
    })
</script>

</html>