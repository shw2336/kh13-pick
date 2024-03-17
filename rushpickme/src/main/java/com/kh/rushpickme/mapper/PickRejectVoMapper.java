package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.vo.PickRejectVo;

@Service
public class PickRejectVoMapper implements RowMapper<PickRejectVo>{

	@Override
	public PickRejectVo mapRow(ResultSet rs, int rowNum) throws SQLException {
		PickRejectVo pickRejectVo = new PickRejectVo();
		pickRejectVo.setApplyNo(rs.getInt("apply_no"));
		pickRejectVo.setPickNo(rs.getInt("pick_no"));
		pickRejectVo.setMemberId(rs.getString("member_id"));
		pickRejectVo.setApplyDate(rs.getDate("apply_date"));
		pickRejectVo.setPickReject(rs.getString("pick_reject"));
		return pickRejectVo;
	}

}
