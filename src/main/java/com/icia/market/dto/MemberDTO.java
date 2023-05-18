package com.icia.market.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@ToString
public class MemberDTO {
    private Long id;
    private String email;
    private String password;
    private String nickName;
    private String name;
    private String mobile;
    private int profileAttached;
    private MultipartFile profile;

}
