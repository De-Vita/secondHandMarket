package com.icia.market.controller;

import com.icia.market.dto.MemberDTO;
import com.icia.market.service.MailSendService;
import com.icia.market.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RequestMapping("/member")
@Controller
public class MemberController {
    @Autowired
    MemberService memberService;
    @Autowired
    MailSendService mailSendService;
    @GetMapping("/save")
    public String saveForm() {
        return "memberPages/memberSave";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute MemberDTO memberDTO) throws IOException {
        memberDTO.setEmail(memberDTO.getEmail() + memberDTO.getDomain());
        memberService.save(memberDTO);
        System.out.println("memberDTO = " + memberDTO);
        return "index";
    }

    @PostMapping("/account-check")
    public ResponseEntity accountCheck(@RequestParam("account") String account) {
        System.out.println("account = " + account);
        String Account = memberService.isAccountInUse(account);
        if (account.length() == 0) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } else if (!account.matches("^[a-z0-9_-]{5,20}$")) {
            return new ResponseEntity(HttpStatus.BAD_REQUEST);
        } else if (Account == null){
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        }
    }

    @PostMapping("/password-check")
    public ResponseEntity passwordCheck(@RequestParam("password") String password) {
        if (password.length() == 0) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } else if (!password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,16}$")) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        } else {
            return new ResponseEntity<>(HttpStatus.OK);
        }
    }

    @PostMapping("/password-confirm")
    public ResponseEntity passwordConfirm(@RequestParam("password") String password, @RequestParam("passwordConfirm") String passwordConfirm) {
        if (passwordConfirm.length() == 0) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } else if (password.equals(passwordConfirm)) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/nickname-check")
    public ResponseEntity nicknameCheck(@RequestParam("nickname") String nickname) {
        System.out.println("nickname = " + nickname);
        String Nickname = memberService.isNicknameInUse(nickname);
        if (nickname.length() == 0) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } else if (!nickname.matches("^[가-힣a-zA-Z0-9]{1,6}$")) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        } else if (Nickname == null) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        }
    }

    @PostMapping("/name-check")
    public ResponseEntity nameCheck(@RequestParam("name") String name) {
        if (name.length() == 0) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } else if (!name.matches("^[가-힣a-zA-Z]*$")) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        } else {
            return new ResponseEntity<>(HttpStatus.OK);
        }
    }

    @PostMapping("email-check")
    public ResponseEntity emailCheck(@RequestParam("email") String email) {
        String Email = memberService.isEmailInUse(email);
        if (email.length() == 0) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } else if (Email == null) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.CONFLICT);
        }
    }

    @GetMapping("/mailAuth")
    @ResponseBody
    public String mailCheck(String email) {
        System.out.println("인증 요청");
        System.out.println("인증 이메일"+email);
        return mailSendService.joinEmail(email);
    }



}
