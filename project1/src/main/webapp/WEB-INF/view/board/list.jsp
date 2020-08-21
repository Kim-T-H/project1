<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>게시판 목록</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function listpage(page){
		document.searchform.pageNum.value = page;
		document.searchform.submit();
	}
	// 이하 모달 관련 스크립트
	$(function(){
		$(".open-profileInfoModal").on("click",function(){
			var username = $(this).data('name');
			$("#profile-modal-title").text(username);
			$("#openMessageModalATag").attr("data-username",username);
			$("#openReportModalATag").attr("data-username",username);
			
			
		})
		
		//쪽지 보내는 모달 
		$('#sendMessage').on('show.bs.modal', function (event) {
		  var aTag = $(event.relatedTarget)
		  var recipient = aTag.data('username')
		  var modal = $(this)
		  modal.find('.modal-title').text(recipient + '에게 쪽지보내기')
		  modal.find('#recipient-name').val(recipient)
		})
		$('#sendMessageBtn').on("click",function(){
			$.ajax({
				url : "${path}/ajax/sendMessage.dev",
				type: "post",
				data : {
					me_from : "${sessionScope.loginUser.name}",
					me_to : $('#recipient-name').val(),
					title : $('#message-title').val(),
					content : $('#message-text').val()
				},
				success : function(s) {
					alert(s);
					$('#message-title').val("");
					$('#message-text').val("");
					$('#sendMessage').modal("hide");
					
				},
				error : function(e) {
					alert("오류발생")
				}
			})
		})
		
		//신고하기 모달
		$('#report').on('show.bs.modal', function (event) {
		  var aTag = $(event.relatedTarget)
		  var reportedName = aTag.data('username')
		  var modal = $(this)
		  modal.find('#reported-name').attr("value",reportedName)
		})
		$('#reportBtn').on("click",function(){
			$.ajax({
				url : "${path}/ajax/report.dev",
				type : "post",
				data : {
					content : $('input[name=radiogGroup]:checked').val(),
					reportedName : $('#reported-name').val(),
					no : $('#no').val()
				},
				success : function(s){
					alert(s)
					$('#report').modal('hide');
				},
				error : function(e){
					alert("오류발생")
				}
			})
		})
		
		//종료 버튼
		$(".modal-close").on("click",function(){
			$('#message-title').val("");
			$('#message-text').val("");
		})
	})
</script>
<style>
#customers {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 80%;
  margin: auto;
  
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #4CAF50;
  color: white;
}
/* 모달 관련 스타일 추가했음 */
.modal-font {
	font-size : 13px;
	font-weight : bold;
}
.col-md-4 {
	text-align : center;
}
</style>

</head>
<body>
<br><br><br><br><br><br>
<table id="customers" >
	<tr><td colspan="6" align="center" height="60px">
		<div style="display:inline;">
		<form action="list.dev?no=${no }" method="post" name="searchform" >
			<input type="hidden" name="pageNum" value="1">
			<select name="searchtype" style="width:100px;">
				<option value="">선택하세요</option>
				<option value="subject">제목</option>
				<option value="name">작성자</option>
				<option value="content">내용</option>
			</select>
			<script type="text/javascript">
				searchform.searchtype.value="${param.searchtype}";
			</script>
			<input type="text" name="searchcontent"
				value="${param.searchcontent}" style="width:250px;">
			<input type="submit" value="검색">
			<input type="button" value="전체게시물보기"
				onclick="location.href='list.shop'">
			</form></div></td></tr>			
	<c:if test="${listcount>0}">	<%-- 등록된 게시물이 있음 --%>
		<c:if test="${no } ==4">
		<tr><td colspan="6">QnA 게시판</td>
		</c:if>
		<tr><th width="5%">번호</th><th width="50%;">제목</th><th width="10%">글쓴이</th>
		<th width="5%">추천</th><th width="12%">기술</th><th width="8%">날짜</th></tr>
		<c:forEach var="board" items="${boardlist}">
			<tr><td>${boardno}</td>
				<c:set var="boardno"  value="${boardno-1}"/>
			<td style="text-align: left;">


			
			<a href="detail.dev?bno=${board.bno}&&no=${board.no}">${board.title}</a></td>
			<td>
				<c:if test='${board.name.equals(sessionScope.loginUser.name) || board.name.equals("관리자")}'>
					${board.name}
				</c:if>
				<c:if test='${!board.name.equals(sessionScope.loginUser.name) && !board.name.equals("관리자")}'>
					<a href="#profileInfo" class="open-profileInfoModal" data-toggle="modal" data-name="${board.name}">${board.name}</a>
				</c:if>
			</td>
			<fmt:formatDate var="regdate" value="${board.regdate}" pattern="yyyyMMdd"/>

			<td>추천수</td>
			
			<td>궁금한 기술</td>
			
			<td><c:if test="${today == regdate}">
			<fmt:formatDate value="${board.regdate}" pattern="HH:mm:ss"/>
			</c:if>
			<c:if test="${today != regdate}">
				<fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd HH:mm"/>
			</c:if></td>
						
			</tr>
			</c:forEach>
			<%-- 페이지 출력 부분 --%>
			<tr><td colspan="6">
				<c:if test="${pageNum > 1}">
				<a href="javascript:listpage('${pageNum - 1}')">[이전]</a></c:if>
				<c:if test="${pageNum <= 1}">[이전]</c:if>
			<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${a==pageNum}">[${a}]</c:if>
				<c:if test="${a!=pageNum}">
				<a href="javascript:listpage('${a}')">[${a}]</a></c:if>
			</c:forEach>
			<c:if test="${pageNum < maxpage}">
				<a href="javascript:listpage('${pageNum + 1}')">[다음]</a></c:if>
			<c:if test="${pageNum >= maxpage}">[다음]</c:if>
			</td></tr></c:if>
		<c:if test="${listcount == 0}">
			<tr><td colspan="6">등록된 게시물이 없습니다.</td></tr></c:if>
		<tr><td colspan="6" align="right">
		<a href="write.dev?no=${no }">[글쓰기]</a></td></tr>
</table>

			<%-- 프로필 모달 --%>
			<div class="modal fade" id="profileInfo" data-keyboard="true" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered modal-sm">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h3 class="modal-title" id="profile-modal-title"></h3>
			      </div>
			      <div class="modal-body" id="findid-modalbody">
			      	<div class="container-fluid">
			      		<div class="row">
					      	<div class="col-md-4">
					      		<a href="#">
					      			<span style="color:#5A3FEE"><i class="fa fa-user fa-2x" aria-hidden="true"></i></span><br><span class="modal-font">포트폴리오</span>
					      		</a>
					      	</div>
					      	<div class="col-md-4">
					      		<a href="#sendMessage" data-toggle="modal" id="openMessageModalATag">
					      			<span style="color:green"><i class="fa fa-envelope fa-2x" aria-hidden="true"></i></span><br><span class="modal-font">쪽지보내기</span>
					      		</a>
					      	</div>
					      	<div class="col-md-4">
					      		<a href="#report" data-toggle="modal" id="openReportModalATag">
					      			<span style="color:red"><i class="fa fa-exclamation-circle fa-2x" aria-hidden="true"></i></span><br><span class="modal-font">신고하기</span>
					      		</a>
					      	</div>
				      	</div>
			      	</div>
			      </div>
			    </div>
			  </div>
			</div>
			
			<%-- 쪽지 보내는 모달 --%>
			<div class="modal fade" id="sendMessage" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h3 class="modal-title" id="exampleModalLabel">쪽지 보내기</h3>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        <form>
			          <div class="form-group">
			            <label for="recipient-name" class="col-form-label">받는 사람:</label>
			            <input type="text" class="form-control" id="recipient-name" readonly>
			          </div>
			          <div class="form-group">
			            <label for="message-title" class="col-form-label">제목:</label>
			            <input type="text" class="form-control" id="message-title">
			          </div>
			          <div class="form-group">
			            <label for="message-text" class="col-form-label">내용:</label>
			            <textarea class="form-control" id="message-text"></textarea>
			          </div>
			        </form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary modal-close" data-dismiss="modal">닫기</button>
			        <button type="button" class="btn btn-success" id="sendMessageBtn">발송하기</button>
			      </div>
			    </div>
			  </div>
			</div>
			
			<%-- 신고하기 모달 --%>
			<div class="modal fade" id="report" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h3 class="modal-title" id="exampleModalLabel">신고하기</h3>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        허위 신고일 경우, 신고자의 서비스 활동이 제한될 수 있으니 신중하게 신고해주세요 <br><br>
			        <input type="hidden" value="5" id="no">
			        <input type="hidden" id="reported-name">
			        <input type="radio" name="radiogGroup" value="광고/음란성 댓글" checked>&nbsp;&nbsp;광고/음란성 댓글<br>
			        <input type="radio" name="radiogGroup" value="욕설/반말/부적절한 언어">&nbsp;&nbsp;욕설/반말/부적절한 언어<br>
			        <input type="radio" name="radiogGroup" value="회원 분란 유도">&nbsp;&nbsp;회원 분란 유도<br>
			        <input type="radio" name="radiogGroup" value="회원 비방">&nbsp;&nbsp;회원 비방<br>
			        <input type="radio" name="radiogGroup" value="지나친 정치/종교 논쟁">&nbsp;&nbsp;지나친 정치/종교 논쟁<br>
			        <input type="radio" name="radiogGroup" value="도배성 댓글">&nbsp;&nbsp;도배성 댓글
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary modal-close" data-dismiss="modal">닫기</button>
			        <button type="button" class="btn btn-warning" id="reportBtn">신고하기</button>
			      </div>
			    </div>
			  </div>
			</div>

</body>
</html>