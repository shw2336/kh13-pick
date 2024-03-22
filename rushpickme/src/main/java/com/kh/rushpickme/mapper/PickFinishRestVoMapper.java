package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.vo.PickFinishRestVo;

@Service
public class PickFinishRestVoMapper implements RowMapper<PickFinishRestVo>{

	@Override
	public PickFinishRestVo mapRow(ResultSet rs, int rowNum) throws SQLException {
		PickFinishRestVo pickFinishRestVo = new PickFinishRestVo();
		pickFinishRestVo.setPickNo(rs.getInt("pick_no"));
		pickFinishRestVo.setApplyDate(rs.getString("apply_date"));
		pickFinishRestVo.setPickFinishDate(rs.getString("pick_finish_date"));
		pickFinishRestVo.setPickPay(rs.getInt("pick_pay"));
		
		return pickFinishRestVo;
	}
	

}
