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
</head>
<body>
    <form action="/member/save" method="post" enctype="multipart/form-data">
        <label for="member-email">아이디 </label>
        <input type="text" name="email" id="member-email"> <br>
        <label for="member-password">비밀번호 </label>
        <input type="text" name="password" id="member-password"> <br>
        <label for="password-check">비밀번호 확인 </label>
        <input type="text" name="passwordCheck" id="password-check"> <br>
        <label for="member-nickName">닉네임 </label>
        <input type="text" name="nickName" id="member-nickName"> <br>
        <label for="member-name">이름</label>
        <input type="text" name="name" id="member-name"> <br>
        <label for="member-mobile">전화번호</label>
        <input type="text" name="mobile" id="member-mobile"> <br>
        <label for="member-profile">프로필사진</label>
        <input type="file" name="profile" id="member-profile"> <br>
        <input type="submit" value="가입">
    </form>
</body>
</html>
