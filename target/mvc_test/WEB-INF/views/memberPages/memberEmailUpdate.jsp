<%--
  Created by IntelliJ IDEA.
  User: 이은수
  Date: 2023-06-03
  Time: 오전 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
</head>
<body>
    <div class="container">
        <h2>이메일 수정</h2>
        <hr>
        <form action="/member/updateEmail" method="post" onsubmit="return email_update_check()">
            <table class="table table-bordered">
                <tr>
                    <th>현재 이메일</th>
                    <td>
                        <input type="text" id="current-email" onblur="current_email_check()">
                        <select id="current-domain">
                            <option>@naver.com</option>
                            <option>@daum.com</option>
                            <option>@gmail.com</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>새 이메일</th>
                    <td>
                        <input type="text" id="new-email" name="email" onblur="email_check()">
                        <select id="new-domain" name="domain">
                            <option>@naver.com</option>
                            <option>@daum.com</option>
                            <option>@gmail.com</option>
                        </select>
                        <button id="mail-Check-Btn" disabled type="button">인증</button>
                    </td>
                </tr>
                <tr>
                    <th>인증번호</th>
                    <td><input type="text" id="mail-auth" disabled="disabled"></td>
                </tr>
            </table>
            <p id="current-email-check"></p>
            <p id="new-email-check"></p>
            <span id="mail-auth-warn"></span> <br>
            <button type="submit">수정</button>
        </form>
    </div>
</body>
<script>
    const current_email_check = () => {
      const inputEmail = document.getElementById("current-email").value;
      const inputDomain = document.getElementById("current-domain").value;
      const inputFullEmail = inputEmail + inputDomain;
      const currentFullEmail = "${member.email}";
      const result = document.getElementById("current-email-check");
      const inputField = document.getElementById("current-email");
      if (inputFullEmail == currentFullEmail) {
          result.innerHTML = "일치합니다";
          result.style.color = "green";
          inputField.style.backgroundColor = "white";
          return true;
      } else {
          result.innerHTML = "일치하지 않습니다";
          result.style.color = "red";
          inputField.style.backgroundColor = "lightcoral";
          return false;
      }
    }
    const email_check = () => {
      const email = document.getElementById("new-email").value;
      const domain = document.getElementById("new-domain").value;
      const result = document.getElementById("new-email-check");
      const inputField = document.getElementById("new-email");
      const mailCheckBtn = document.getElementById("mail-Check-Btn");
      let pass = false;

        if (email.trim() === '') {
            result.innerHTML = "이메일을 입력해주세요";
            result.style.color = "red";
            mailCheckBtn.disabled = true;
            inputField.style.backgroundColor = "lightcoral";
        }

        const fullEmail = email + domain;
        $.ajax({
            type: "post",
            url: "/member/email-check",
            data: {
                "email": fullEmail
            },
            async: false,
            success: function () {
                result.innerHTML = "";
                inputField.style.backgroundColor = "white";
                mailCheckBtn.disabled = false;
                pass = true;
            },
            error: function (err) {
                console.log(err);
                if (err.status == 404) {
                    result.innerHTML = "필수 정보입니다";
                    result.style.color = "red";
                    inputField.style.backgroundColor = "lightcoral";
                } else if (err.status == 409) {
                    result.innerHTML = "사용 중인 이메일입니다";
                    result.style.color = "red";
                    inputField.style.backgroundColor = "lightcoral";
                }
                mailCheckBtn.disabled = true; // 본인인증 버튼 비활성화
                pass = false;
            }
        });
        return pass;
    }
    $('#mail-Check-Btn').click(function () {
        const eamil = $('#new-email').val() + $('#new-domain').val(); // 이메일 주소값 얻어오기!
        console.log('완성된 이메일 : ' + eamil); // 이메일 오는지 확인
        const checkInput = $('#mail-auth');

        $.ajax({
            type: 'get',
            url: '/member/mailAuth?email=' + encodeURIComponent(eamil),
            success: function (data) {
                console.log("data : " + data);
                checkInput.attr('disabled', false);
                code = data;
                alert('인증번호가 전송되었습니다.')
            }
        }); // end ajax
    }); // end send eamil


    let isCodeValid = false;

    // 인증번호 비교
    // blur -> focus가 벗어나는 경우 발생
    $('#mail-auth').blur(function () {
        const inputCode = $(this).val();
        const $resultMsg = $('#mail-auth-warn');
        if (inputCode === code) {
            $resultMsg.html('인증번호가 일치합니다.');
            $resultMsg.css('color', 'green');
            $('#mail-Check-Btn').attr('disabled', true);
            $('#new-email').attr('readonly', true);
            $('#new-domain').attr('readonly', true);
            $('#new-domain').attr('onFocus', 'this.initialSelect = this.selectedIndex');
            $('#new-domain').attr('onChange', 'this.selectedIndex = this.initialSelect');
            isCodeValid = true;
        } else {
            $resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!');
            $resultMsg.css('color', 'red');
            isCodeValid = false;
        }
    });
    
    const email_update_check = () => {
      const isCurrentEmailValid = current_email_check();
      const isEmailValid = email_check();
      if (
          isCurrentEmailValid &&
          isEmailValid &&
          isCodeValid
      ) {
          return true;
      } else {
          return false;
      }
    }

</script>
</html>
