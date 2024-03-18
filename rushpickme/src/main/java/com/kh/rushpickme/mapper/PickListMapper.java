package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.dto.PickDto;

@Service
public class PickListMapper implements RowMapper<PickDto> {

	@Override
	public PickDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		PickDto pickDto = new PickDto();
		pickDto.setPickNo(rs.getInt("pick_no"));
		pickDto.setApplyNo(rs.getInt("apply_no"));
		pickDto.setMemberId(rs.getString("member_id"));
		pickDto.setPickWeight(rs.getInt("pick_weight"));
		pickDto.setPickPay(rs.getInt("pick_pay"));
		pickDto.setPickState(rs.getString("pick_state"));
		pickDto.setPickReject(rs.getString("pick_reject"));
		pickDto.setPickDelete(rs.getString("pick_delete"));
		pickDto.setPickFinishDate(rs.getDate("pick_finish_date"));
		
		return pickDto;
	}

}
