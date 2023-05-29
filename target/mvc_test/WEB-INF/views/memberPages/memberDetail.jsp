<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My Page</title>
    <!-- Bootstrap CSS -->
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
<%@include file="../component/nav.jsp" %>
<div class="container">
    <h2 class="mt-4">My Page</h2>
    <hr>

    <table class="table table-bordered">
        <tr>
            <th>프로필</th>
            <td>
                <img src="${pageContext.request.contextPath}/upload/${memberProfile != null ? memberProfile.storedFileName : '기본이미지.png'}"
                     alt="profile" class="profile-img">
            </td>
        </tr>
        <tr>
            <th>아이디</th>
            <td>${member.account}</td>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td><button onclick="updatePass()">수정</button></td>
        </tr>
        <tr>
            <th>닉네임</th>
            <td>${member.nickname}</td>
        </tr>
        <tr>
            <th>이름</th>
            <td>${member.name}</td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>${member.email}</td>
        </tr>
    </table>
    <button class="btn btn-light" onclick="updateMember()">수정하기</button>
    <button class="btn btn-danger" onclick="leaveMembership()">탈퇴하기</button>
</div>
</body>
<script>
    const leaveMembership = () => {
      if (window.confirm("탈퇴하시겠습니까?")) {
          location.href = "/member/leave";
      }
    }
    const updateMember = () => {
      location.href = "/member/update";
    }
    const updatePass = () => {
      location.href = "/member/updatePass";
    }
</script>
</html>
