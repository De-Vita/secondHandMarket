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
<%--    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">--%>
</head>
<body>
    <form action="/member/save" method="post" id="signup_form" enctype="multipart/form-data" onsubmit="return signup_check()">
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
        <div class="form-group email-form">
            <label for="member-email">이메일</label>
            <div class="input-group">
                <input type="text" class="form-control" name="email" id="member-email" placeholder="이메일" onblur="email_check()">
                <select class="form-control" name="domain" id="member-domain" >
                    <option>@naver.com</option>
                    <option>@daum.net</option>
                    <option>@gmail.com</option>
                </select>
                <p id="email-check"></p>
                </div>
                <div class="input-group-addon">
                    <button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
                </div>
                <div class="mail-check-box">
                    <input class="form-control mail-check-input" id="mail-check" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
                </div>
                <span id="mail-check-warn"></span>
            </div>
        <label for="member-profile">프로필사진</label>
        <input type="file" name="profile" id="member-profile"> <br>
        <input type="submit" value="가입">
    </form>
</body>
<script>

    const account_check = () => {
        const account = document.getElementById("member-account").value;
        const result = document.getElementById("account-check");

        return new Promise((resolve, reject) => {
            $.ajax({
                type: "post",
                url: "/member/account-check",
                data: {
                    "account": account
                },
                success: function () {
                    result.innerHTML = "사용 가능한 아이디입니다";
                    result.style.color = "green";
                    resolve(true); // 유효한 아이디인 경우 resolve
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
                    resolve(false); // 유효하지 않은 아이디인 경우 resolve
                }
            });
        });
    };

    const password_check = () => {
        const password = document.getElementById("member-password").value;
        const passwordResult = document.getElementById("password-check");
        const exp = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}$/;
        if (password.length == 0) {
            passwordResult.innerHTML = "필수 정보입니다";
            passwordResult.style.color = "red";
        }else if (password.match(exp)) {
            passwordResult.innerHTML = "사용 가능한 비밀번호";
            passwordResult.style.color = "green";
            return true;
        } else {
            passwordResult.innerHTML = "8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
            passwordResult.style.color = "red";
            return false;
        }
    }

    const password_confirm = () => {
        const password = document.getElementById("member-password").value;
        const passwordConfirm = document.getElementById("password-confirm").value;
        const checkResult = document.getElementById("password-confirm-result");
        if (passwordConfirm.length == 0) {
            checkResult.innerHTML = "필수 정보입니다.";
            checkResult.style.color = "red";
            return false;
        } else if (password == passwordConfirm) {
            checkResult.innerHTML = "일치합니다";
            checkResult.style.color = "green";
            return true;
        } else {
            checkResult.innerHTML = "일치하지 않습니다";
            checkResult.style.color = "red";
            return false;
        }
    }
    const nickname_check = () => {
        const nickname = document.getElementById("member-nickname").value;
        const result = document.getElementById("nickname-check");

        return new Promise((resolve, reject) => {
            $.ajax({
                type: "post",
                url: "/member/nickname-check",
                data: {
                    "nickname": nickname
                },
                success: function () {
                    result.innerHTML = "사용 가능한 닉네임";
                    result.style.color = "green";
                    resolve(true); // 유효한 닉네임인 경우 resolve
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
                    resolve(false); // 유효하지 않은 닉네임인 경우 resolve
                }
            });
        });
    };
    const name_check = () => {
        const name = document.getElementById("member-name").value;
        const result = document.getElementById("name-check");
        const exp = /^[가-힣a-zA-Z]*$/;
        if (name.length == 0) {
            result.innerHTML = "필수 정보입니다";
            result.style.color = "red";
            return false;
        } else if (name.match(exp)) {
            result.innerHTML = "";
            return true;
        } else {
            result.innerHTML = "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
            result.style.color = "red";
            return false;
        }
    }

    const email_check = () => {
        const email = document.getElementById("member-email").value;
        const domain = document.getElementById("member-domain").value;
        const result = document.getElementById("email-check");

        // 이메일 필드가 비어 있는 경우 처리
        if (email.trim() === '') {
            result.innerHTML = "이메일을 입력해주세요";
            result.style.color = "red";
            return Promise.resolve(false);
        }

        // 이메일 주소 구성
        const fullEmail = email + domain;

        return new Promise((resolve, reject) => {
            $.ajax({
                type: "post",
                url: "/member/email-check",
                data: {
                    "email": fullEmail
                },
                success: function () {
                    result.innerHTML = "";
                    resolve(true); // 유효한 이메일인 경우 resolve
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
                    resolve(false); // 유효하지 않은 이메일인 경우 resolve
                }
            });
        });
    };



    const signup_check = () => {
        const account = document.getElementById("member-account");
        const password = document.getElementById("member-password");
        const passwordConfirm = document.getElementById("password-confirm");
        const nickname = document.getElementById("member-nickname");
        const name = document.getElementById("member-name");
        const email = document.getElementById("member-email");

        Promise.all([account_check(), nickname_check(), email_check()])
            .then(([accountValid, nicknameValid, emailValid]) => {
                if (!accountValid) {
                    account.focus();
                    return false;
                }
                if (!nicknameValid) {
                    nickname.focus();
                    return false;
                }
                if (!emailValid) {
                    email.focus();
                    return false;
                }

                return password_check();
            })
            .then(passwordValid => {
                if (!passwordValid) {
                    password.focus();
                    return false;
                }

                return name_check();
            })
            .then(nameValid => {
                if (!nameValid) {
                    name.focus();
                    return false;
                }

                // 폼 제출
                document.getElementById("signup_form").submit();
            })
            .catch(error => {
                console.error(error);
                return false;
            });

        return false; // 폼 제출 방지
    };


    $('#mail-Check-Btn').click(function() {
        const eamil = $('#member-email').val() + $('#member-domain').val(); // 이메일 주소값 얻어오기!
        console.log('완성된 이메일 : ' + eamil); // 이메일 오는지 확인
        const checkInput = $('.mail-check-input') // 인증번호 입력하는곳

        $.ajax({
            type : 'get',
            url: '/member/mailAuth?email=' + encodeURIComponent(eamil),
            success : function (data) {
                console.log("data : " +  data);
                checkInput.attr('disabled',false);
                code =data;
                alert('인증번호가 전송되었습니다.')
            }
        }); // end ajax
    }); // end send eamil

    // 인증번호 비교
    // blur -> focus가 벗어나는 경우 발생
    $('.mail-check-input').blur(function () {
        const inputCode = $(this).val();
        const $resultMsg = $('#mail-check-warn');

        if(inputCode === code){
            $resultMsg.html('인증번호가 일치합니다.');
            $resultMsg.css('color','green');
            $('#mail-Check-Btn').attr('disabled',true);
            $('#member-email').attr('readonly',true);
            $('#member-domain').attr('readonly',true);
            $('#member-domain').attr('onFocus', 'this.initialSelect = this.selectedIndex');
            $('#member-domain').attr('onChange', 'this.selectedIndex = this.initialSelect');
        }else{
            $resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
            $resultMsg.css('color','red');
        }
    });
</script>
</html>
