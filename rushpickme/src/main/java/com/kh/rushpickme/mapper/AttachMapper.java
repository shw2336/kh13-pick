package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.dto.AttachDto;

@Service
public class AttachMapper implements RowMapper<AttachDto> {

	@Override
	public AttachDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		AttachDto attachDto = new AttachDto();
		attachDto.setAttachNo(rs.getInt("attach_no"));
		attachDto.setAttachName(rs.getString("attach_name"));
		attachDto.setAttachType(rs.getString("attach_type"));
		attachDto.setAttachSize(rs.getLong("attach_size"));
		return attachDto;
	}
}
