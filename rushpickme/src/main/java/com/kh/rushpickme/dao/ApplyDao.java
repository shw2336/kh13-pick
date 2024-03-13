package com.kh.rushpickme.dao;

import java.util.List;

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
				+ "apply_area, apply_post, apply_address1,apply_address2, apply_say,apply_way, apply_weight, "
				+ "apply_vinyl, apply_hope_date,apply_date) values (apply_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[]data = {applyDto.getMemberId(), applyDto.getApplyArea(),
				applyDto.getApplyPost(), applyDto.getApplyAddress1(), applyDto.getApplyAddress2(),
				applyDto.getApplySay(),applyDto.getApplyWay(), applyDto.getApplyWeight(), 
				applyDto.getApplyVinyl(), applyDto.getApplyHopeDate(),applyDto.getApplyState()
		};
		jdbcTemplate.update(sql, data);
	}
	//첨부 파일 등록 
	public void connect(String memberId, int attachNo ) {
		String sql ="select attach_no from apply_attach where member_id = ?";
		Object[]data = {memberId,attachNo};
		
		jdbcTemplate.update(sql,data);
	}
	//수거 신청 취소 
	
	//수거 상태 이용 상세 내역( 신청->대기->완료)
	
	
	
	//최종 결제 내역 조회
	
	//
		
	
	//번호를 미리 뽑기 
	//왜 두개를 등록?
		//- 번호가 필요하니까...
			public int getSequence() {
				String sql = "select apply_seq.nextval from dual";
				return jdbcTemplate.queryForObject(sql, int.class);
			}
			//등록할 때 시퀀스 번호를 생성하면 절대 안된다
			public void insert(ApplyDto applyDto) {
				String sql ="insert into apply (apply_no, member_id, "
						+ "apply_area, apply_post, apply_address1,apply_address2, apply_say,apply_way, apply_weight, "
						+ "apply_vinyl, apply_hope_date,apply_date) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				Object[]data = {applyDto.getMemberId(), applyDto.getApplyArea(),
						applyDto.getApplyPost(), applyDto.getApplyAddress1(), applyDto.getApplyAddress2(),
						applyDto.getApplySay(),applyDto.getApplyWay(), applyDto.getApplyWeight(), 
						applyDto.getApplyVinyl(), applyDto.getApplyHopeDate(),applyDto.getApplyState()
				};
				jdbcTemplate.update(sql, data);
			}
			public boolean delete(int applyNo) {
				String sql = "delete apply where apply_no = ?";
				Object[] data = {applyNo};
				return jdbcTemplate.update(sql, data) > 0;
			}
			
			
			//상세(조회, Read)
			public ApplyDto selectOne(String memberId) {
				String sql = "select * from apply where member_id = ?";
				Object[] data = {memberId};
				List<ApplyDto> list = jdbcTemplate.query(sql, applyMapper, data);
				return list.isEmpty() ? null : list.get(0);
			}
		
	}



