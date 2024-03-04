<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
            <h2 class="card-title">Register Form</h2>
        </div>
        <div class="card-body">
            <div id="msg" class="msg"></div>
            <form:form class="form" modelAttribute="user" >
                <div class="card-body">
                    <form:errors path="id" cssClass="msg alert alert-danger" />
                </div>
                <div class="mb-3">
                    <label for="InputId" class="form-label">ID</label>
                    <input type="text" name="id" class="form-control" id="InputId" placeholder="8~12자리의 영대소문자와 숫자 조합">
                </div>
                <div class="mb-3">
                    <label for="InputPassword" class="form-label">Password</label>
                    <input type="password" name="pwd" class="form-control" id="InputPassword" placeholder="8~12자리의 영대소문자와 숫자 조합">
                </div>
                <div class="mb-3">
                    <label for="InputName" class="form-label">Name</label>
                    <input type="text" name="name" class="form-control" id="InputName" placeholder="홍길동">
                </div>
                <div class="mb-3">
                    <label for="InputEmail" class="form-label">Email address</label>
                    <input type="email" name="email" class="form-control" id="InputEmail" aria-describedby="emailHelp" placeholder="example@naver.com">
                    <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                </div>
                <div class="mb-3">
                    <label for="InputBirth" class="form-label">Birth</label>
                    <input type="text" name="birth" class="form-control" id="InputBirth" placeholder="2024/03/04">
                </div>

                <div class="sns-check">
                    <div class="mb-3 form-check" style="display: inline-block;">
                        <input type="checkbox" class="form-check-input" id="check1" value="facebook" name="sns">
                        <label class="form-check-label" for="check1">Facebook</label>
                    </div>
                    <div class="mb-3 form-check" style="display: inline-block;">
                        <input type="checkbox" class="form-check-input" id="check2" value="kakaotalk" name="sns">
                        <label class="form-check-label" for="check2">Kakaotalk</label>
                    </div>
                    <div class="mb-3 form-check" style="display: inline-block;">
                        <input type="checkbox" class="form-check-input" id="check3" value="instagram" name="sns">
                        <label class="form-check-label" for="check3">Instagram</label>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary" style="float: right;" >Submit</button>
            </form:form>
        </div>
    </div>
</div>
<script>
    let form = document.querySelector(".form")

    form.addEventListener("submit", function(e) {
        let formId = document.querySelector("#InputId");
        let formPwd = document.querySelector("#InputPassword");


        if(formPwd.value.length <3) {
            e.preventDefault()
            setMessage("pwd의 길이는 3이상이어야 합니다.", formPwd);
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
