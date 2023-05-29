<%--
  Created by IntelliJ IDEA.
  User: 이은수
  Date: 2023-05-29
  Time: 오전 11:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <!-- Custom CSS -->
  <style>
    .profile-img {
      width: 100px;
      height: 100px;
      border-radius: 50%;
    }
  </style>
</head>
<body>
<div class="container">
    <h2>회원정보 수정</h2>
    <hr>
<form action="/member/update" method="post" enctype="multipart/form-data" name="updateForm"
        onsubmit="return update_check()">
 <table class="table table-bordered">
      <tr>
         <th>프로필</th>
         <td>
            <img src="${pageContext.request.contextPath}/upload/${memberProfile.storedFileName}"
             alt="profile" class="profile-img" id="profile-preview">
             <input type="file" name="profile" id="profile-image" onchange="previewImage(event)">
         </td>
      </tr>
      <tr style="display: none">
          <th>id</th>
          <td><input type="text" name="id" value="${member.id}"></td>
      </tr>
      <tr>
        <th>아이디</th>
        <td><input type="text" name="account" value="${member.account}" readonly></td>
      </tr>
      <tr>
          <th>비밀번호</th>
          <td><input type="password" value="${member.password}" readonly></td>
      </tr>
      <tr>
        <th>닉네임</th>
        <td><input type="text" name="nickname" id="member-nickname" value="${member.nickname}" onblur="nickname_check()"></td>
      </tr>
      <tr>
        <th>이름</th>
        <td><input type="text" name="name" id="member-name" value="${member.name}" onblur="name_check()"></td>
      </tr>
      <tr>
          <th>이메일</th>
          <td><input type="text" name="email" value="${member.email}" readonly></td>
      </tr>
 </table>
    <p id="nickname-check"></p>
    <p id="name-check"></p>
    <button class="btn btn-primary" type="submit">수정</button>
</form>
</div>
</body>
<script>
    function previewImage(event) {
        let fileInput = event.target;
        let profilePreview = document.getElementById("profile-preview");

        if (fileInput.files && fileInput.files[0]) {
            let reader = new FileReader();
            reader.onload = function (e) {
                profilePreview.src = e.target.result;
            };
            reader.readAsDataURL(fileInput.files[0]);
        }
    }

    const nickname_check = () => {
        const nickname = document.getElementById("member-nickname").value;
        const result = document.getElementById("nickname-check");
        const originalNickname = "${member.nickname}";
        const inputField = document.getElementById("member-nickname");
        let pass = false;
        $.ajax({
            type: "post",
            url: "/member/nickname-check",
            data: {
                "nickname": nickname
            },
            async: false,
            success: function () {
                result.innerHTML = "사용 가능한 닉네임";
                result.style.color = "green";
                inputField.style.backgroundColor = "white";
                pass = true;
            },
            error: function (err) {
                console.log(err);
                if (nickname == originalNickname) {
                    result.innerHTML = "";
                    inputField.style.backgroundColor = "white";
                    pass = true;
                }
                else if (err.status == 409) {
                    result.innerHTML = "이미 사용 중인 닉네임입니다.";
                    result.style.color = "red";
                    inputField.style.backgroundColor = "lightcoral";
                    pass = false;
                } else if (err.status == 400) {
                    result.innerHTML = "한글, 영어, 숫자만 사용(최대 6글자)";
                    result.style.color = "red";
                    inputField.style.backgroundColor = "lightcoral";
                    pass = false;
                } else if (err.status == 404) {
                    result.innerHTML = "필수 정보입니다.";
                    result.style.color = "red";
                    inputField.style.backgroundColor = "lightcoral";
                    pass = false;
                }

            }
        });
        return pass;
    }

    const name_check = () => {
        const name = document.getElementById("member-name").value;
        const result = document.getElementById("name-check");
        const originalName = "${member.name}";
        const inputField = document.getElementById("member-name");
        let pass = false;
        $.ajax({
            type: "post",
            url: "/member/name-check",
            data: {
                "name": name
            },
            async: false,
            success: function () {
                result.innerHTML = "";
                inputField.style.backgroundColor = "white";
                pass = true;
            },
            error: function (err) {
                console.log(err);
                if (name == originalName) {
                    result.innerHTML = "";
                    inputField.style.backgroundColor = "white";
                    pass = true;
                }
                else if (err.status == 404) {
                    result.innerHTML = "필수 정보입니다";
                    result.style.color = "red";
                    inputField.style.backgroundColor = "lightcoral";
                    pass = false;
                } else if (err.status == 400) {
                    result.innerHTML = "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
                    result.style.color = "red";
                    inputField.style.backgroundColor = "lightcoral";
                    pass = false;
                }

            }
        })
        return pass;
    }

    const update_check = () => {
        const isNickNameValid = nickname_check();
        const isNameValid = name_check();

        if (
            isNickNameValid &&
            isNameValid
        ) {
            return true;
        } else {
            return false;
        }
    };



</script>
</html>
