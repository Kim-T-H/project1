<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Register</title>
<style type="text/css">
.container {
}
.container .content {
}
.page-wrap {
	max-width: 100%;
	min-height: 100vh;
	position: relative;
	z-index: 1
}

.pagewrap-overlay {
	position: absolute;
	z-index: -1;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	opacity: 0.8;
}

.contents {
	width: 40%;
	margin: 5vh auto;
	padding: 0;
	border: 2px solid #222;
	border-radius: 15px;
	overflow: hidden;
}
.head {
	background: #fff;
	width: 100%;
	height: 150px;
	text-align: center;
	position: relative;
}

.head:after {
	content: '';
	position: absolute;
	bottom: -17px;
	left: 0;
	width: 100%;
	height: 40px;
	background: #fff;
	z-index: 1;
	transform: skewY(3deg);
}

.head h1 {
	text-transform: uppercase;
	font-size: 30px;
	letter-spacing: 2px;
}

.head-content {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
.title {
	font-weight: 600;
}
.pagewrap .contents section {
	position: relative;
	height: 100%;
}
.pagewrap .contents section form {
	margin: 0 auto;
	max-width: 100%;
	background: #222;
	height: 100%;
	opacity: 0.8;
	box-shadow: 0 19px 39px rgba(0, 0, 0, 0.3), 0 15px 12px
		rgba(0, 0, 0, 0.22);
	padding-top: 60px;
	padding-bottom: 7px;
}
::-webkit-input-placeholder {
	color: #fff;
}

.pagewrap .contents section form select {
	-moz-apperance: none;
	-webkit-apperance: none;
}

.pagewrap .contents section form select::-ms-expand {
	display: none;
}

.pagewrap .contents button {
	background: linear-gradient(to right, #fa1, #fc1);
	width: 30%;
	height: 65px;
	border: none;
	border-radius: 5px;
	margin: 0 auto;
	font-size: 15px;
	color: #fff;
	letter-spacing: 3px;
	display: block;
	text-transform: uppercase;
	font-weight: 900;
	position: relative;
	top: -30px;
	box-shadow: 0 19px 39px rgba(0, 0, 0, 0.3), 0 15px 12px
		rgba(0, 0, 0, 0.22);
	cursor: pointer;
}
.hashtag-container {
  margin: 0;
}
.hashtag {
  display: flex;
  flex-wrap: wrap;
  align-content: flex-start;
  padding: 5px;
  border-bottom: 1px solid #000;
  width: calc(100% - 30px);
}
.hashtag .tag {
  height: 30px;
  margin: 0;
  padding: 0 5px;
  border: 1px solid #fff;
  border-radius: 3px;
  background: #fff;
  display: flex;
  align-items: center;
  color: #333;
  box-shadow: 0 0 4px rgba(0, 0, 0, 0.2), inset 0 1px 1px #fff;
  cursor: pointer;
  font-weight: bold;
  margin-right: 5px;
}
.tag i {
  font-size: 16px;
  color: #666;
  margin-left: 5px;
}
.hashtag input {
  padding: 5px;
  font-size: 16px;
  border: 0;
  outline: none;
  font-family: 'Rubik';
  color: #333;
  flex: 1;
  background: transparent;
}
.pagewrap .contents section .input-layout {
	margin: 0 auto;
	width: 80%;
}
.pagewrap .contents section form .category-input,
.pagewrap .contents section form .process-input,
.pagewrap .contents section form .grade-input {
	display: flex;
	justify-content: space-around;
	align-items: center;
}
.pagewrap .contents section form .category-input input[type="radio"],
.pagewrap .contents section form .process-input input[type="radio"],
.pagewrap .contents section form .grade-input input[type="radio"] {
	display: none;
}
.pagewrap .contents section form .category-input input[type="radio"]:checked + label,
.pagewrap .contents section form .process-input input[type="radio"]:checked + label,
.pagewrap .contents section form .grade-input input[type="radio"]:checked + label {
	border: 1px solid #fff;
}
.pagewrap .contents section form .category-input input[type="radio"]:checked + label:before,
.pagewrap .contents section form .process-input input[type="radio"]:checked + label:before,
.pagewrap .contents section form .grade-input input[type="radio"]:checked + label:before {
	content: "✓";
	line-height: 40px;
	background: #222;
	z-index: 999;
	position: absolute;
	top: -25px;
	font-size: 40px;
	border: 1px solid #fff;
	border-radius: 50%;
	width: 40px;
	left: -15%;
}
.pagewrap .contents section form .category-input label,
.pagewrap .contents section form .process-input label,
.pagewrap .contents section form .grade-input label {
	position: relative;
	color: #fff;
	background-color: transparent;
	font-size: 18px;
	text-align: center;
	display: block;
	cursor: pointer;
	border: 1px solid #555;
	box-sizing: border-box;
	border-radius: 5px;
	padding: 10px;
	margin: 0 auto;	
}
.pagewrap .contents section form .project-input,
.pagewrap .contents section form .name-input,
.pagewrap .contents section form .maxnum-input {
	display: flex;
	width: calc(100% - 23px);
	height: 60px;
	background: transparent;
	border: 1px solid #555;
	border-radius: 5px;
	margin: 0;
	font-size: 20px;
	color: #fff;
	letter-spacing: 2px;
	margin-top: 20px;
	justify-content: flex-start;
	align-items: center;
	padding-left: 20px;
}
.pagewrap .contents section form .project-input input,
.pagewrap .contents section form .name-input input,
.pagewrap .contents section form .maxnum-input input {
	margin-left: 20px;
	border: none;
	color: #fff;
	background: transparent;
	width: 60%;
	height: 40px;
	font-size: 20px;
}
.pagewrap .contents section form .project-input input:focus,
.pagewrap .contents section form .name-input input:focus,
.pagewrap .contents section form .maxnum-input input:focus {
	outline: none;
	border-bottom: 1px solid #fff;
}
.pagewrap .contents section form .row {
	display: flex;
	justify-content: space-around;
	font-size: 18px;
}
.pagewrap .contents section form .row div  {
	width: 40%;
	font-size: 16px;
}
</style>
</head>
<body>
<div class="container">
<div class="content">
	<div class="pagewrap">
		<div class="pagewrap-overlay"></div>
		<div class="contents">
			<div class="head">
				<div class="head-content">
					<h1>
						<span class="title">Co-Working</span>
					</h1>
					<div class="slanted"></div>
				</div>
			</div>
			<section>
				<form:form modelAttribute="coworking" method="post" action="register.dev" name="f">
					<div class="input-layout">
					<div class="category-input">
						<form:radiobutton path="category" value="스터디" label="스터디"/>
						<form:radiobutton path="category" value="공모전" label="공모전"/>
						<form:radiobutton path="category" value="프로젝트" label="프로젝트"/>
					</div>
					<div class="project-input">
					<span>프로젝트 명</span>
						<form:input path="title"/>
					</div>
					<div class="row">
					<div class="name-input">
					<span>작성자</span>
						<form:input path="name"/>
					</div>
					<div class="maxnum-input">
					<span>모집인원</span>
						<form:input path="maxnum"/>
					</div>
					</div>
					<div class="hash-input">
						<div class="hashtag-container"><div class="hashtag"><input/>  
  					</div></div>
					</div>
					<div class="loc-input">
						<form:input path="loc" placeholder="지역"/>
					</div>
					<div class="deadline-input">
						<form:input path="deadline" placeholder="모집 마감일"/>
					</div>
					<div class="startdate-input">
						<form:input path="startdate" placeholder="시작일"/>
					</div>
					&nbsp;~&nbsp;
					<div class="enddate-input">
						<form:input path="enddate" placeholder="마지막일"/>
					</div>
					<div class="process-input">
						<form:radiobutton path="process" value="오프라인" label="오프라인"/>
						<form:radiobutton path="process" value="온라인" label="온라인"/>
					</div>
					<div class="grade-input">
						<form:radiobutton path="grade" value="초급" label="초급"/>
						<form:radiobutton path="grade" value="중급" label="중급"/>
						<form:radiobutton path="grade" value="고급" label="고급"/>
					</div>
					<div class="content-input">
						<form:textarea path="content"/>
					</div>
					</div>
				</form:form>
			</section>
			<button>Register</button>
		</div>
	</div>
	
</div>
</div>
<script type="text/javascript">
$(function() {
	$("input[name='category']").click(function() {
		if($(this).prop('checked')) {
			$("input[name='category']").prop('checked', false);
			$(this).prop('checked', true);
		}
	})
	
	$("input[name='grade']").click(function() {
		if($(this).prop('checked')) {
			$("input[name='grade']").prop('checked', false);
			$(this).prop('checked', true);
		}
	})
	
})
</script> 
<script type="text/javascript">
$(function() {
const tagContainer = document.querySelector('.hashtag');
const input = document.querySelector('.hashtag input');

let tags = [];

function createTag(label) {
  const div = document.createElement('div');
  div.setAttribute('class', 'tag');
  const span = document.createElement('span');
  span.innerHTML = label;
  const closeIcon = document.createElement('i');
  closeIcon.innerHTML = '';
  closeIcon.setAttribute('class', 'fa fa-times');
  closeIcon.setAttribute('data-item', label);
  div.appendChild(span);
  div.appendChild(closeIcon);
  return div;
}

function clearTags() {
  document.querySelectorAll('.tag').forEach(tag => {
    tag.parentElement.removeChild(tag);
  });
}

function addTags() {
  clearTags();
  tags.slice().reverse().forEach(tag => {
    tagContainer.prepend(createTag(tag));
  });
}

input.addEventListener('keyup', (e) => {
    if (e.key === 'Enter') {
	if (tags.length < 5) {
      e.target.value.split(',').forEach(tag => {
        tags.push(tag);  
      });
      
      addTags();
      input.value = '';
      console.log(tags);
	}else {
		alert("기술을 5개까지만 입력이 가능합니다.")
	}
    }
});
document.addEventListener('click', (e) => {
  console.log(e.target.tagName);
  if (e.target.tagName === 'I') {
    const tagLabel = e.target.getAttribute('data-item');
    const index = tags.indexOf(tagLabel);
    tags = [...tags.slice(0, index), ...tags.slice(index+1)];
    addTags();    
  }
})

input.focus();

$("#submit").on("click", function () {
	var hash = {hash : tags};
	console.log(hash);
	
	$.ajax({
		url: '${path}/ajax/hashtag.dev',
		type: "post",
		data: hash,
		traditional: true,
		success: function(response){
		}
	})
	return true;
})
	
})

</script>
</body>
</html>