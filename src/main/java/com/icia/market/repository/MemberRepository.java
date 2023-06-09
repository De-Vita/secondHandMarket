package com.icia.market.repository;

import com.icia.market.dto.MemberDTO;
import com.icia.market.dto.MemberProfileDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberRepository {
    @Autowired
    SqlSessionTemplate sql;
    public MemberDTO save(MemberDTO memberDTO) {
         sql.insert("Member.save", memberDTO);
         return memberDTO;
    }

    public void saveFile(MemberProfileDTO memberProfileDTO) {
        sql.insert("Member.saveFile", memberProfileDTO);
    }

    public String isAccountInUse(String account) {
        return sql.selectOne("Member.isAccountInUse", account);
    }

    public String isNicknameInUse(String nickname) {
        return sql.selectOne("Member.isNicknameInUse", nickname);
    }

    public String isEmailInUse(String email) {
        return sql.selectOne("Member.isEmailInUse", email);
    }


    public MemberDTO login(MemberDTO memberDTO) {
        return sql.selectOne("Member.login", memberDTO);
    }

    public MemberDTO findById(Long loginId) {
        return sql.selectOne("Member.findById", loginId);
    }

    public MemberProfileDTO findFile(Long loginId) {
        return sql.selectOne("Member.findFile", loginId);
    }

    public void delete(Long loginId) {
        sql.delete("Member.delete", loginId);
    }

    public void deleteProfile(Long loginId) {
        sql.delete("Member.deleteProfile", loginId);
    }

    public MemberDTO update(MemberDTO memberDTO) {
        sql.update("Member.update", memberDTO);
        return memberDTO;
    }

    public void updatePass(MemberDTO memberDTO) {
        sql.update("Member.updatePass", memberDTO);
    }

    public void updateEmail(MemberDTO memberDTO) {
        sql.update("Member.updateEmail", memberDTO);
    }
}
