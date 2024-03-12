package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.vo.PickFinishVo;

@Service
public class PickFinishVoMapper implements RowMapper<PickFinishVo> {

	@Override
	public PickFinishVo mapRow(ResultSet rs, int rowNum) throws SQLException {
		PickFinishVo pickFinishVo = new PickFinishVo();
		pickFinishVo.setPickNo(rs.getInt("pick_no"));
		pickFinishVo.setApplyDate(rs.getDate("apply_date"));
		pickFinishVo.setPickFinishDate(rs.getDate("pick_finish_date"));
		pickFinishVo.setPickPay(rs.getInt("pick_pay"));
		return pickFinishVo;
	}
	
	
	
}
