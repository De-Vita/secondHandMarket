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
        if (memberDTO.getProfile().isEmpty()) {
            System.out.println("파일X");
            memberDTO.setProfileAttached(0);
            memberRepository.save(memberDTO);
        } else {
            System.out.println("파일O");
            memberDTO.setProfileAttached(1);
            MemberDTO dto = memberRepository.save(memberDTO);
            String originalFilename = memberDTO.getProfile().getOriginalFilename();
            String storedFilename = UUID.randomUUID().toString() + "-" + originalFilename;
            MemberProfileDTO memberProfileDTO = new MemberProfileDTO();
            memberProfileDTO.setOriginalFileName(originalFilename);
            memberProfileDTO.setStoredFileName(storedFilename);
            memberProfileDTO.setMemberId(dto.getId());
            String savePath = "D:\\springframework_img\\" + storedFilename;
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
}
