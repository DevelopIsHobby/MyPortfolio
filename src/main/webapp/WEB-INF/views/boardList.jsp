<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<c:set var="loginOutLink" value="${sessionScope.id==null? '/login/login':'login/logout'}"/>
<c:set var="loginOut" value="${sessionScope.id==null? 'login':'logout'}"/>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

	<title>Home</title>
</head>
<body>
<script>
	let msg = "${msg}"
	if(msg === "Del_ok") alert("삭제에 성공했습니다.");
	if(msg === "Mod_ok") alert("수정에 성공했습니다.");
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
					<a class="nav-link" href="${loginOutLink}" role="button">
						${loginOut}
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="<c:url value='/register/add'/>" role="button">
						Register
					</a>
				</li>
			</ul>
			<form class="d-flex" role="search">
				<input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-success" type="submit">Search</button>
			</form>
		</div>
	</div>
</nav>
<main style="text-align: center">
		<div class="container-sm w-50" style="padding-top: 50px;">
			<table class="table">
				<p class="fs-1 text-center">게시판 목록</p>
				<thead>
				<tr class="table-warning">
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">등록일</th>
					<th scope="col">조회수</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="boardDto" items="${list}">
				<tr>
					<th scope="row">${boardDto.bno}</th>
					<td><a href="<c:url value='/board/read?bno=${boardDto.bno}&page=${page}&pageSize=${pageSize}'/>" class="link-warning link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">${boardDto.title}</a></td>
					<td>${boardDto.writer}</td>
					<td>${boardDto.reg_date}</td>
					<td>${boardDto.view_cnt}</td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
			<button id="writeBtn" style="float:right" class="btn btn-secondary btn-sm" type="button">글쓰기</button>
			<nav aria-label="Page navigation" style="padding-top : 20px;">
				<ul class="pagination justify-content-center">
					<c:if test="${ph.showPrev}">
						<li class="page-item">
							<a class="page-link text-warning" href="<c:url value='/board/list?page=${ph.beginPage-1}'/>" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
					</c:if>

					<c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
						<li class="page-item"><a class="page-link text-warning" href="<c:url value='/board/list?page=${i}'/>">${i}</a></li>
					</c:forEach>

					<c:if test="${ph.showNext}">
						<li class="page-item">
							<a class="page-link text-warning" href="<c:url value='/board/list?page=${ph.endPage+1}'/>" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</c:if>
				</ul>
			</nav>
		</div>
</main>
<script>
	let writeBtn = document.querySelector("#writeBtn");
	writeBtn.addEventListener("click", function() {
		window.location.href="<c:url value='/board/write'/>";
	})
</script>
</body>
</html>
