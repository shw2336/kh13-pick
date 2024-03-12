package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.vo.PickWaitVo;

@Service
public class PickWaitVoMapper implements RowMapper<PickWaitVo> {

	@Override
	public PickWaitVo mapRow(ResultSet rs, int rowNum) throws SQLException {
		PickWaitVo pickWaitVo = new PickWaitVo();
		pickWaitVo.setApplyNo(rs.getInt("apply_no"));
		pickWaitVo.setApplyAddress1(rs.getString("apply_address1"));
		pickWaitVo.setApplyVinyl(rs.getInt("apply_vinyl"));
		pickWaitVo.setApplyDate(rs.getDate("apply_date"));
		pickWaitVo.setApplyHopeDate(rs.getDate("apply_hope_date"));
		return pickWaitVo;
	}

}
