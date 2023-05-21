<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-18
  Time: 오전 11:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script src="/resources/js/memberSave.js"></script>
    <script src="/resources/js/mailSend.js"></script>
<%--    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">--%>
</head>
<body>
    <form action="/member/save" method="post" enctype="multipart/form-data">
        <label for="member-account">아이디 </label>
        <input type="text" name="account" id="member-account" onblur="account_check()"> <br>
        <p id="account-check"></p>
        <label for="member-password">비밀번호 </label>
        <input type="text" name="password" id="member-password" onblur="password_check()"> <br>
        <p id="password-check"></p>
        <label for="password-confirm">비밀번호 확인 </label>
        <input type="text" name="passwordConfirm" id="password-confirm" onblur="password_confirm()"> <br>
        <p id="password-confirm-result"></p>
        <label for="member-nickname">닉네임 </label>
        <input type="text" name="nickname" id="member-nickname" onblur="nickname_check()"> <br>
        <p id="nickname-check"></p>
        <label for="member-name">이름</label>
        <input type="text" name="name" id="member-name" onblur="name_check()"> <br>
        <p id="name-check"></p>
        <div class="form-group email-form">
            <label for="userEmail1">이메일</label>
            <div class="input-group">
                <input type="text" class="form-control" name="userEmail1" id="userEmail1" placeholder="이메일" >
                <select class="form-control" name="userEmail2" id="userEmail2" >
                    <option>@naver.com</option>
                    <option>@daum.net</option>
                    <option>@gmail.com</option>
                </select>
                </div>
                <div class="input-group-addon">
                    <button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
                </div>
                <div class="mail-check-box">
                    <input class="form-control mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
                </div>
                <span id="mail-check-warn"></span>
            </div>
        <label for="member-profile">프로필사진</label>
        <input type="file" name="profile" id="member-profile"> <br>
        <input type="submit" value="가입">
    </form>
</body>
<script>
    $('#mail-Check-Btn').click(function() {
        const eamil = $('#userEmail1').val() + $('#userEmail2').val(); // 이메일 주소값 얻어오기!
        console.log('완성된 이메일 : ' + eamil); // 이메일 오는지 확인
        const checkInput = $('.mail-check-input') // 인증번호 입력하는곳

        $.ajax({
            type : 'get',
            url: '/member/mailCheck?email=' + encodeURIComponent(eamil),
            success : function (data) {
                console.log("data : " +  data);
                checkInput.attr('disabled',false);
                code =data;
                alert('인증번호가 전송되었습니다.')
            }
        }); // end ajax
    }); // end send eamil

    // 인증번호 비교
    // blur -> focus가 벗어나는 경우 발생
    $('.mail-check-input').blur(function () {
        const inputCode = $(this).val();
        const $resultMsg = $('#mail-check-warn');

        if(inputCode === code){
            $resultMsg.html('인증번호가 일치합니다.');
            $resultMsg.css('color','green');
            $('#mail-Check-Btn').attr('disabled',true);
            $('#userEamil1').attr('readonly',true);
            $('#userEamil2').attr('readonly',true);
            $('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
            $('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect');
        }else{
            $resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
            $resultMsg.css('color','red');
        }
    });
</script>
</html>
