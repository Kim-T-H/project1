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
<style type="text/css">
.container {
	display: flex;
	width: 100%;
	padding: 0;
	margin: 0;
}
.container .nav_content {
	width: 20%;
	height: 919px;
	background: #fff;
	border-right: 3px solid #000;
}
.container .nav_content .navbar {
	padding: 20px;
}
.container .nav_content .navbar .nav ul {
	list-style: none;
	padding: 20px;
	margin: 0;
	padding: 0;
}
.container .nav_content .navbar .nav ul li {
	text-align: center;
	font-size: 16px;
	font-weight: 300;
	line-height: 2;
}
.container .content {
	width: 80%;
	height: 919px;
	background: #fff;
}
.content h2 {
	text-align: center;
}
.content .board a {
	text-decoration: none;
	color: #000;
	font-size: 20px;
}
.content .board {
	padding: 0 50px;
	width: 600px;
	float: left;
	text-align: center;
}
.content .board table {
	width: 100%;
	border-collapse: collapse;
	border-top: 3px solid #000;
	border-bottom: 3px solid #000;
}
.content .board table td{
	border-collapse: collapse;
	border-top: 1px solid #000;
	text-align: center;
}
.content .board table td{
	text-align: center;
}
.content .member {
	width: 400px;
	padding: 0 150px 0 50px;
	float: right;
	text-align: center;
}
.content .member .memberlist {
	border: 3px solid #000;
}
.content .member .memberlist ul {
	list-style: none;
	padding: 0
}
.content .member .memberlist ul li {
	text-align: center;
}
.content .member a {
	text-decoration: none;
	color: #000;
	font-size: 20px;
}
.content .calendar {
	float: left;
	padding: 10px 50px;
}
</style>
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
							<li><a href="#">My TIL</a></li>
						</c:if>
						<li><a href="${path}/user/logout.dev">로그아웃</a></li>
					</ul>
				</li>
			</c:if>
			</ul>
		</nav>
		<nav class="nav2">
			<ul class="nav-menu">
				<li class="menu-li"><a href="#">TIL</a></li>
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
	<div class="container">
		<div class="nav_content">
			<div class="navbar">
				<div class="nav">
					<ul>
						<li>-스터디</li>
							<c:forEach items="${group}" var="gr">
								<li>
									<c:if test="${gr.category == '스터디' }">
										<a href="${path}/group/main.dev?gno=${gr.gno}">${gr.title}</a>
									</c:if>
								</li>
							</c:forEach>
					</ul>
					<ul>
						<li>-공모전</li>
							<c:forEach items="${group}" var="gr">
								<li>
									<c:if test="${gr.category == '공모전' }">
										<a href="${path}/group/main.dev?gno=${gr.gno}">${gr.title}</a>
									</c:if>
								</li>
							</c:forEach>
					</ul>
					<ul>
						<li>-프로젝트</li>
							<c:forEach items="${group}" var="gr">
								<li>
									<c:if test="${gr.category == '프로젝트' }">
										<a href="${path}/group/main.dev?gno=${gr.gno}">${gr.title}</a>
									</c:if>
								</li>
							</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		<div class="content">
		<decorator:body></decorator:body>
		</div>
	</div>
	</div>
</body>
</html>