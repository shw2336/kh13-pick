package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.vo.ApplyListVO;

@Service
public class ApplyListVOMapper implements RowMapper<ApplyListVO> {

	@Override
	public ApplyListVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		ApplyListVO applyListVO = new ApplyListVO();
		applyListVO.setMemberId(rs.getString("member_id"));
		applyListVO.setApplyNo(rs.getInt("apply_no"));
		applyListVO.setApplyAddress1(rs.getString("apply_address1"));
		applyListVO.setApplyVinyl(rs.getInt("apply_vinyl"));
		applyListVO.setApplyDate(rs.getDate("apply_date"));
		applyListVO.setApplyHopeDate(rs.getString("apply_hope_Date"));
		applyListVO.setPickPay(rs.getInt("apply_pay"));
		
		return applyListVO;
	}
	

}