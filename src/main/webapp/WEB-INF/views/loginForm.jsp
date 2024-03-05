<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>content</title>
    <style>
        #container {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            margin: auto;
        }
    </style>
</head>
<body>
<div id="container">
    <div class="card" style="width: 30rem; margin :0 auto;">
        <div class="card-header text-center">
            <h2 class="card-title">Login Form</h2>
        </div>
        <div class="card-body">
            <div id="msg" class="msg">
                <c:if test="${not empty msg}">
                    <div class="alert alert-danger" role="alert">${URLDecoder.decode(msg, "utf-8")}</div>
                </c:if>
            </div>
            <form class="form" action="<c:url value='/login/login'/>" method="post">
                <div class="mb-3">
                    <label for="InputId" class="form-label">ID</label>
                    <input type="text" name="id" class="form-control" value="${cookie.id.value}" id="InputId" placeholder="8~12자리의 영대소문자와 숫자 조합">
                </div>
                <div class="form-check" style="float:right">
                    <input class="form-check-input" type="checkbox" id="flexCheckChecked" name="rememberId" ${empty cookie.id.value? "":"checked"}>
                    <label class="form-check-label" for="flexCheckChecked">
                        아이디 기억
                    </label>
                </div>
                <br>
                <div class="mb-3">
                    <label for="InputPassword" class="form-label">Password</label>
                    <input type="password" name="pwd" class="form-control" id="InputPassword" placeholder="8~12자리의 영대소문자와 숫자 조합">
                </div>
                <div class="mb-3">
                    <input type="hidden" name="toURL" value="${param.toURL}" class="form-control" id="toURL">
                </div>


                <a href="" class="btn btn-outline-secondary btn-sm">비밀번호 찾기</a>
                <a href="<c:url value='/register/add'/>" class="btn btn-outline-secondary btn-sm">회원가입</a>

                <button type="submit" class="btn btn-primary" style="float: right;" >Submit</button>
            </form>
        </div>
    </div>
</div>
<script>
    let form = document.querySelector(".form")

    form.addEventListener("submit", function(e) {
        let formId = document.querySelector("#InputId");
        let formPwd = document.querySelector("#InputPassword");
        if(formPwd.value.length === 0) {
            e.preventDefault()
            setMessage("비밀번호를 입력해주세요.", formPwd);
        }
        if(formId.value.length ===0) {
            e.preventDefault()
            setMessage("아이디를 입력해주세요.", formId);
        }
    })

    function setMessage(msg, element) {
        document.querySelector("#msg").innerHTML = `<div class="alert alert-danger" role="alert">${'${msg}'}</div>`;
        if(element) {
            element.select();
        }
    }
</script>
</body>
</html>
