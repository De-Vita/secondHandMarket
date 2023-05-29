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
<form action="/member/update" method="post" enctype="multipart/form-data" name="updateForm">
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
        <td><input type="text" name="nickname" value="${member.nickname}"></td>
      </tr>
      <tr>
        <th>이름</th>
        <td><input type="text" name="name" value="${member.name}" readonly></td>
      </tr>
      <tr>
          <th>이메일</th>
          <td><input type="text" name="email" value="${member.email}"></td>
      </tr>
 </table>
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
</script>
</html>
