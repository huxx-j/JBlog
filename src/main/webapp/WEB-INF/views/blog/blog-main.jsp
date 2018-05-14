<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JBlog</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
    <style type="text/css">
        .addCmtTbl {
            /*border-style: solid;*/
            /*border-color: black;*/
            /*border-width: 1px;*/
            /*border-collapse: collapse;*/
            padding: 3px;
        }

        #cmt_list {
            border-width: 0px;
        }
    </style>
</head>
<body>

<div id="container">

    <c:import url="/WEB-INF/views/includes/blogheader.jsp"/>

    <div id="wrapper">
        <div id="content">
            <br>
            <h4>_Post</h4>
            <div class="blog-content" style="height: 200px">
                <c:choose>
                    <c:when test="${!empty post}">
                        <h4>${post.postTitle}</h4>
                        <p>
                        <pre>${post.postContent}
                        <input type="hidden" id="pNo" value="${post.postNo}">
                        </pre>
                        </p>
                    </c:when>
                    <c:otherwise>
                        <h4>등록된 글이 없습니다.</h4>
                        <p></p>
                    </c:otherwise>
                </c:choose>
                <%--<c:choose>
                    <c:when test="${empty cpl}">
                        <c:choose>
                            <c:when test="${!empty lp}">
                                <h4>${lp.postTitle}</h4>
                                <p><pre>${lp.postContent}</pre></p>
                            </c:when>
                            <c:otherwise>
                                <h4>등록된 글이 없습니다.</h4>
                                <p></p>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        &lt;%&ndash;<c:if test="${empty lp}">&ndash;%&gt;
                            <h4>${cp.postTitle}</h4>
                        <p><pre>${cp.postContent}</pre></p>
                        &lt;%&ndash;</c:if>&ndash;%&gt;
                    </c:otherwise>
                </c:choose>--%>
            </div>

            <c:choose>
                <c:when test="${!empty authUser and !empty post}">
                    <h4>_Comment</h4><br>
                    <table style="width: 97%; border: solid 1px black; border-radius: 5px; margin-left: 10px ">
                        <tr>
                            <td class="addCmtTbl" style="width: 10%" align="center">${authUser.userName}</td>
                            <td class="addCmtTbl" align="left">
                                <input style="width: 99%" type="text" id="cmtContent" name="comment" value="">
                                <input type="hidden" name="postNo" id="postNo" value="${post.postNo}">
                                <input type="hidden" name="userNo" id="userNo" value="${authUser.userNo}">
                            </td>
                            <td class="addCmtTbl" style="width: 7%" align="center">
                                <input type="button" name="cmtAddBtn" id="cmtAddBtn" value="저장">
                            </td>
                        </tr>
                    </table>
                </c:when>
                <c:otherwise>
                    <c:if test="${!empty post}">
                        <h4>_Comment</h4><br>
                        <table style="width: 97%; border: solid 1px black; border-radius: 5px; margin-left: 10px">
                            <tr>
                                <td align="center">로그인을 하시면 Comment작성이 가능합니다.</td>
                            </tr>
                        </table>
                    </c:if>
                </c:otherwise>
            </c:choose>
            <br>
            <table id="cmt_list" style="width: 97%;margin-left: 10px; /*border: solid 1px black; border-radius: 5px*/">

            </table>
            <br>


            <c:if test="${!empty postList.list}">
                <h4>_Post List</h4>
                <ul class="blog-list" style="border: solid 1px black; width: 97%; border-radius: 5px">

                    <c:forEach items="${postList.list}" var="vo">
                        <li style="margin-top: 5px; margin-left: 10px">
                            <a href="${pageContext.request.contextPath}/${main.id}/${vo.cateNo}/post${vo.postNo}?crtPage=${param.crtPage}">${vo.postTitle}</a>
                            <span>${vo.regDate}</span>
                        </li>
                    </c:forEach>

                        <%--<c:if test="${empty pl}">
                            <c:forEach items="${cpl}" var="vo">
                                <li>
                                    <a href="/${main.id}/${vo.cateNo}/post${vo.postNo}">${vo.postTitle}</a>
                                    <span>${vo.regDate}</span>
                                </li>
                            </c:forEach>
                        </c:if>

                        <c:if test="${empty cpl}">
                            <c:forEach items="${pl}" var="vo">
                                <li>
                                    <a href="/${main.id}/${vo.cateNo}/post${vo.postNo}">${vo.postTitle}</a>
                                    <span>${vo.regDate}</span>
                                </li>
                            </c:forEach>
                        </c:if>--%>

                    <div class="pager">
                        <ul>
                            <c:if test="${postList.prev}">
                                <li><a href="${pageContext.request.contextPath}/${main.id}/${postList.cateNo}?crtPage=${postList.startPageBtnNo-1}">◀</a></li>
                            </c:if>

                            <c:forEach var="i" begin="${postList.startPageBtnNo}" end="${postList.endPageBtnNo}">
                                <li class="${param.crtPage eq i?'selected':''}"><a
                                        href="${pageContext.request.contextPath}/${main.id}/${postList.cateNo}?crtPage=${i}">${i}</a></li>
                            </c:forEach>

                            <c:if test="${postList.next}">
                                <li><a href="${pageContext.request.contextPath}/${main.id}/${postList.cateNo}?crtPage=${postList.endPageBtnNo+1}">▶</a></li>
                            </c:if>
                        </ul>
                    </div>
                </ul>
            </c:if>
        </div>
    </div>

    <div id="extra">
        <div class="blog-logo">
            <c:choose>
                <c:when test="${main.logoFile != 'default'}">
                    <img src="/blog/logo/${main.logoFile}">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/assets/images/spring-logo.jpg">
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div id="navigation">
        <h2>카테고리</h2>
        <ul>
            <c:forEach items="${cate}" var="vo">
                <li><a href="${pageContext.request.contextPath}/${main.id}/${vo.cateNo}">${vo.cateName}</a></li>
            </c:forEach>
        </ul>
    </div>

    <c:import url="/WEB-INF/views/includes/footer.jsp"/>

</div>
</body>

<script type="text/javascript">
    $(document).ready(function () {
        cmtCnt = 0;
        fetchList()
    });

    function fetchList() {
        var postNo = $("#pNo").val();
        $.ajax({
            url: "/api/cmt/list",
            type: "post",
            data: {"postNo": postNo},
            dataType: "json",
            success: function (list) {
                cmtCnt += list.length;
                if (list.length != 0) {

                    for (var i = 0; i < list.length; i++) {
                        render(list[i])
                    }
                } else {
                    $("#cmt_list").append("<tr id='no'><td>    _Comment가 없습니다.<td></tr>");
                }

            },
            error: function (XHR, status, error) {
                console.error(status + " : " + error);

            }
        });
    }

    $("#cmt_list").has

    function render(commentVo) {
        var str = "";
        str += "<tr id='" + commentVo.cmtNo + "'>";
        str += "<td style='width: 10%; padding: 2px' align='center'>" + commentVo.userName + "</td>";
        str += "<td style='width: 78%; padding: 2px' align='left'>" + commentVo.cmtContent + "</td>";
        str += "<td style='width: 20%; padding: 2px' align='right'>" + commentVo.regDate + "</td>";
        if ($("#userNo").val() == commentVo.userNo) {
            str += "<td style='padding: 2px'><img class='" + commentVo.cmtNo + "' src='${pageContext.request.contextPath}/assets/images/delete.jpg'></td>";
        } else {
            str += "<td></td>";
        }
        str += "</tr>";

        $("#cmt_list").append(str);

    }

    $("#cmtAddBtn").on("click", function () {
        commentVo = {
            cmtContent: $("#cmtContent").val(),
            postNo: $("#postNo").val(),
            userNo: $("#userNo").val()
        };

        $.ajax({
            url: "/api/cmt/add",
            type: "post",
            contentType: "application/json",
            data: JSON.stringify(commentVo),
            dataType: "json",
            success: function (commentVo) {
                $("#no").remove();
                render_p(commentVo);
                $("#cmtContent").val("");
                cmtCnt += 1;

            },
            error: function (XHR, status, error) {
                console.error(status + " : " + error);
            }
        });
    });

    function render_p(commentVo) {
        var str = "";
        str += "<tr id='" + commentVo.cmtNo + "'>";
        str += "<td style='width: 10%; padding: 2px' align='center'>" + commentVo.userName + "</td>";
        str += "<td style='width: 78%; padding: 2px' align='left'>" + commentVo.cmtContent + "</td>";
        str += "<td style='width: 20%; padding: 2px' align='right'>" + commentVo.regDate + "</td>";
        if ($("#userNo").val() == commentVo.userNo) {
            str += "<td style='padding: 2px'><img class='" + commentVo.cmtNo + "' src='${pageContext.request.contextPath}/assets/images/delete.jpg'></td>";
        } else {
            str += "<td></td>";
        }
        str += "</tr>";

        $("#cmt_list").prepend(str);

    }

    $("#cmt_list").on("click", "img", function () {
        var cmtNo = $(this).attr("class");

        $.ajax({
            url: "/api/cmt/del",
            type: "post",
            // contentType: "application/json",
            data: {"cmtNo": cmtNo},
            dataType: "json",
            success: function (result) {
                if (result != 0) {
                    $("#" + cmtNo).remove();
                    cmtCnt -= 1;
                }

                if (cmtCnt == 0) {
                    $("#cmt_list").append("<tr id='no'><td>    _Comment가 없습니다.<td></tr>");
                }
            },
            error: function (XHR, status, error) {
                console.error(status + " : " + error);
            }
        });
    })

</script>
</html>