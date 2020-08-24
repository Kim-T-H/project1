<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#customers {
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
	border-collapse: collapse;
	width: 60%;
	margin: auto;
}

#customers td, #customers th {
	border: 1px solid #ddd;
	padding: 8px;
}

#customers tr:nth-child(even) {
	background-color: #f2f2f2;
}

#customers tr:hover {
	background-color: #ddd;
}

#customers th {
	padding-top: 12px;
	padding-bottom: 12px;
	text-align: left;
	background-color: #4CAF50;
	color: white;
}
</style>
<meta charset="UTF-8">
<title>게시물 상세보기</title>
<style type="text/css">
.leftcol {
	text-align: left;
	vertical-align: top;
}

.lefttoptable {
	height: 250px;
	border-width: 0px;
	text-align: left;
	vertical-align: top;
	padding: 0px;
}

input[type=text]:focus {
	border: 3px solid #555;
}
</style>
</head>
<body>

	<h6>TIL 상세화면</h6>
	
	
	
	
	<table id="customers">
		<tr>
			<td>${til.name}</td>
			<td><c:if test="${today==rdate}">
					<fmt:formatDate value="${til.regdate}"
						pattern="yyyy년 MM월 dd일 HH:mm:ss" />
				</c:if> <c:if test="${today != rdate}">
					<fmt:formatDate value="${til.regdate}" pattern="yyyy년 MM월 dd일" />
				</c:if></td>
		</tr>
		<tr>
			<td><input type="button" value="포토폴리오 보기"></td>
		
			<c:choose>
				<c:when test="${!empty sessionScope.loginUser}">
					<c:if test="${til.name != sessionScope.loginUser.name}">
							<td>
								<input type="button" value="구독 " id=subinsert>
								<input type="button" value="구독 취소 " id=subdelete>
							</td>
						</c:if>	
			<div style="position: fixed; top: 112px;">
					
						<input type="button" value="☆ " id=likeinsert>
						<input type="button" value="★ " id=likedelete>
						<h3>좋아요 수:${count}</h3>
			</div>

				</c:when>
			</c:choose>
		
			


			<c:if test="${til.name == loginUser.name }">
				<td><input type="button" value="게시물 수정"
					onClick="location.href='update.dev?no=${til.no}&bno=${til.bno}'"></td>
				<td><input type="button" value="게시물 삭제"
					onClick="location.href='delete.dev?no=${til.no}&bno=${til.bno}'"></td>
			</c:if>
		</tr>
		<tr>
			<td>해쉬태그 창</td>
		</tr>
		<tr>
			<td>${til.title}</td>
		</tr>


		<tr>
			<td class="leftcol">
				<table class="lefttoptable">
					<tr>
						<td class="leftcol lefttoptable">${til.content}</td>
					</tr>
				</table>
			</td>
		</tr>


	</table>

	<div id="replylist"></div>

	<table border="1" style="width: 100%; margin: auto;">


		<c:if test="${empty sessionScope.login}">
			<br>
			<tr bgcolor="#F5F5F5">
				<!-- 아이디 -->
				<td width="100">${sessionScope.login}아이디</td>
				<!-- 본문 작성 -->
				<td width="400"><textarea name="reply_content" rows="4"
						cols="60" id="reply_content"></textarea></td>
				<td width="100">
					<div style="text-align: center;">
						<button type="button" id="reply_insert"
							class="btn btn-info btn btn-default btn-lg">댓글 게시</button>
					</div>

				</td>

			</tr>
		</c:if>
	</table>


	<input type="hidden" id="per" value="${sub.scrapper}">
	<input type="hidden" id="ped" value="${sub.scrapped}">
	
	
	<input type="hidden" id="likename" value="${gob.name}">
	<input type="hidden" id="likeno" value="${gob.no}">
	<input type="hidden" id="likewno" value="${gob.wno}">
	
	<input type="hidden" id="no" value="${til.no}">
	<input type="hidden" id="bno" value="${til.bno}">
	
	<input type="hidden" name="scrapper" id="scrapper"
		value="${sessionScope.loginUser.name}">
	<input type="hidden" name="scrapped" id="scrapped" value="${til.name}">

<script type="text/javascript">

	$(function() {
		subview()
		likeview()
		
		function subview() {
			
			var chk = false;
			if(($("#per").val()) == ($("#scrapper").val()) && ($("#ped").val()) == ($("#scrapped").val())){
				chk=true;
			}
			
			if(chk){
				$("#subinsert").hide();
				$("#subdelete").show();
			}else{
				$("#subinsert").show();
				$("#subdelete").hide();
			}
		} 
	
	
	
	$(document).on("click", "#subinsert", function () {
		$.ajax({
			type: "post",
			url: '${path}/ajax/subinsert.dev',
			data : {
				name : $("#scrapped").val()
				
			},
			success : function (res) { 
				alert("구독 성공");
				location.reload();
			},
			error: function (e) {
				console.log("e: "+e.status);
			}
		}) 
	})
	
	
	
	$(document).on("click", "#subdelete", function () {
		$.ajax({
			type: "post",
			url: '${path}/ajax/subdelete.dev',
			data : {
				name : $("#scrapped").val()
				 
			},
			success : function (res) {
				alert("구독 취소");
				location.reload();
			},
			error: function (e) {
				console.log("e: "+e.status);
				
			}
		})
	})  
	
	
	//좋아요
	
	function likeview() {
			
			var chk = false;
			if(($("#likename").val()) == ($("#scrapper").val()) && ($("#no").val()) == ($("#likeno").val()) && ($("#bno").val()) == ($("#likewno").val())){
				chk=true;
			}
			
			if(chk){
				$("#likeinsert").hide();
				$("#likedelete").show();
			}else{
				$("#likeinsert").show();
				$("#likedelete").hide();
			}
		}  
	
	
	$(document).on("click", "#likeinsert", function () {
		console.log("click");
		$.ajax({
			type: "post",
			url: '${path}/ajax/likeinsert.dev',
			data : {
				wno: ${til.bno},
				name : $("#scrapper").val()
			},
			success : function (res) { 
				alert("좋아요 성공");
				location.reload();
			},
			error: function (e) {
				console.log("e: "+e.status);
			}
		}) 
	})
	
	
	
	$(document).on("click", "#likedelete", function () {
		$.ajax({
			type: "post",
			url: '${path}/ajax/likedelete.dev',
			data : {
				no :${til.no},
				wno:${til.bno},
				name : $("#scrapper").val()
			},
			success : function (res) {
				alert("좋아요 취소");
				location.reload();
			},
			error: function (e) {
				console.log("e: "+e.status); 
				
			}
		})
	})  
	
	
	
	})



</script>


</body>
</html>