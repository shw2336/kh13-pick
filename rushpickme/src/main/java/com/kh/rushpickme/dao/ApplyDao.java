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
				+ "apply_area, apply_post, apply_address1,apply_address2, apply_say, apply_way, apply_weight, "
				+ "apply_vinyl, apply_hope_date) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[]data = {applyDto.getApplyNo(), applyDto.getMemberId(), applyDto.getApplyArea(),
				applyDto.getApplyPost(), applyDto.getApplyAddress1(), applyDto.getApplyAddress2(),
				applyDto.getApplySay(),applyDto.getApplyWay(), applyDto.getApplyWeight(), 
				applyDto.getApplyVinyl(), applyDto.getApplyHopeDate()
		};
		jdbcTemplate.update(sql, data);
	}
	//첨부 파일 연결
	public void connect(int applyNo, int attachNo ) {
		String sql ="insert into apply_attach (apply_no, attach_no) VALUES (?, ?)";
		Object[]data = {applyNo,attachNo};
		jdbcTemplate.update(sql,data);
	}
	public int getSequence() {
		String sql = "select apply_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	
	
	
	//수거 신청 취소 
	
	//수거 상태 이용 상세 내역( 신청->대기->완료)
	
	
	
	//최종 결제 내역 조회
	
	//
		
		
	}



