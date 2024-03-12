package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.dto.PointDto;

@Service
public class PointMapper implements RowMapper<PointDto> {

	@Override
	public PointDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		PointDto pointDto = new PointDto();
		pointDto.setPointNo(rs.getInt("point_no"));
		pointDto.setPointName(rs.getString("point_name"));
		pointDto.setPointSell(rs.getInt("point_sell"));
		pointDto.setPointCharge(rs.getInt("point_charge"));
		return pointDto;
	}
}