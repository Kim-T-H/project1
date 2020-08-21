<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Co-Working</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Roboto+Condensed&display=swap')
	;

.card {
	position: relative;
	width: 250px;
	height: 250px;
	overflow: hidden;
	box-shadow: 0 5px 10px rgba(0, 0, 0, .1);
	font-family: 'Roboto Condensed', sans-serif !important;
}

.card .post-image {
	height: 155px;
	overflow: hidden;
}

.card .post-image img {
	transition: .5s;
	height: 100%;
	width: 100%;
}

.card:hover .post-image img {
	transform: scale(1.1) translateY(-50px);
}

.card .news-content {
	position: absolute;
	bottom: -150px;
	padding: 10px 20px 60px;
	background: #fff;
	transition: .5s;
	border-top: 2px solid #000;
	width: 250px;
}

.card:hover .news-content {
	bottom: -50px;
}

.card .category {
	position: absolute;
	top: -30px;
	left: 0;
	height: 30px;
	line-height: 20px;
	background: #00B8F4;
	text-align: center;
	color: #fff;
	text-transform: uppercase;
	padding: 5px 20px;
	font-size: 16px;
	font-weight: bold;
	transition: .5s;
}

.card .news-content .post-meta {
	font-size: 12px;
}

.card .news-content .post-meta .author a {
	text-decoration: none;
	padding-right: 10px;
	color: black;
	font-weight: bold;
	transition: .5s;
}

.card .news-content .post-meta .time {
	padding-right: 10px;
	color: black;
	font-weight: bold;
	transition: .5s;
}

.card .news-content .post-meta .author a:hover {
	color: #DF084A;
}

.card .news-content .post-header {
	margin: 0;
	padding: 10px 0;
	color: #007DA6;
	height: 50px;
	font-size: 18px;
	overflow: hidden;
	font-weight: bold;
}

.card .news-content .hashlist {
	font-size: 16px;
	margin: 0 0 10px;
	padding: 0;
	color: black;
	transition: .5s;
	opacity: 0;
	height: 70px;
	display: flex;
	flex-wrap: wrap;
	justify-content: flex-start;
}

.card:hover .news-content .hashlist {
	opacity: 1;
}

.card:hover .news-content .hashlist a:hover {
	color: #DF084A;
	cursor: pointer;
}

.container {
	margin: 0;
	padding: 0;
	max-width: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
}

.container .content {
	display: flex;
	justify-content: flex-start;
	align-items: center;
	max-width: 1300px;
	flex-flow: row wrap;
	width: 100%;
}

.container .content .container-fluid {
	padding: 30px 15px;
	margin: 0 22.5px;
	width: auto;
}

.container .searchArea {
	width: 100%;
	margin-top: 10%;
	display: flex;
	justify-content: space-around;
	align-items: center;
	padding: 0 15%;
}

.container .searchArea .filter {
	float: left;
	padding: 0;
	font-size: 18px;
	font-weight: bold;
}

.container .searchArea .filter a {
	text-decoration: none;
	color: #000;
}

.container .searchArea .plus {
	float: right;
	padding: 0;
}

.container .searchArea .plus .box {
	box-shadow: 0 1px 3px rgba(0, 0, 0, .2);
	border: 2px solid lightblue;
	background: #CCE1FF;
	border-radius: 5px;
	padding: 3px 5px;
}

.container .searchbox {
	padding: 0;
}

.container .searchbox input {
	position: relative;
	display: inline-block;
	font-size: 20px;
	box-sizing: border-box;
}

.container .searchbox input[type="text"] {
	background: #fff;
	width: 220px;
	height: 31px;
	border: 1px solid #000;
	outline: none;
	padding: 0 0 0 20px;
	border-radius: 20px 0 0 20px;
	font-family: Poppins;
}

.container .searchbox select {
	position: relative;
	left: -7px;
	border: 1px solid #000;
	top: -1px;
	outline: none;
	background: #fff;
	font-size: 18px;
	padding: 0 10px;
	height: 31px;
}

.container .searchbox button {
	position: relative;
	left: -5px;
	width: 90px;
	outline: none;
	cursor: pointer;
	background: #FF5757;
	color: #fff;
	top: -2px;
	font-size: 20px;
	border-radius: 10px;
	border: 2px solid pink;
	line-height: 30px;
}

.container .searchbox button:hover {
	background: #ef296c;
}

.container .buttonbox {
	position: relative;
	margin: 0;
	padding: 0;
}

.checkbox-btn {
	position: absolute;
	transform: translate(-50%, -50%);
	width: 100px;
	height: 30px;
}

.checkbox-btn input {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: block;
	cursor: pointer;
	opacity: 0;
	z-index: 1;
}

.checkbox-btn div {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	border: 2px solid #000;
	border-radius: 4px;
	/* box-shadow: 0 10px 20px rgba(0,0,0,0.5); */
	overflow: hidden;
}

.checkbox-btn div .slide {
	position: absolute;
	top: 0;
	left: 0;
	width: 10px;
	height: 30px;
	background: #000;
	transition: 0.5s;
}

.checkbox-btn input:checked+div .slide {
	transform: translateX(90px);
}

.checkbox-btn .slide:before {
	content: '마감순';
	position: absolute;
	top: -3px;
	left: -90px;
	text-align: center;
	width: 90px;
	height: 100%;
	background: #00da00;
	line-height: 30px;
	font-weight: bold;
	color: #fff;
}

.checkbox-btn .slide:after {
	content: '최신순';
	position: absolute;
	top: -3px;
	right: -90px;
	text-align: center;
	width: 90px;
	height: 100%;
	background: #A49CD9;
	line-height: 30px;
	font-weight: bold;
	color: #fff;
}
</style>
</head>
<body>
	<div class="container">
		<div class="searchArea">
			<div class="filter">
				<span><a href="#">전체</a>&nbsp;/</span> <span><a href="#">스터디</a>&nbsp;/</span>
				<span><a href="#">프로젝트</a>&nbsp;/</span> <span><a href="#">공모전</a></span>
			</div>
			<div class="buttonbox">
				<div class="checkbox-btn">
					<input type="checkbox" name="">
					<div>
						<span class="slide"></span>
					</div>
				</div>
			</div>
			<div class="searchbox">
				<input type="text" placeholder="Type...." id="searchinput">
				<select id="searchtype">
					<option value="title">제목</option>
					<option value="hashname">해시태그</option>
				</select>
				<button type="button" id="search">Search</button>
			</div>
			<div class="plus">
				<div class="box">
					<a href="register.dev">등록</a>
				</div>
			</div>
		</div>
		<div class="content">
			<c:forEach var="data" items="${list }">
				<div class="container-fluid">
					<div class="container">
						<div class="row">
							<div class="col-sm-4">
								<div class="card">
									<div class="post-image">
										<img src="${path}/img/raspberry.jpg" class="img-responsive">
									</div>
									<div class="news-content">
										<span class="category">${data.category == "스터디"? "Study": data.category == "프로젝트"? "Project" : "Contest" }</span>
										<div class="post-meta">
											<span class="author"> <a href="#"> <i
													class="fa fa-user"></i> ${data.name }
											</a></span> <span class="time"> <i class="fa fa-clock-o"></i> <fmt:formatDate
													value="${data.deadline}" pattern="yyyy-MM-dd" />

											</span>
											<div class="clearfix"></div>
										</div>
										<h2 class="post-header">
											<a href="${path}/coworking/details.dev?gno=${data.gno}">${data.title }
											</a>
										</h2>
										<div class="hashlist">
											<c:forEach var="hash" items="${data.hashlist }">
												<a><span>#${hash }</span></a>&nbsp;
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<script type="text/javascript">
		$(function() {
			var category = 0;
			
			$(".container .searchArea .filter span a").on("click", function () {
				category = $(this).parent().index();
				console.log($(this).parent().index());
				datasearch(input, type, sort, category);
			})
			
			var button = false;
			var sort = "regdate";
			var input = $("#searchinput").val();
			var type = $("#searchtype").val();
			$(".checkbox-btn input").on("click", function() {
				button = !button;
				if(button) {
					sort = "deadline";
				}else {
					sort = "regdate";
				}
				datasearch(input, type, sort, category);
			})
			
			
			
			var content = $(".content");
			$("#search").on("click", function() {
				console.log($("#searchinput").val());
				console.log($("#searchtype").val());
				input = $("#searchinput").val();
				type = $("#searchtype").val();
				datasearch(input, type, sort, category);
			})

			function datasearch(a, b, c, d) {
				var data = {
					searchinput : a,
					searchtype : b,
					searchsort : c,
					category: d
				}
				$.ajax({
					url : '${path}/ajax/searchworking.dev',
					type : "post",
					data : data,
					success : function(response) {
						var res = JSON.parse(response);
						viewContent(res);
					}
				})
			}

			function viewContent(data) {
				content.html("");
				var data_card = "";
				$
						.each(
								data,
								function(i, v) {
									console.log(v);
									data_card += '<div class="container-fluid"><div class="container"><div class="row"><div class="col-sm-4">'
									data_card += '<div class="card"><div class="post-image"><img src="${path}/img/raspberry.jpg" class="img-responsive">'
									data_card += '</div><div class="news-content"><span class="category">'
									data_card += v.category == "스터디" ? "Study"
											: v.category == "프로젝트" ? "Project"
													: "Contest"
									data_card += '</span><div class="post-meta"><span class="author"> <a href="#"> <i class="fa fa-user"></i> '
									data_card += v.name
									data_card += '</a></span> <span class="time"> <i class="fa fa-clock-o"></i> '
									data_card += v.deadline
									data_card += '</span><div class="clearfix"></div></div><h2 class="post-header"><a href="${path}/coworking/details.dev?gno='
									data_card += v.gno
									data_card += '">' + v.title
									data_card += '</a></h2><div class="hashlist">'
									for (var i = 0; i < v.hashlist.length; i++) {
										data_card += '<a><span>#'
												+ v.hashlist[i] + '</span></a>&nbsp;'
									}
									data_card += '</div></div></div></div></div></div></div>'
									content.append(data_card);
									data_card = ""
								})
			}

			$(document).on("click", ".hashlist a", function() {
				console.log($(this).children().text().substring(1));
				datasearch($(this).children().text().substring(1), "hashname", sort, category);
				type = "hashname";
				input = $(this).children().text().substring(1);
			})
		})
	</script>
</body>
</html>