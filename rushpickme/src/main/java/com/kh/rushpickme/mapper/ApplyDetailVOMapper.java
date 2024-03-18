package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.vo.ApplyDetailVO;

@Service
public class ApplyDetailVOMapper implements RowMapper<ApplyDetailVO>{

	@Override
	public ApplyDetailVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		ApplyDetailVO applyDetailVO = new ApplyDetailVO();
		applyDetailVO.setApplyPost(rs.getString("apply_post"));
		applyDetailVO.setApplyAddress1(rs.getString("apply_address1"));
		applyDetailVO.setApplyAddress2(rs.getString("apply_address2"));
		applyDetailVO.setApplyVinyl(rs.getInt("apply_vinyl"));
		applyDetailVO.setApplyHopeDate(rs.getString("apply_hope_date"));
		applyDetailVO.setApplySay(rs.getString("apply_say"));
		applyDetailVO.setApplyWay(rs.getString("apply_way"));
		
		return applyDetailVO;
	}

}
