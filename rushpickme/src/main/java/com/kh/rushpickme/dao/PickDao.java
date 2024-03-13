package com.kh.rushpickme.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.rushpickme.dto.PickDto;
import com.kh.rushpickme.mapper.PickFinishVoMapper;
import com.kh.rushpickme.mapper.PickMapper;
import com.kh.rushpickme.mapper.PickWaitVoMapper;
import com.kh.rushpickme.vo.PageVO;
import com.kh.rushpickme.vo.PickFinishVo;
import com.kh.rushpickme.vo.PickWaitVo;

@Repository
public class PickDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private PickMapper pickMapper;
	
	@Autowired
	private PickFinishVoMapper pickFinishVoMapper;
	
	@Autowired
	private PickWaitVoMapper pickWaitVoMapper;

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
				+ "values (pick_seq.nextval, ?, ?, '수거거부', ?)";
		Object[] data = {pickDto.getApplyNo(), pickDto.getMemberId(),
				pickDto.getPickState(), pickDto.getPickReject()};
		jdbcTemplate.update(sql, data);
	}
	
	//신청상태를 접수거부로 변경 (신청 했는데 거부되는 경우)
	public boolean updateApplyStateReject (int applyNo) {
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
	
	//수거완료시간 업데이트
	public boolean updateFinishDate (int pickNo) {
		String sql = "update pick set pick_finish_date = sysdate where pick_no = ?";
		Object[] data = {pickNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//수거거부등록(현장에서 수거를 거부하게 되는 경우)
	public boolean updateNo (PickDto pickDto) {
		String sql = "update pick set pick_state = ?, pick_reject = ? "
				+ "where pick_no = ?";
		Object[] data = {pickDto.getPickState(), pickDto.getPickReject(), pickDto.getPickNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//삭제
	public boolean delete (int pickNo) {
		String sql = "update pick set pick_delete = 'Y' where pick_no = ?";
		Object[] data = {pickNo};
		return jdbcTemplate.update(sql, data) > 0;
	}

	
	//수거 완료 리스트 (신청시간기준 최신 5건만 보여주는)
	public List<PickFinishVo> pickFinishList () {
		String sql = "select pick_no, apply_date, pick_finish_date, pick_pay from "
				+ "(select pick_no, apply_date, pick_finish_date, pick_pay from pick  inner join apply on pick.apply_no = apply.apply_no "
				+ "where pick_state = '수거완료' order by apply_date desc) "
				+ "where rownum <= 5";
		return jdbcTemplate.query(sql, pickFinishVoMapper);
	}
	
	public List<PickWaitVo> waitList () {
		String sql = "select apply_no, apply_address1, apply_vinyl, apply_date, apply_hope_date from apply order by apply_hope_date asc";
		return jdbcTemplate.query(sql, pickWaitVoMapper);
	}
		//목록+페이징
	// - page : 현재 조회할 페이지 번호
	// - size : 조회할 페이지의 출력개수
	// - 위 두개를 이용하여 시작행(beginRow)과 종료행(endRow)를 계산
	public List <PickWaitVo> waiyListByPaging (PageVO pageVo) {
		String sql = "select * from ("
				+ "select rownum RN, T.* from ("
				+ "select apply_no, apply_address1, apply_vinyl, apply_date, apply_hope_date "
				+ " from apply order by apply_hope_date asc"
				+ ")T "
				+ ") where RN between ? and ?";
		Object[] data = {pageVo.getBeginRow(), pageVo.getEndRow()};
		return jdbcTemplate.query(sql, pickWaitVoMapper, data);
	}
	
	public int listCnt (PageVO pageVo) {
		String sql = "select count(*) from apply where apply_state = '신청'";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	
	//전체 신청건수
	public int countApply () {
		String sql = "select count(*) from apply where apply_state = '신청완료'";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	//오래된 신청건수 (신청한지 6시간 지난 것)
	public int countUrgentApply () {
		String sql = "SELECT count(*) FROM apply WHERE ROUND((sysdate - apply_date) * 24, 2) > 6";
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










