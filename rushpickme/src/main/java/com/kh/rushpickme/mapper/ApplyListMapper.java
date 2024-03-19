package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.dto.ApplyDto;

@Service
public class ApplyListMapper implements RowMapper<ApplyDto>{

	@Override
	public ApplyDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ApplyDto applyDto = new ApplyDto();
		applyDto.setApplyNo(rs.getInt("apply_no"));
		applyDto.setMemberId(rs.getString("member_id"));
		applyDto.setApplyArea(rs.getString("apply_area"));
		applyDto.setApplyPost(rs.getString("apply_post"));
		applyDto.setApplyAddress1(rs.getString("apply_address1"));
		applyDto.setApplyAddress2(rs.getString("apply_address2"));
		applyDto.setApplySay(rs.getNString("apply_say"));
		applyDto.setApplyWay(rs.getString("apply_way"));
		applyDto.setApplyWeight(rs.getInt("apply_weight"));
		applyDto.setApplyVinyl(rs.getInt("apply_vinyl"));
		applyDto.setApplyHopeDate(rs.getString("apply_hope_date"));
		applyDto.setApplyCancel(rs.getString("apply_cancel"));
		applyDto.setApplyDate(rs.getDate("apply_date"));
		applyDto.setApplyState(rs.getString("apply_state"));
		
		return applyDto;
		
	}

}
