<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><decorator:title></decorator:title></title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/standard/ckeditor.js"></script>
<decorator:head></decorator:head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${path}/css/main.css">
</head>
<body>
<header>
		<div class="logo"><a href="${path}/main/home.dev">Logo</a></div>
		<nav class="nav1">
			<ul>
			<c:if test="${loginUser == null}">
				<li><a href="${path}/user/login.dev"><i class="fa fa-sign-in"></i></a></li>
			</c:if>
			<c:if test="${loginUser != null}">
				<c:if test="${!sessionScope.loginUser.id.equals('admin')}">
					<li><a href="${path}/user/message.dev?id=${sessionScope.loginUser.id}"><i class="fa fa-envelope"></i></a></li>
					<li><a href="#"><i class="fa fa-bell"></i></a></li>
				</c:if>
				<li class="sub-menu"><a href="#"><i class="fa fa-user-circle"></i></a>
					<ul id="final">
						<c:if test="${sessionScope.loginUser.id.equals('admin')}">
				        	<li><a href="${path}/admin/adminpage.dev">관리자 페이지</a></li>
				        </c:if>
				        <c:if test="${!sessionScope.loginUser.id.equals('admin')}">
							<li><a href="${path}/user/mypage.dev">회원정보 수정</a></li>
							<li><a href="#">My Portfolio</a></li>
							<li><a href="${path}/til/mytil.dev">TIL</a></li>
						</c:if>
						<li><a href="${path}/user/logout.dev">로그아웃</a></li>
					</ul>
				</li>
			</c:if>
			</ul>
		</nav>
		<nav class="nav2">
			<ul class="nav-menu">
				<li class="menu-li"><a href="${path}/til/main.dev">TIL</a>
				<ul>
						<li><a href="${path}/til/main.dev?no=3">TIL 페이지 목록</a></li>
						<li><a href="${path}/til/subuser.dev">구독한 사용자 목록</a></li>
				</ul></li>
				<li class="sub-menu menu-li"><a href="#">Community</a>
					<ul>
						<li><a href="${path}/board/list.dev?no=4">Q&A게시판</a></li>
						<li><a href="${path}/board/list.dev?no=5">자유게시판</a></li>
					</ul></li>
				<li class="sub-menu menu-li"><a href="#">Co-Working</a>
					<ul>
						<li><a href="${path}/coworking/main.dev">Study/Project</a></li>
						<li><a href="${path}/group/main.dev">My Group</a></li>
					</ul>
				</li>
			</ul>
		</nav>
	</header>
	
	<div class="main">
		<decorator:body></decorator:body>
	</div>
	<script type="text/javascript">
		console.log("${sessionScope}");
	</script>
</body>
</html>