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
        <label for="member-email">이메일</label>
        <input type="text" name="email" id="member-email">
        <select id="email-domain-select">
            <option value="">직접입력</option>
            <option value="naver.com">naver.com</option>
            <option value="daum.net">daum.net</option>
            <option value="gmail.com">gmail.com</option>
        </select>
        <p id="email-check"></p>
        <label for="member-profile">프로필사진</label>
        <input type="file" name="profile" id="member-profile"> <br>
        <input type="submit" value="가입">
    </form>
</body>
</html>
