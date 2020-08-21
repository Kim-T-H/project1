<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지보관함</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
	.container {
		margin: 0;
		padding: 30px 20%;
	}
	.content > hr {
		width : 100%;
		border : thin solid #8572EE;
	}
	.container .content .content-header {
		padding-top : 100px;
		padding-bottom : 40px;
	}
	.pagetitle {
		font-weight : bold;
		font-size : 50px;
		color : #8572EE;
	}
	.message-content {
		padding-top : 50px;
	}
	.modal-font {
		font-size : 13px;
		font-weight : bold;
	}
	.col-md-4 {
		text-align : center;
	}
</style>
<script>
	$(function() {
		$(".open-profileInfoModal").on("click",function(){
			var username = $(this).data('name');
			$("#profile-modal-title").text(username);
			$("#openMessageModalATag").attr("data-username",username);
			
			
		})
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
		$(".modal-close").on("click",function(){
			$('#message-title').val("");
			$('#message-text').val("");
		})
		
		$(".open-detailModal").on("click",function(){
			var title = $(this).data('datas').title;
			var me_to = $(this).data('datas').me_to;
			var me_from = $(this).data('datas').me_from;
			var content = $(this).data('datas').content;
			$("#detail-modal-title").text(title);
			if(me_to != null) {
				$("#name").text('받은 사람: ' + me_to);
			} else {
				$("#name").text('보낸 사람: ' + me_from);
			}
			$("#content").text(content);
			
		})
	})
</script>
</head>
<body>
	<div class="container">
		<div class="content">
			<div class="content-header">
				<div class="pagetitle">쪽지 보관함</div>
			</div>
				<hr>
			<div class="content-body">
				<ul class="nav nav-tabs">
				  <li class="nav-item">
				    <a class="nav-link active" data-toggle="tab" href="#receivedMessage">받은 쪽지함</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" data-toggle="tab" href="#sentMessage">보낸 쪽지함</a>
				  </li>
				</ul>
				<div class="tab-content">
				  <div class="tab-pane fade show active" id="receivedMessage">
					<div class="message-content">
					    <table class="table table-hover">
							<thead>
								<tr>
									<th>보낸 사람</th>
									<th>제목</th>
									<th>보낸 시간</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="msglist" items="${msglist}">
									<c:if test="${msglist.me_to.equals(sessionScope.loginUser.name)}">
										<tr>
											<td><a href="#profileInfo" class="open-profileInfoModal" data-toggle="modal" data-name="${msglist.me_from}">${msglist.me_from}</a></td>
											<td><a href="#messageDetail" class="open-detailModal" data-toggle="modal" data-datas='{"title":"${msglist.title}","me_from":"${msglist.me_from}","content":"${msglist.content}"}'>${msglist.title}</a></td>
											<td><fmt:formatDate value="${msglist.regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				  </div>
				  <div class="tab-pane fade" id="sentMessage">
					<div class="message-content">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>받은 사람</th>
									<th>제목</th>
									<th>보낸 시간</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="msglist" items="${msglist}">
									<c:if test="${msglist.me_from.equals(sessionScope.loginUser.name)}">
										<tr>
											<td><a href="#profileInfo" class="open-profileInfoModal" data-toggle="modal" data-name="${msglist.me_to}">${msglist.me_to}</a></td>
											<td><a href="#messageDetail" class="open-detailModal" data-toggle="modal" data-datas='{"title":"${msglist.title}","me_to":"${msglist.me_to}","content":"${msglist.content}"}'>${msglist.title}</a></td>
											<td><fmt:formatDate value="${msglist.regdate}" pattern="yyyy-MM-dd HH:mm"/></td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
				  	</div>
				  </div>
				</div>
			</div>
		</div>
	</div>
	
			<%-- 쪽지 상세정보 모달 --%>
			<div class="modal fade" id="messageDetail" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h4 class="modal-title" id="detail-modal-title"></h4>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        <form>
			          <div class="form-group" id="name">
			            <%--
			            <label for="recipient-name" class="col-form-label">보낸 사람:</label>
			            <input type="text" class="form-control" id="recipient-name" readonly>
			            --%>
			          </div>
			          <hr>
			          <div class="form-group" id="content">
			          	<%--
			            <label for="message-text" class="col-form-label">내용:</label>
			            <textarea class="form-control" id="message-text"></textarea>
			            --%>
			          </div>
			        </form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary modal-close" data-dismiss="modal">닫기</button>
			        <%--<button type="button" class="btn btn-primary" id="sendMessageBtn">답장하기</button>--%>
			      </div>
			    </div>
			  </div>
			</div>
	
			<%-- 프로필모달 --%>
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
					      		<a href="#">
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
	
</body>
</html>