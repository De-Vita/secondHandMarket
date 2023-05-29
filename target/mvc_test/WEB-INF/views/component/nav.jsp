<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-18
  Time: 오후 3:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<html>
<head>
    <title>Title</title>
</head>
<body>
    <nav class="navbar navbar-dark bg-primary">
        <div class="container-fluid">
            <ul class="navbar-nav flex-row mb-2 mb-lg-0">
                <li class="nav-item me-3"><a class="nav-link active" href="/member/save">회원가입</a></li>
                <li class="nav-item">
                    <c:choose>
                        <c:when test="${sessionScope.loginAccount != null}">
                            <p class="navbar-text text-white me-3">${sessionScope.loginNickname}님</p>
                            <li class="nav-item me-3"><a class="nav-link active" href="/member/mypage">mypage</a></li>
                            <li class="nav-item"><a class="nav-link active" href="/member/logout">logout</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a class="nav-link active" href="/member/login">login</a></li>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </div>
    </nav>
</body>
</html>
