<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TIL</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Roboto+Condensed&display=swap')
	;

body {
	margin: 0;
	padding: 0;
	font-family: 'Roboto Condensed', sans-serif !important;
}

section {
	padding: 180px 0 0;
}

.card {
	position: relative;
	height: 400px;
	overflow: hidden;
	box-shadow: 0 5px 15px rgba(0, 0, 0, .5);
}

.card .post-image {
	height: 300px;
	overflow: hidden;
}

.card .post-image img {
	height: 100%;
	width: 100%;
}

.card:hover .post-image img {
	transform: scale(1.1) translateY(-50px);
}
<!-- 위로 올라오는거 --> 
.card .news-content { 
	position:absolute;
	bottom: -150px;
	padding: 10px 20px 60px;
	background: #fff;
}

.card:hover .news-content {
	bottom: 0px;
}

.card .category {
	position: absolute;
	top: -30px;
	left: 0;
	height: 30px;
	line-height: 30px;
	background: #00B8F4;
	text-align: center;
	color: #fff;
	text-transform: uppercase;
	padding: 5px 20px;
	font-size: 16px;
	font-weight: bold;
}

.card .news-content .post-meta a {
	text-decoration: none;
	padding-right: 10px;
	color: black;
	font-weight: bold;
}

.card .news-content .post-meta a:hover {
	color: #DF084A;
}

.card .news-content .post-header {
	margin: 0;
	padding: 10px 0;
	color: #007DA6;
	height: 75px;
	font-size: 28px;
	overflow: hidden;
}

.card .news-content p {
	font-size: 16px;
	margin: 10px 0 0;
	padding: 0;
	color: black;
	opacity: 0;
}

.card:hover .news-content p {
	opacity: 1;
}
</style>
</head>
<body>
	<section>
		<div class="container-fluid">
			<div class="container">
			<a href="#">최신순</a>/
			<a href="#">트렌딩</a>/
			<a href="#">구독 TIL</a>
			<br> 
				<div class="row">
				
					<c:forEach var="til" items="${tillist}">
						<div class="col-sm-4">
							<div class="card">
								<div class="post-image">
									<img src="la.jpg" class="img-responsive">
								</div>
								<div class="news-content">
									<span class="category">TIL</span>
									<div class="post-meta">
									<h2 class="post-header">
									<a href="info.dev?bno=${til.bno}&no=${til.no}">${til.title}</a></h2>
										 <span class="time"> 
										<a href="#"> 
										<i class="fa fa-clock-o"></i> 
										<fmt:formatDate var="rdate" value="${til.regdate }" pattern="yyyyMMdd" />
												<c:if test="${today==rdate}">
													<fmt:formatDate value="${til.regdate}" pattern="HH:mm:ss" />
												</c:if> <c:if test="${today != rdate}">
													<fmt:formatDate value="${til.regdate}"
														pattern="yyyy-MM-dd HH:mm" />
												</c:if>
										</a>
										</span> 
										<div class="clearfix"></div>
									</div>
									<span class="author" > <a href="#"> 
									<i class="fa fa-user" ></i> ${til.name}</a></span>
									<span class="comments pull-right"> <a href="#"> 
									<i class="fa fa-commenting-o">좋아요</i>
										</a></span>
									<p>${til.content}</p>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</section>
	
	<script type="text/javascript">
		
	
	
	</script>
	
</body>
</html>
