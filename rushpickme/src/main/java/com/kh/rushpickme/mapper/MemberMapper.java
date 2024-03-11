package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.dto.MemberDto;

@Service
public class MemberMapper implements RowMapper<MemberDto> {

	@Override
	public MemberDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberDto dto = new MemberDto();
		dto.setMemberId(rs.getString("member_id"));
		dto.setMemberPw(rs.getString("member_pw"));
		dto.setMemberNick(rs.getString("member_nick"));
		dto.setMemberContact(rs.getString("member_contact"));
		dto.setMemberName(rs.getString("member_name"));
		dto.setMemberType(rs.getString("member_type"));
		dto.setMemberEmail(rs.getString("member_email"));
		dto.setMemberBirth(rs.getString("member_birth"));
		return dto;
	}
	

}
