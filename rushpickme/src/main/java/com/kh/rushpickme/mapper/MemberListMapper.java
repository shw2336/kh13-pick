package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.dto.MemberDto;

@Service
public class MemberListMapper implements RowMapper<MemberDto>{

	@Override
	public MemberDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberDto memberDto = new MemberDto();
		memberDto.setMemberId(rs.getString("member_id"));
		memberDto.setMemberPw(rs.getString("member_pw"));
		memberDto.setMemberNick(rs.getString("member_nick"));
		memberDto.setMemberContact(rs.getString("member_contact"));
		memberDto.setMemberName(rs.getString("member_name"));
		memberDto.setMemberType(rs.getString("member_type"));
		memberDto.setMemberEmail(rs.getString("member_email"));
		memberDto.setMemberBirth(rs.getString("member_birth"));
		return memberDto;
	}

}
