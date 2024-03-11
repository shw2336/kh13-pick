package com.kh.rushpickme.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.rushpickme.dto.ApplyDto;
import com.kh.rushpickme.mapper.ApplyMapper;

@Repository
public class ApplyDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ApplyMapper applyMapper;

	//수거 신청 등록
	public void applyInsert(ApplyDto applyDto) {
		String sql ="insert into apply (apply_no, member_id, "
				+ "apply_area, apply_post, apply_address1,apply_address2, apply_way, "
				+ "apply_vinyl, apply_hope_date) values (apply_seq.nextval, ?, ?, ?, ? ,? ,? ,? ,?)";
		Object[]data = {applyDto.getApplyNo(),applyDto.getMemberId(), applyDto.getApplyArea(),
				applyDto.getApplyPost(), applyDto.getApplyAddress1(), applyDto.getApplyAddress2(),
				applyDto.getApplyWay(),applyDto.getApplyVinyl(), applyDto.getApplyHopeDate()};
		jdbcTemplate.update(sql,data);
		}
	}

