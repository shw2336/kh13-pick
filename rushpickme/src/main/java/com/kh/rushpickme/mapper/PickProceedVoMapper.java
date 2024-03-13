package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.vo.PickProceedVo;

@Service
public class PickProceedVoMapper implements RowMapper<PickProceedVo> {

	@Override
	public PickProceedVo mapRow(ResultSet rs, int rowNum) throws SQLException {
		PickProceedVo pickProceedVo = new PickProceedVo();
		pickProceedVo.setPickNo(rs.getInt("pick_no"));
		pickProceedVo.setApplyAddress1(rs.getString("apply_address1"));
		pickProceedVo.setApplyVinyl(rs.getInt("apply_vinyl"));
		pickProceedVo.setApplyDate(rs.getDate("apply_date"));
		pickProceedVo.setApplyHopeDate(rs.getDate("apply_hope_date"));
		pickProceedVo.setTimePasses(rs.getString("time_passes"));
		return pickProceedVo;
	}

}
