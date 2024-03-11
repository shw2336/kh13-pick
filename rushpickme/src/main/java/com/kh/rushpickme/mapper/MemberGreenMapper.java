package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.dto.MemberGreenDto;

@Service
public class MemberGreenMapper implements RowMapper<MemberGreenDto> {

	@Override
	public MemberGreenDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			MemberGreenDto dto = new MemberGreenDto();
			dto.setMemberId(rs.getString("member_id"));
			dto.setMemberGreenPost(rs.getString("member_green_post"));
			dto.setMemberGreenAddress1(rs.getString("member_green_address1"));
			dto.setMemberGreenAddress2(rs.getString("member_green_address2"));
			dto.setMemberGreenPoint(rs.getInt("member_green_point"));
			dto.setMemberGreenTicket(rs.getInt("member_green_ticket"));
			return dto;
	}
	
	

}
