<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="subuser.dev" method="post">
		<table>
			<tr>
				<td colspan="7">회원목록</td>
			</tr>
			<tr>
				<th>아이디</th>
				<th>닉네임</th>
				<th>이메일</th>
				<td>구독 여부</td>
			</tr>


			<c:forEach items="${list}" var="list">
				<c:forEach items="${subuser}" var="subuser">
				<c:if test="${subuser.scrapper == sessionScope.loginUser.name}">
					<c:if test="${subuser.scrapped == list.name}">
						<tr>
							<td>${list.id}</td>
							<td>${list.name}</td>
							<td>${list.email}</td>
							<td><button type="button" id=subdelete class="btn btn-warning btn-sm">구독
									취소</button></td>
						</tr>
					</c:if>
					</c:if>
					<input type="hidden" name="scrapped" id="scrapped" value="${list.name}">
				</c:forEach>
			</c:forEach>


		</table>
	</form>
	
	
	<script type="text/javascript">
	$(function() {
		
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
		
		})
	
	</script>

</body>
</html>