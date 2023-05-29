<%--
  Created by IntelliJ IDEA.
  User: 이은수
  Date: 2023-05-26
  Time: 오전 5:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@include file="../component/nav.jsp" %>
<form action="/member/login" method="post">
  <input type="text" name="account" placeholder="아이디"> <br>
  <input type="text" name="password" placeholder="비밀번호">
  <input type="submit" value="로그인">
</form>
</body>
</html>
