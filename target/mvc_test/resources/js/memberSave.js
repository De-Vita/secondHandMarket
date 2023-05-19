const account_check = () => {
    const account = document.getElementById("member-account").value;
    const result = document.getElementById("account-check");
    $.ajax({
        type: "post",
        url: "/member/account-check",
        data : {
            "account" : account
        },
        success: function () {
            result.innerHTML = "사용 가능한 아이디입니다";
            result.style.color = "green";
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
        }
    })
}
const password_check = () => {
    const password = document.getElementById("member-password").value;
    const passwordResult = document.getElementById("password-check");
    const exp = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}$/;
    if (password.match(exp)) {
        passwordResult.innerHTML = "사용 가능한 비밀번호";
        passwordResult.style.color = "green";
    } else {
        passwordResult.innerHTML = "8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.";
        passwordResult.style.color = "red";
    }
}
const password_confirm = () => {
    const password = document.getElementById("member-password").value;
    const passwordConfirm = document.getElementById("password-confirm").value;
    const checkResult = document.getElementById("password-confirm-result");
    if (password.length == 0) {
        checkResult.innerHTML = "필수 정보입니다.";
        checkResult.style.color = "red";
    } else if (password == passwordConfirm) {
        checkResult.innerHTML = "일치합니다";
        checkResult.style.color = "green";
    } else {
        checkResult.innerHTML = "일치하지 않습니다";
        checkResult.style.color = "red";
    }
}
const nickname_check = () => {
  const nickname = document.getElementById("member-nickname").value;
  const result = document.getElementById("nickname-check");
  $.ajax({
      type: "post",
      url: "/member/nickname-check",
      data: {
          "nickname" : nickname
      },
      success: function () {
          result.innerHTML = "사용 가능한 닉네임";
          result.style.color = "green";
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
      }
  })
}
const name_check = () => {
  const name = document.getElementById("member-name").value;
  const result = document.getElementById("name-check");
  const exp = /^[가-힣a-zA-Z]*$/;
    if (name.length == 0) {
      result.innerHTML = "필수 정보입니다";
      result.style.color = "red";
  } else if (name.match(exp)) {
        result.innerHTML = "";
    } else {
        result.innerHTML = "한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)";
        result.style.color = "red";
    }
}
