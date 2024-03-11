package com.kh.rushpickme.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.rushpickme.dto.PickDto;
import com.kh.rushpickme.mapper.PickMapper;

@Repository
public class PickDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private PickMapper pickMapper;
	
	//수거접수등록
	public void insertOk (PickDto pickDto) {
		String sql = "insert into pick "
				+ "(pick_no, apply_no, member_id, pick_schedule) "
				+ "values (pick_seq.nextval, ?, ?, ?)";
		Object[] data = {pickDto.getApplyNo(), pickDto.getMemberId(), pickDto.getPickSchedule()};
		jdbcTemplate.update(sql, data);
	}
	
	//수거거부등록(신청 받자마자 거부하는 경우)
	public void insertNo (PickDto pickDto) {
		String sql = "insert into pick "
				+ "(pick_no, apply_no, member_id, pick_state, pick_reject) "
				+ "values (pick_seq.nextval, ?, ?, ?, ?)";
		Object[] data = {pickDto.getApplyNo(), pickDto.getMemberId(),
				pickDto.getPickState(), pickDto.getPickReject()};
		jdbcTemplate.update(sql, data);
	}
	
	//신청상태를 접수거부로 변경 (신청 했는데 거부되는 경우)
	public boolean updateApplyState (int applyNo) {
		String sql = "update apply set apply_state = '접수거부' where apply_no = ?";
		Object[] data = {applyNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//수거정보 수정(수거완료)
	public boolean updateInfo (PickDto pickDto) {
		String sql = "update pick set pick_weight = ?, pick_pay = ? "
				+ "pick_state = ? where pick_no = ?";
		Object[] data = {pickDto.getPickWeight(), pickDto.getPickPay(), 
				pickDto.getPickState(), pickDto.getPickNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//수거거부등록(현장에서 수거를 거부하게 되는 경우)
	public boolean updateNo (PickDto pickDto) {
		String sql = "update pick set pick_state = ?, pick_reject = ? "
				+ "where pick_no = ?";
		Object[] data = {pickDto.getPickState(), pickDto.getPickReject(), pickDto.getPickNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//삭제 방법생각하기..

	//전체 신청건수
	public int countApply () {
		String sql = "select count(*) from apply where apply_state = '신청'";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	//오래된 신청건수 (신청한지 6시간 지난 것)
	public int countUrgentApply () {
		String sql = "SELECT count(*) FROM apply WHERE EXTRACT(HOUR FROM (SYSTIMESTAMP - apply_date)) > 6";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	//수거 진행건수
	public int countProceed () {
		String sql = "select count(*) from pick where pick_state = '수거접수'";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	//수거 거부건수
	public int countReject () {
		String sql = "select count(*) from pick where pick_state = '수거거부'";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	
	
}










