<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<body>
<table>
	<tr><td>${cwk.title}</td></tr>
	<tr><td>${cwk.name}</td></tr>
	<tr><td>${cwk.deadline}</td></tr>
	<tr><td>${cwk.grade}</td></tr>
	<tr><td>${cwk.maxnum}</td></tr>
	<tr><td>${cwk.category}</td></tr>
	<tr><td>${cwk.content}</td></tr>
	<tr><td>
	<input type="button" value="신청" onclick="document.getElementById('join').style.display='block'" style="text-align: center; margin-bottom: 3px;"><br>
<!-- Modal -->
<div id="join" class="w3-modal">
   <div class="w3-modal-content w3-card-4 w3-animate-zoom w3-round-large" style="max-width:600px">	
   <div class="w3-container w3-border-top w3-padding-16 w3-light-grey w3-center w3-round-large">
    	<h2>프로젝트 지원</h2>
	</div>
    <div class="w3-container w3-border-top w3-padding-16 w3-white w3-center">
    	<form action="details.dev" method="post" >
    	<input type="hidden" value="${loginUser.name}" name="name">
    	<input type="hidden" value="${param.gno}" name="gno">
	<table>
		<caption>${cwk.title}</caption>
		<tr><td>회원정보</td><td colspan="3" class="w3-left">${loginUser.name}</td></tr>
		<tr><td>이메일</td><td><input type="text" value="${loginUser.email}"></td>
			<td>전화번호</td><td><input type="text" value="${loginUser.phone}"></td></tr>
		<tr><td>주언어</td><td><input type="text" name="lang"></td></tr>
		<tr><td>남기는 말</td><td><textarea name="comment" style="width:300px; height:200px;"></textarea></td></tr>
	</table>
	<div class="w3-container w3-border-top w3-padding-16 w3-white w3-center">
		<input type="submit" value="신청" class="w3-btn w3-black w3-round-xxlarge">
		<span onclick="document.getElementById('join').style.display='none'" class="w3-button">취소</span>
	</div>
	</form>
	</div>
  </div>
</div>
<script>
var modal = document.getElementById('join');
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}
</script>
	</td></tr>
</table>
</body>
</html>