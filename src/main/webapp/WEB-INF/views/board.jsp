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
	<script>
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
