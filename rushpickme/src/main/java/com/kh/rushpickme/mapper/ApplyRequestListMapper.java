package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;


import com.kh.rushpickme.vo.ApplyRequestListVo;
@Service
public class ApplyRequestListMapper implements RowMapper<ApplyRequestListVo>{

	@Override
	public ApplyRequestListVo mapRow(ResultSet rs, int rowNum) throws SQLException {
		ApplyRequestListVo applyRequestListVo = new ApplyRequestListVo();
		applyRequestListVo.setApplyNo(rs.getInt("apply_no"));
		applyRequestListVo.setApplyAddress1(rs.getString("apply_address1"));
		applyRequestListVo.setApplyVinyl(rs.getInt("apply_vinyl"));
		applyRequestListVo.setApplyHopeDate(rs.getString("apply_hope_date"));
		applyRequestListVo.setPickPay(rs.getInt("pick_pay"));
		return applyRequestListVo;
	}

}
