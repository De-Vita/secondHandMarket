<%--
  Created by IntelliJ IDEA.
  User: 이은수
  Date: 2023-05-30
  Time: 오전 12:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
  <div class="container">
      <h2>비밀번호 수정</h2>
      <hr>
      <form action="/member/updatePass" method="post" onsubmit="return password_update_check()">
          <table class="table table-bordered">
              <tr>
                  <th>현재 비밀번호</th>
                  <td><input type="password" id="current-password" onblur="current_password_check()"></td>
              </tr>
              <tr>
                  <th>새 비밀번호</th>
                  <td><input type="password" name="password" id="new-password" onblur="password_check()"></td>
              </tr>
              <tr>
                  <th>비밀번호 확인</th>
                  <td><input type="password" id="password-confirm" onblur="password_confirm()"></td>
              </tr>
          </table>
          <p id="current-password-check"></p>
          <p id="new-password-check"></p>
          <p id="password-confirm-check"></p>
          <button class="btn btn-primary" type="submit">수정</button>
      </form>
  </div>
</body>
<script>
    const current_password_check = () => {
      const inputPassword = document.getElementById("current-password").value;
      const currentPassword = "${member.password}";
      const result = document.getElementById("current-password-check");
      const inputField = document.getElementById("current-password");
      if (inputPassword == currentPassword) {
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

    const password_check = () => {
        const password = document.getElementById("new-password").value;
        const result = document.getElementById("new-password-check");
        const inputField = document.getElementById("new-password");
        let pass = false;
        $.ajax({
            type: "post",
            url: "/member/password-check",
            data: {
                "password": password
            },
            async: false,
            success: function () {
                result.innerHTML = "사용 가능한 비밀번호";
                result.style.color = "green";
                inputField.style.backgroundColor = "white";
                pass = true;
            },
            error: function (err) {
                console.log(err);
                if (err.status == 404) {
                    result.innerHTML = "필수 정보입니다";
                    result.style.color = "red";
                    inputField.style.backgroundColor = "lightcoral";
                } else if (err.status == 400) {
                    result.innerHTML = "8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
                    result.style.color = "red";
                    inputField.style.backgroundColor = "lightcoral";
                }
                pass = false;
            }
        })
        return pass;
    }

    const password_confirm = () => {
        const password = document.getElementById("new-password").value;
        const passwordConfirm = document.getElementById("password-confirm").value;
        const result = document.getElementById("password-confirm-check");
        const inputField = document.getElementById("password-confirm");
        let pass = false;
        $.ajax({
            type: "post",
            url: "/member/password-confirm",
            data: {
                "password": password,
                "passwordConfirm": passwordConfirm
            },
            async: false,
            success: function () {
                result.innerHTML = "일치합니다";
                result.style.color = "green";
                inputField.style.backgroundColor = "white";
                pass = true;
            },
            error: function (err) {
                console.log(err);
                if (err.status == 404) {
                    result.innerHTML = "필수 정보입니다";
                    result.style.color = "red";
                    inputField.style.backgroundColor = "lightcoral";
                } else if (err.status = 400) {
                    result.innerHTML = "일치하지 않습니다";
                    result.style.color = "red";
                    inputField.style.backgroundColor = "lightcoral";
                }
                pass = false;
            }
        })
        return pass;
    }

    const password_update_check = () => {
        const isCurrentPasswordValid = current_password_check();
        const isPasswordValid = password_check();
        const isPasswordConfirmValid = password_confirm();
        if (
            isCurrentPasswordValid &&
            isPasswordValid &&
            isPasswordConfirmValid
        ) {
            return true;
        } else {
            return false;
        }
    }


</script>
</html>
