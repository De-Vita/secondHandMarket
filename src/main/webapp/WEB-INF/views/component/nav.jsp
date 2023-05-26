<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-18
  Time: 오후 3:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <ul>
        <li><a href="/member/save">회원가입</a></li>
        <li>
            <c:choose>
                <c:when test="${sessionScope.loginAccount != null}">
                    <p>${sessionScope.loginNickname}님</p>
                    <a href="/member/logout">logout</a>
                </c:when>
                <c:otherwise>
                    <a href="/member/login">login</a>
                </c:otherwise>
            </c:choose>
        </li>
    </ul>
</body>
</html>
