<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<script>
var bno = '${board.bno}'; //게시글 번호
var no='${board.no}'

	

$('[name=commentInsertBtn]').click(function(){ //댓글 등록 버튼 클릭시 
    var insertData = $('form[name=commentInsertForm]').serialize(); //commentInsertForm의 내용을 가져옴
    commentInsert(insertData); //Insert 함수호출(아래)
});
 
 
 
//댓글 목록 
function commentList(){
    $.ajax({
        url : '${path}/ajax/commentList.dev',
        type : 'get',
        data : {'bno':bno ,'no':no },
        success : function(response){
        	var data = JSON.parse(response);
            var a =''; 
            $.each(data, function(key, value){ 
                a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-left: 400px; margin-right: 400px;">';
                a += '<div class="commentInfo'+value.rno+'">'+'댓글번호 : '+value.rno+' / 작성자 : '+value.name;
                a += '<a onclick="commentUpdate('+value.rno+',\''+value.content+'\');"> 수정 </a>';
                a += '<a onclick="commentDelete('+value.rno+');"> 삭제 </a> </div>';
                a += '<div class="commentContent'+value.rno+'"> <p> 내용 : '+value.content +'</p>';
                a += '</div></div>';
            });
            
            $(".commentList").html(a);
        }
    });
}
 
//댓글 등록
function commentInsert(insertData){
	console.log(insertData);
    $.ajax({
        url : '${path}/ajax/commentinsert.dev',
        type : 'post',
        data : insertData,
        success : function(data){
        	alert("AJAX 성공");
            
                commentList(); //댓글 작성 후 댓글 목록 reload
                $('[name=content]').val('');
            
        }
    });
}
 
//댓글 수정 - 댓글 내용 출력을 input 폼으로 변경 
function commentUpdate(cno, content){
    var a ='';
    
    a += '<div class="input-group">';
    a += '<input type="text" class="form-control" name="content_'+cno+'" value="'+content+'"/>';
    a += '<span class="input-group-btn"><button class="btn btn-default" type="button" onclick="commentUpdateProc('+cno+');">수정</button> </span>';
    a += '</div>';
    
    $('.commentContent'+cno).html(a);
    
}
 
//댓글 수정
function commentUpdateProc(cno){
    var updateContent = $('[name=content_'+cno+']').val();
    
    $.ajax({
        url : '/comment/update',
        type : 'post',
        data : {'content' : updateContent, 'cno' : cno},
        success : function(data){
            if(data == 1) commentList(bno); //댓글 수정후 목록 출력 
        }
    });
}
 
//댓글 삭제 
function commentDelete(cno){
    $.ajax({
        url : '/comment/delete/'+cno,
        type : 'post',
        success : function(data){
            if(data == 1) commentList(bno); //댓글 삭제후 목록 출력 
        }
    });
}
 
 
 
 
$(document).ready(function(){
    commentList(); //페이지 로딩시 댓글 목록 출력 
});
 
 
 
</script>


