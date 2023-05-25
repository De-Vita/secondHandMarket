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
}
