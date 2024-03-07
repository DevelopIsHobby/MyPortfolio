<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<body>
<h2>Comment Test</h2>
comment : <input type="text" name="comment"><br>
<button id="sendBtn" type="button">SEND</button>
<button id="modBtn" type="button">수정</button>
<div id="commentList"></div>
<div id="replyForm" style="display:none;">
    <input type="text" name="replyComment">
    <button id="wrtRepBtn" >등록</button>
</div>
<script>
    let bno = 1041;

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

    let toHTML = function(comments) {
        let tmp = "<ul>"

        comments.forEach(function(comment) {
            tmp += '<li data-cno=' + comment.cno
            tmp += ' data-pcno=' + comment.pcno
            tmp += ' data-bno=' + comment.bno + '>'
            if(comment.cno != comment.pcno)
                tmp += 'ㄴ'
            tmp += ' commenter=<span class="commenter">'+comment.commenter + '</span>'
            tmp += ' comment=<span class="comment">' + comment.comment + '</span>'
            tmp += ' up_date=' + comment.up_date
            tmp += ' <button class="delBtn">삭제</button>'
            tmp += ' <button class="modBtn">수정</button>'
            tmp += ' <button class="replyBtn">답글</button>'
            tmp += '</li>'
        })

        return tmp + "</ul>";
    }

    $(document).ready(function(){
        showList(bno);
        $("#sendBtn").click(function () {
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
            let comment = $("span.comment", $(this).parent()).text();
            let cno = $(this).parent().attr("data-cno");

            $("input[name=comment]").val(comment);
            $("#modBtn").attr("data-cno", cno);
        });

        $("#modBtn").on("click", function () {
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
        });
    });
</script>
</body>
</html>