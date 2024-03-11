package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.dto.MemberPickDto;

@Service
public class MemberPickMapper implements RowMapper<MemberPickDto> {

	@Override
	public MemberPickDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberPickDto dto = new MemberPickDto();
		dto.setMemberId(rs.getString("member_id"));
		dto.setMemberPickArea(rs.getString("member_pick_area"));
		
		return dto;
	}
	

}
