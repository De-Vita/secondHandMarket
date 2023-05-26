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
    <%--    <script src="/resources/js/memberSave.js"></script>--%>
    <link rel="stylesheet" href="/resources/css/save.css">
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css"/>

</head>
<body>

<form action="/member/save" method="post" id="signup_form" enctype="multipart/form-data"
      onsubmit="return signup_check()" class="container">
    <div class="custom-file">
        <img id="preview" src="	data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAWgA…zbd/obwGuomOMmTLiDvQ/zGymoxuV69cAAAAASUVORK5CYII=
" alt="Preview Image" style="display: none; max-width: 200px; margin-top: 10px;">
        <label for="member-profile" class="btn btn-primary">프로필 선택</label>
        <input type="file" name="profile" id="member-profile" style="display: none;" onchange="previewImage(event)">
    </div>
    <label for="member-account">아이디 </label>
    <input type="text" name="account" id="member-account" onblur="account_check()" class="form-control">
    <p id="account-check"></p>
    <label for="member-password">비밀번호</label>
    <div class="input-group" style="display: flex; align-items: center">
        <div style="position: relative; flex: 1;">
            <input type="password" name="password" id="member-password" onblur="password_check()" class="form-control">
            <span class="input-group-text" style="background-color: transparent; border: none; position: absolute; right: 5px; top: 50%; transform: translateY(-50%); cursor: pointer;">
            <i id="password-icon" class="bi bi-eye-slash" onclick="togglePasswordVisibility()"></i>
        </span>
        </div>
    </div>
    <p id="password-check"></p>
    <label for="password-confirm">비밀번호 확인 </label>
    <input type="text" name="passwordConfirm" id="password-confirm" onblur="password_confirm()" class="form-control">
    <p id="password-confirm-result"></p>
    <label for="member-nickname">닉네임 </label>
    <input type="text" name="nickname" id="member-nickname" onblur="nickname_check()" class="form-control">
    <p id="nickname-check"></p>
    <label for="member-name">이름</label>
    <input type="text" name="name" id="member-name" onblur="name_check()" class="form-control">
    <p id="name-check"></p>
    <div class="form-group email-form">
        <label for="member-email">이메일</label>
        <div class="row g-2">
            <div class="col-md-5">
                <input type="text" class="form-control" name="email" id="member-email" placeholder="이메일"
                       onblur="email_check()">
            </div>
            <div class="col-md-5">
                <select class="form-control" name="domain" id="member-domain">
                    <option>@naver.com</option>
                    <option>@daum.net</option>
                    <option>@gmail.com</option>
                </select>
            </div>
            <div class="col-md-2">
                <button type="button" class="btn btn-primary" id="mail-Check-Btn" disabled>인증</button>
            </div>
            <p id="email-check"></p>
        </div>
        <div class="input-group-addon">

        </div>
        <div class="mail-auth-box">
            <input class="form-control mail-auth-input" id="mail-auth" placeholder="인증번호 6자리를 입력해주세요!"
                   disabled="disabled" maxlength="6">
        </div>
        <span id="mail-auth-warn"></span>
    </div>

    <div class="row">
        <div class="col d-grid">
            <input type="submit" value="가입" class="btn btn-primary">
        </div>
    </div>
</form>
</body>
<script>

    function previewImage(event) {
        let input = event.target;
        let preview = document.getElementById("preview");

        if (input.files && input.files[0]) {
            let reader = new FileReader();

            reader.onload = function (e) {
                preview.src = e.target.result;
                preview.style.display = "block";
            };

            reader.readAsDataURL(input.files[0]);
        } else {
            preview.src = "/resources/images/기본이미지.png";
            preview.style.display = "none";
        }
    }

    function togglePasswordVisibility() {
        let passwordInput = document.getElementById("member-password");
        let passwordIcon = document.getElementById("password-icon");

        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            passwordIcon.className = "bi bi-eye";
        } else {
            passwordInput.type = "password";
            passwordIcon.className = "bi bi-eye-slash";
        }
    }

    const account_check = () => {
        const account = document.getElementById("member-account").value;
        const result = document.getElementById("account-check");
        let pass = false;
        $.ajax({
            type: "post",
            url: "/member/account-check",
            data: {
                "account": account
            },
            async: false,
            success: function () {
                result.innerHTML = "사용 가능한 아이디입니다";
                result.style.color = "green";
                pass = true;
            },
            error: function (err) {
                console.log(err);
                if (err.status == 409) {
                    result.innerHTML = "이미 사용 중인 아이디입니다.";
                    result.style.color = "red";
                } else if (err.status == 400) {
                    result.innerHTML = "5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.";
                    result.style.color = "red";
                } else if (err.status == 404) {
                    result.innerHTML = "필수 정보입니다.";
                    result.style.color = "red";
                }
                pass = false;
            }
        })
        return pass;
    }

    const password_check = () => {
        const password = document.getElementById("member-password").value;
        const result = document.getElementById("password-check");
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
                pass = true;
            },
            error: function (err) {
                console.log(err);
                if (err.status == 404) {
                    result.innerHTML = "필수 정보입니다";
                    result.style.color = "red";
                } else if (err.status == 400) {
                    result.innerHTML = "8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
                    result.style.color = "red";
                }
                pass = false;
            }
        })
        return pass;
    }

    const password_confirm = () => {
        const password = document.getElementById("member-password").value;
        const passwordConfirm = document.getElementById("password-confirm").value;
        const result = document.getElementById("password-confirm-result");
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
                pass = true;
            },
            error: function (err) {
                console.log(err);
                if (err.status == 404) {
                    result.innerHTML = "필수 정보입니다";
                    result.style.color = "red";
                } else if (err.status = 400) {
                    result.innerHTML = "일치하지 않습니다";
                    result.style.color = "red";
                }
                pass = false;
            }
        })
        return pass;
    }

    const nickname_check = () => {
        const nickname = document.getElementById("member-nickname").value;
        const result = document.getElementById("nickname-check");
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
                pass = true;
            },
            error: function (err) {
                console.log(err);
                if (err.status == 409) {
                    result.innerHTML = "이미 사용 중인 닉네임입니다.";
                    result.style.color = "red";
                } else if (err.status == 400) {
                    result.innerHTML = "한글, 영어, 숫자만 사용(최대 6글자)";
                    result.style.color = "red";
                } else if (err.status == 404) {
                    result.innerHTML = "필수 정보입니다.";
                    result.style.color = "red";
                }
                pass = false;
            }
        });
        return pass;
    }

    const name_check = () => {
        const name = document.getElementById("member-name").value;
        const result = document.getElementById("name-check");
        let pass = true;
        $.ajax({
            type: "post",
            url: "/member/name-check",
            data: {
                "name": name
            },
            async: false,
            success: function () {
                result.innerHTML = "";
                pass = true;
            },
            error: function (err) {
                console.log(err);
                if (err.status == 404) {
                    result.innerHTML = "필수 정보입니다";
                    result.style.color = "red";
                } else if (err.status == 400) {
                    result.innerHTML = "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
                    result.style.color = "red";
                }
                pass = false;
            }
        })
        return pass;
    }

    const email_check = () => {
        const email = document.getElementById("member-email").value;
        const domain = document.getElementById("member-domain").value;
        const result = document.getElementById("email-check");
        const mailCheckBtn = document.getElementById("mail-Check-Btn");
        let pass = false;

        // 이메일 필드가 비어 있는 경우 처리
        if (email.trim() === '') {
            result.innerHTML = "이메일을 입력해주세요";
            result.style.color = "red";
            mailCheckBtn.disabled = true; // 본인인증 버튼 비활성화
        }

        // 이메일 주소 구성
        const fullEmail = email + domain;
        $.ajax({
            type: "post",
            url: "/member/email-check",
            data: {
                "email": fullEmail
            },
            async: false,
            success: function () {
                result.innerHTML = "";
                result.style.color = "green";
                mailCheckBtn.disabled = false; // 본인인증 버튼 활성화
                pass = true;
            },
            error: function (err) {
                console.log(err);
                if (err.status == 404) {
                    result.innerHTML = "필수 정보입니다";
                    result.style.color = "red";
                } else if (err.status == 409) {
                    result.innerHTML = "사용 중인 이메일입니다";
                    result.style.color = "red";
                }
                mailCheckBtn.disabled = true; // 본인인증 버튼 비활성화
                pass = false;
            }
        });
        return pass;
    }

    $('#mail-Check-Btn').click(function () {
        const eamil = $('#member-email').val() + $('#member-domain').val(); // 이메일 주소값 얻어오기!
        console.log('완성된 이메일 : ' + eamil); // 이메일 오는지 확인
        const checkInput = $('.mail-auth-input') // 인증번호 입력하는곳

        $.ajax({
            type: 'get',
            url: '/member/mailAuth?email=' + encodeURIComponent(eamil),
            success: function (data) {
                console.log("data : " + data);
                checkInput.attr('disabled', false);
                code = data;
                alert('인증번호가 전송되었습니다.')
            }
        }); // end ajax
    }); // end send eamil


    let isCodeValid = false;

    // 인증번호 비교
    // blur -> focus가 벗어나는 경우 발생
    $('.mail-auth-input').blur(function () {
        const inputCode = $(this).val();
        const $resultMsg = $('#mail-auth-warn');

        if (inputCode === code) {
            $resultMsg.html('인증번호가 일치합니다.');
            $resultMsg.css('color', 'green');
            $('#mail-Check-Btn').attr('disabled', true);
            $('#member-email').attr('readonly', true);
            $('#member-domain').attr('readonly', true);
            $('#member-domain').attr('onFocus', 'this.initialSelect = this.selectedIndex');
            $('#member-domain').attr('onChange', 'this.selectedIndex = this.initialSelect');
            isCodeValid = true;
        } else {
            $resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!');
            $resultMsg.css('color', 'red');
            isCodeValid = false;
        }
    });

    const signup_check = () => {
        console.log(isCodeValid);
        // 각 필드의 유효성 검사 함수 호출
        const isAccountValid = account_check();
        const isPasswordValid = password_check();
        const isPasswordConfirmValid = password_confirm();
        const isNicknameValid = nickname_check();
        const isNameValid = name_check();
        const isEmailValid = email_check();

        if (
            isAccountValid &&
            isPasswordValid &&
            isPasswordConfirmValid &&
            isNicknameValid &&
            isNameValid &&
            isEmailValid &&
            isCodeValid
        ) {
            return true;
        } else {
            return false;
        }
    };

</script>
</html>
