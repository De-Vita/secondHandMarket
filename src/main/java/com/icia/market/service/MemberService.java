package com.icia.market.service;

import com.icia.market.dto.MemberDTO;
import com.icia.market.dto.MemberProfileDTO;
import com.icia.market.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Service
public class MemberService {
    @Autowired
    MemberRepository memberRepository;
    public void save(MemberDTO memberDTO) throws IOException {
        if (memberDTO.getProfile() != null && !memberDTO.getProfile().isEmpty()) {
            // 파일 선택한 경우
            MemberDTO dto = memberRepository.save(memberDTO);
            String originalFilename = memberDTO.getProfile().getOriginalFilename();
            String storedFilename = UUID.randomUUID().toString() + "-" + originalFilename;
            MemberProfileDTO memberProfileDTO = new MemberProfileDTO();
            memberProfileDTO.setOriginalFileName(originalFilename);
            memberProfileDTO.setStoredFileName(storedFilename);
            memberProfileDTO.setMemberId(dto.getId());
            String savePath = "C:\\springframework_img\\" + storedFilename;
            memberDTO.getProfile().transferTo(new File(savePath));
            memberRepository.saveFile(memberProfileDTO);
        } else {
            // 파일을 선택하지 않은 경우
            MemberDTO dto = memberRepository.save(memberDTO);
            // 기본 이미지 설정
            String defaultImageFilename = "기본이미지.png";
            MemberProfileDTO memberProfileDTO = new MemberProfileDTO();
            memberProfileDTO.setOriginalFileName(defaultImageFilename);
            memberProfileDTO.setStoredFileName(defaultImageFilename);
            memberProfileDTO.setMemberId(dto.getId());
            String savePath = "C:\\springframework_img\\" + "기본이미지.png";
            memberDTO.getProfile().transferTo(new File(savePath));
            memberRepository.saveFile(memberProfileDTO);
        }
    }

    public String isAccountInUse(String account) {
        return memberRepository.isAccountInUse(account);
    }

    public String isNicknameInUse(String nickname) {
        return memberRepository.isNicknameInUse(nickname);
    }

    public String isEmailInUse(String email) {
        return memberRepository.isEmailInUse(email);
    }


    public MemberDTO login(MemberDTO memberDTO) {
        return memberRepository.login(memberDTO);
    }

    public MemberDTO findById(Long loginId) {
        return memberRepository.findById(loginId);
    }

    public MemberProfileDTO findFile(Long loginId) {
        return memberRepository.findFile(loginId);
    }

    public void delete(Long loginId) {
        memberRepository.delete(loginId);
    }

    public void deleteProfile(Long loginId) {
        memberRepository.deleteProfile(loginId);
    }

    public void update(MemberDTO memberDTO) throws IOException {
        MemberDTO dto = memberRepository.update(memberDTO);
        memberRepository.deleteProfile(memberDTO.getId());
        System.out.println(memberDTO.getId());
        String originalFilename = memberDTO.getProfile().getOriginalFilename();
        String storedFilename = UUID.randomUUID().toString() + "-" + originalFilename;
        MemberProfileDTO memberProfileDTO = new MemberProfileDTO();
        memberProfileDTO.setOriginalFileName(originalFilename);
        memberProfileDTO.setStoredFileName(storedFilename);
        memberProfileDTO.setMemberId(dto.getId());
        memberRepository.saveFile(memberProfileDTO);
        String savePath = "C:\\springframework_img\\" + storedFilename;
        memberDTO.getProfile().transferTo(new File(savePath));
    }
}
