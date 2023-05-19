package com.icia.market.controller;

import com.icia.market.dto.MemberDTO;
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
    @GetMapping("/save")
    public String saveForm() {
        return "memberPages/memberSave";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute MemberDTO memberDTO) throws IOException {
        memberService.save(memberDTO);
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

}
