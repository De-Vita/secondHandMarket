<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
<div class="container">
    <h2 class="mt-4">My Page</h2>
    <hr>

    <table class="table table-bordered">
        <tr>
            <th>프로필</th>
            <td>
                <img src="${pageContext.request.contextPath}/upload/${memberProfile.storedFileName}"
                     alt="profile" class="profile-img">
            </td>
        </tr>
        <tr>
            <th>아이디</th>
            <td>${member.account}</td>
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

</div>
</body>
</html>
