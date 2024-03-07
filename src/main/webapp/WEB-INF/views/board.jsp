<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<c:set var="loginOutLink" value="${sessionScope.id==null? '/login/login':'login/logout'}"/>
<c:set var="loginOut" value="${sessionScope.id==null? 'login':'logout'}"/>
<c:set var="writer" value="${sessionScope.id}"/>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
	<title>Home</title>
</head>
<body>
<script>
	let msg = "${msg}"
	if(msg === "Del_error") alert("삭제에 실패했습니다.");
	if(msg === "Mod_error") alert("수정에 실패했습니다.");
</script>
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">Navbar</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item">
						<a class="nav-link active" aria-current="page" href="<c:url value='/'/>">Home</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<c:url value='/board/list'/>">Board</a>
					</li>
					<li class="nav-item dropdown">
						<a class="nav-link" href="<c:url value='${loginOutLink}'/>" role="button">
							${loginOut}
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<c:url value='/register/add'/>" role="button">
							Register
						</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>

	<main class="container-sm w-50" style="padding-top: 30px; padding-bottom: 30px">
		<div class="card">
			<div class="card-body">
				<p id="head" class="fs-1 text-center">게시판 ${mode=="new"? "쓰기" : "읽기"}</p>
				<form id="form">
					<div class="mb-3">
						<label for="FormControlInput0" class="form-label"></label>
						<input type="hidden" class="form-control" name="bno" id="FormControlInput0" value="${boardDto.bno}">
					</div>
					<div class="mb-3">
						<label for="FormControlInput1" class="form-label">Title</label>
						<input type="text" class="form-control" name="title" placeholder="제목을 입력해주세요." id="FormControlInput1" value="${boardDto.title}" ${mode=="new"? '':'readonly'}>
					</div>

					<div class="mb-3">
						<label for="FormControlTextarea1" class="form-label">Content</label>
						<textarea class="form-control form-text" placeholder="내용을 입력해주세요." name="content" id="FormControlTextarea1" rows="10" ${mode=="new"? '':'readonly'}>${boardDto.content}</textarea>
					</div>
					<div class="mb-3">
						<label for="FormControlInput2" class="col-form-label">Writer</label>
						<input type="text" class="form-control" name="writer" id="FormControlInput2" value="${writer}" readonly>
					</div>

					<div style="float:right">
						<button id="writeBtn" class="btn btn-secondary btn-sm" type="button"  style="display: ${mode=="new"?'none':''}">글쓰기</button>
						<button id="commentBtn" class="btn btn-secondary btn-sm" type="button"  style="display: ${mode=="new"?'none':''}">댓글쓰기</button>
						<button id="writeNewBtn" class="btn btn-secondary btn-sm" type="button" style="display:${mode=='new'? '':'none'};">등록</button>
						<button id="modifyBtn" class="btn btn-secondary btn-sm" type="button" style="display: ${mode=="new"?'none':''}">수정</button>
						<button id="listBtn" class="btn btn-secondary btn-sm" type="button">목록</button>
						<button id="backBtn" class="btn btn-secondary btn-sm" type="button" style="display: none">취소</button>
						<button id="deleteBtn" class="btn btn-secondary btn-sm" type="button" style="display: ${mode=="new"?'none':''}">삭제</button>
					</div>
				</form>
			</div>
		</div>
	</main>
	<footer class="container-sm w-50" style="padding-top: 30px; padding-bottom: 30px">


		<div id="replyForm" style="display:none;">
			<input type="text" name="replyComment">
			<button id="wrtRepBtn" >등록</button>
		</div>
		<div class="card">
			<div class="card-body">
				<div class="mb-3">
					<label for="commentInput" class="col-form-label">Comment</label>
					<input type="text" class="form-control" id="commentInput" name="comment">
				</div>
				<button id="sendCommentBtn" class="btn btn-secondary btn-sm" type="button">댓글등록</button>
				<button id="modCommentBtn" class="btn btn-secondary btn-sm" type="button" style="display: none">댓글수정</button>
				<div id="commentList" class="table table-striped"></div>
			</div>
		</div>
	</footer>
	<script>
		let bno = $("input[name=bno]").val();

		let toHTML = function(comments) {
			let tmp = ""

			comments.forEach(function(comment) {
				let data = new Date(comment.up_date);

				const year = data.getFullYear();
				const month = data.getMonth();
				const day = data.getDate();

				tmp += "<div class='border' data-cno=" + comment.cno + ' data-pcno=' + comment.pcno + ' data-bno=' + comment.bno + ">"
				if(comment.cno != comment.pcno)
					tmp += '<p class="text-bg-primary text-center">----답글----</p>'

				tmp += "<div class='mb-3'>"
				tmp += '<label class="form-label">Commenter' + '</label><br>'
				tmp += '<input type="text" class="form-control-sm" value="' +comment.commenter + '" readonly/><br>'

				tmp += '<label class="form-label">Comment' + '</label><br>'
				tmp += '<input type="text" class="form-control mb-3" name="innerComment" value="' +comment.comment + '"readonly/>'

				tmp += '<label class="form-label">Date' + '</label><br>'
				tmp += '<input type="text" class="form-control-sm" value="' + year+'.'+month+'.'+day + '"readonly/></div>'
				if(comment.cno != comment.pcno)
					tmp += '<p class="text-bg-primary text-center">-----------</p>'
				tmp += ' <button class="delBtn btn btn-secondary btn-sm">삭제</button>'
				tmp += ' <button class="modBtn btn btn-secondary btn-sm">수정</button>'
				tmp += ' <button class="replyBtn btn btn-secondary btn-sm">답글</button>'
				tmp += '</div>'


			})

			return tmp;
		}

		let showList = function(bno) {
			$.ajax({
				type: 'GET',       // 요청 메서드
				url: '/web/comments?bno='+bno,  // 요청 URI
				success: function (result) {
					$("#commentList").html(toHTML(result));
				},
				error: function () {
					alert("error")
				} // 에러가 발생했을 때, 호출될 함수
			}); // $.ajax()

		}


		$(document).ready(function(){
			showList(bno);
			$("#sendCommentBtn").click(function () {
				let comment = $("input[name=comment]").val();

				if(comment.trim() == '') {
					alert("댓글을 입력해주세요.");
					$("input[name=comment]").focus();
					return;
				}
				$.ajax({
					type:'POST',       // 요청 메서드
					url: '/web/comments?bno='+bno,  // 요청 URI
					headers : { "content-type": "application/json"}, // 요청 헤더
					data : JSON.stringify({bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
					success : function(result){
						alert(result);       // result는 서버가 전송한 데이터
						showList(bno);
					},
					error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
				}); // $.ajax()
			});

			$("#commentList").on("click", ".delBtn", function () {
				let cno = $(this).parent().attr("data-cno");
				if(!confirm("정말로 삭제하시겠습니까?")) return;
				$.ajax({
					type:'DELETE',       // 요청 메서드
					url: '/web/comments/'+cno+'?bno='+bno,  // 요청 URI
					success : function(result){
						alert(result);       // result는 서버가 전송한 데이터
						showList(bno);
						alert("삭제에 성공했습니다.")
					},
					error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
				}); // $.ajax()
			});

			$("#commentList").on("click", ".replyBtn", function () {
				$("#replyForm").appendTo($(this).parent());
				$("#replyForm").css("display","block");
			});

			$("#wrtRepBtn").on("click", function() {
				let comment = $("input[name=replyComment]").val();
				let pcno = $("#replyForm").parent().attr("data-pcno");

				if(comment.trim() == '') {
					alert("댓글을 입력해주세요.");
					$("input[name=replyComment]").focus();
					return;
				}
				$.ajax({
					type:'POST',       // 요청 메서드
					url: '/web/comments?bno='+bno,  // 요청 URI
					headers : { "content-type": "application/json"}, // 요청 헤더
					data : JSON.stringify({pcno:pcno, bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
					success : function(result){
						alert(result);       // result는 서버가 전송한 데이터
						showList(bno);
					},
					error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
				}); // $.ajax()

				$("#replyForm").css("display","none");
				$("input[name=replyComment]").val('');
				$("#replyForm").appendTo("body");
			})

			$("#commentList").on("click", ".modBtn", function () {
				let comment = $("input[name=innerComment]").val();
				let cno = $(this).parent().attr("data-cno");

				$("input[name=comment]").val(comment);
				$("#modCommentBtn").attr("data-cno", cno);
				$("#modCommentBtn").css("display", "");
			});

			$("#modCommentBtn").on("click", function () {
				let comment = $("input[name=comment]").val();
				let cno = $(this).attr("data-cno");

				if(comment.trim() == '') {
					alert("내용을 입력해주세요.");
					$("input[name=comment]").focus();
					return;
				}

				$.ajax({
					type:'PATCH',       // 요청 메서드
					url: '/web/comments/' + cno + '?bno='+bno,  // 요청 URI
					headers : { "content-type": "application/json"}, // 요청 헤더
					data : JSON.stringify({cno:cno, bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
					success : function(result){
						alert(result);       // result는 서버가 전송한 데이터
						showList(bno);
					},
					error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
				}); // $.ajax()
				$("input[name=comment]").val('');
			});
		});


		let listBtn = document.querySelector("#listBtn");
		let deleteBtn = document.querySelector("#deleteBtn")
		let writeBtn = document.querySelector("#writeBtn");
		let writeNewBtn = document.querySelector("#writeNewBtn");
		let modifyBtn = document.querySelector("#modifyBtn");
		let backBtn = document.querySelector("#backBtn");

		let formCheck = function() {
			let form = document.querySelector("#form");

			if(form.title.value=="") {
				alert("제목을 입력해주세요.")
				form.title.focus();
				return false;
			}

			if(form.content.value=="") {
				alert("내용을 입력해주세요.")
				form.content.focus();
				return false;
			}
			return true;
		}

		listBtn.addEventListener("click", function() {
			window.location.href="<c:url value='/board/list${sc.queryString}'/>";
		})

		deleteBtn.addEventListener("click", function() {
			let form = document.querySelector("#form");
			if(!confirm("정말로 삭제하시겠습니까?")) return;

			form.action = "<c:url value='/board/remove${sc.queryString}'/>";
			form.method="post"


			form.submit();

		})

		writeBtn.addEventListener("click", function() {
			window.location.href="<c:url value='/board/write'/>";
		})

		writeNewBtn.addEventListener("click", function() {
			let form = document.querySelector("#form");

			form.action = "<c:url value='/board/write'/>";
			form.method= "post";


			if(formCheck()) {
				form.submit();
			}
		})

		modifyBtn.addEventListener("click", function() {
			let form = document.querySelector("#form");
			let inputTitle = document.querySelector("#FormControlInput1");
			let inputContent = document.querySelector("#FormControlTextarea1")

			if(inputTitle.readOnly){
				inputTitle.readOnly = false;
				inputContent.readOnly = false;

				document.querySelector("#modifyBtn").innerText = "등록"
				document.querySelector("#head").innerText = "게시판 수정"
				document.querySelector("#writeBtn").style.display = "none";
				document.querySelector("#deleteBtn").style.display = "none";
				backBtn.style.display = "";
				return;
			}

			form.action = "<c:url value='/board/modify${sc.queryString}'/>";
			form.method = "post";

			if(formCheck()) {
				form.submit();
			}
		})
		backBtn.addEventListener("click", function() {
			if(!confirm("수정한 내용이 삭제됩니다. 정말로 취소하시겠습니까?")) return;
			alert("게시글 수정이 취소되었습니다.");
			window.location.href= "<c:url value='/board/read${sc.queryString}&bno=${boardDto.bno}'/>"
		})
	</script>
</body>
</html>
