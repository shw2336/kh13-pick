package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.dto.BuyDto;

@Service
public class BuyMapper implements RowMapper<BuyDto> {

	@Override
	public BuyDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		BuyDto buyDto = new BuyDto();
		buyDto.setBuyNo(rs.getInt("buy_no"));
		buyDto.setMemberId(rs.getString("member_id"));
		buyDto.setPointNo(rs.getInt("point_no"));
		buyDto.setBuyDate(rs.getDate("buy_date"));
		buyDto.setBuyQty(rs.getInt("buy_qty"));
		buyDto.setBuyTotal(rs.getInt("buy_total"));
		buyDto.setPointName(rs.getString("point_name"));
		return buyDto;
	}
	
	 
}
