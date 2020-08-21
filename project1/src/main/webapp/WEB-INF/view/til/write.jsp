<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TIL 작성창</title>
</head>
<body>
<h6>TIL(Today I Learned)</h6> 
<form:form modelAttribute="til" action="write.dev" method="post">
	<table>
	<tr><td><form:input path="title" placeholder="제목을 입력하세요."/></td></tr>
	<tr><td><form:radiobutton path="open" value="0" label="공개(public)"/><br/>
			<form:radiobutton path="open" value="1" label="비공개(private)"/></td></tr>
	<form:hidden path="name" value="${loginUser.name}" size="40%" readonly="true"/>
	
	
	
	<tr><td><form:textarea path="content" rows="15" cols="80" />
	<script>CKEDITOR.replace("content",{filebrowserImageUploadUrl : "imgupload.shop"});</script>
	</td></tr>
	
	<tr><td colspan="2">
		<input type="submit" value="신청">
		<a href="list.dev">게시글 목록</a>
		</td></tr>
	</table>
</form:form>
</body>
</html>