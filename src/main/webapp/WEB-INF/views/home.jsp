<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<c:set var="loginOutLink" value="${sessionScope.id==null? '/login/login':'login/logout'}"/>
<c:set var="loginOut" value="${sessionScope.id==null? 'login':'logout'}"/>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

	<title>Home</title>
</head>
<body>
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
<main style="text-align: center">
	<h1>This is Home</h1>
	<h1>This is Home</h1>
	<h1>This is Home</h1>
</main>
</body>
</html>
