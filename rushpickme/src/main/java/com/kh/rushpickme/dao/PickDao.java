package com.kh.rushpickme.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.rushpickme.dto.ApplyDto;
import com.kh.rushpickme.dto.PickDto;
import com.kh.rushpickme.mapper.ApplyMapper;
import com.kh.rushpickme.mapper.MemberPickMapper;
import com.kh.rushpickme.mapper.PickFinishVoMapper;
import com.kh.rushpickme.mapper.PickListMapper;
import com.kh.rushpickme.mapper.PickMapper;
import com.kh.rushpickme.mapper.PickProceedVoMapper;
import com.kh.rushpickme.mapper.PickRejectVoMapper;
import com.kh.rushpickme.mapper.PickWaitVoMapper;
import com.kh.rushpickme.vo.PageVO;
import com.kh.rushpickme.vo.PickFinishVo;
import com.kh.rushpickme.vo.PickProceedVo;
import com.kh.rushpickme.vo.PickRejectVo;
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
	
	@Autowired
	private PickProceedVoMapper pickProceedVoMapper; 
	
	@Autowired
	private MemberPickMapper memberPickMapper;
	
	@Autowired
	private ApplyMapper applyMapper;
	
	@Autowired
	private PickRejectVoMapper pickRejectVoMapper;
	
	@Autowired
	private PickListMapper pickListMapper;

	//수거접수등록
	public void insertOk (PickDto pickDto) {
		String sql = "insert into pick "
				+ "(pick_no, apply_no, member_id, pick_schedule, pick_state) "
				+ "values (pick_seq.nextval, ?, ?, ?, '수거접수')";
		Object[] data = {pickDto.getApplyNo(), pickDto.getMemberId(), pickDto.getPickSchedule()};
		jdbcTemplate.update(sql, data);
	}
	
	//수거거부등록(신청 받자마자 거부하는 경우)
	public void insertNo (PickDto pickDto) {
		String sql = "insert into pick "
				+ "(pick_no, apply_no, member_id, pick_state, pick_reject) "
				+ "values (pick_seq.nextval, ?, ?, '수거거부', ?)";
		Object[] data = {pickDto.getApplyNo(), pickDto.getMemberId(), pickDto.getPickReject()};
		jdbcTemplate.update(sql, data);
	}

	//신청상태를 진행중으로 변경 (수거 접수한 경우)
	public boolean updateApplyStateProceed (int applyNo) {
		String sql = "update apply set apply_state = '진행중' where apply_no = ?";
		Object[] data = {applyNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//신청상태를 수거완료로 변경 
	public boolean updateApplyStateFinish (int applyNo) {
		String sql = "update apply set apply_state = '수거완료' where apply_no = ?";
		Object[] data = {applyNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//신청상태를 접수거부로 변경 (신청 했는데 거부되는 경우)
	public boolean updateApplyStateReject (int applyNo) {
		String sql = "update apply set apply_state = '접수거부' where apply_no = ?";
		Object[] data = {applyNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//신청상태를 신청완료로 변경 (신청->거부->거부취소)
	public boolean updateApplyStateWait(int applyNo) {
		String sql = "update apply set apply_state = '신청완료' where apply_no = ?";
		Object[] data = {applyNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//수거정보 수정(수거완료)
	public boolean updateInfo (PickDto pickDto) {
		String sql = "update pick set pick_weight = ?, pick_pay = ?, "
				+ "pick_state = '수거완료', pick_finish_date = sysdate where pick_no = ?";
		Object[] data = {pickDto.getPickWeight(), pickDto.getPickPay(), pickDto.getPickNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//수거거부등록(현장에서 수거를 거부하게 되는 경우)
	public boolean updateNo (PickDto pickDto) {
		String sql = "update pick set pick_state = '수거거부', pick_reject = ? "
				+ "where pick_no = ?";
		Object[] data = {pickDto.getPickReject(), pickDto.getPickNo()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//삭제 (1건)
	public boolean delete (int pickNo) {
		String sql = "update pick set pick_delete = 'Y' where pick_no = ?";
		Object[] data = {pickNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//삭제 (여러 건)
	public boolean deleteByArray (Object[] deletePicks) {
		String sql = "update pick set pick_delete = 'Y' where pick_no IN (";
		for (int i = 0; i < deletePicks.length; i ++) {
			if (i > 0) {
				sql += ",";
			}
			sql += "?";
		}
		sql += ")";
		
		return jdbcTemplate.update(sql, deletePicks) > 0;
	}
	
	//수거 완료 리스트 (신청시간기준 최신 3건만 보여주는)
	public List<PickFinishVo> pickFinishList (String memberId) {
		String sql = "select pick_no, apply_date, pick_finish_date, pick_pay from "
				+ "(select pick_no, apply_date, pick_finish_date, pick_pay from pick join apply on pick.apply_no = apply.apply_no "
				+ "where pick.pick_state like '수거완료' "
				+ "and pick.member_id like ? "
				+ "AND apply.apply_area IN ("
				+ "SELECT MEMBER_PICK_AREA FROM member_pick WHERE member_pick.member_id LIKE ?) "
				+ "and pick_delete ='N' "
				+ "order by pick_finish_date desc) "
				+ "where rownum <= 3";
		Object[] data = {memberId, memberId};
		return jdbcTemplate.query(sql, pickFinishVoMapper, data);
	}
	
	//수거 완료 리스트 전체 
	public List<PickFinishVo> pickFinishListByPaging (String memberId, PageVO pageVo) {
		String sql = "select * from ("
				+ "select rownum RN, T.* from ("
				+ "select pick_no, apply_date, pick_finish_date, pick_pay from ("
				+ "select pick_no, apply_date, pick_finish_date, pick_pay from pick "
				+ "inner join apply on pick.apply_no = apply.apply_no "
				+ "where pick_state like '수거완료' "
				+ "and pick.member_id like ? "
				+ "and pick_delete = 'N' "
				+ "and apply.apply_area in (select member_pick_area from member_pick where member_pick.member_id like ?) "
				+ "order by pick_finish_date desc)"
				+ ")T "
				+ ") where RN between ? and ?";
		Object[] data = {memberId, memberId, pageVo.getBeginRow(), pageVo.getEndRow()};
		return jdbcTemplate.query(sql, pickFinishVoMapper, data);
	}
	
	//수거 대기 리스트
	public List<PickWaitVo> waitList () {
		String sql = "select apply_no, apply_address1, apply_vinyl, apply_date, apply_hope_date "
				+ "from apply "
				+ "where apply_state like '신청완료' "
				+ "order by apply_hope_date asc";
		return jdbcTemplate.query(sql, pickWaitVoMapper);
	}

	public List <PickWaitVo> waitListByPaging (PageVO pageVo, String findArea) {
		String sql = "select * from ("
				+ "select rownum RN, T.* from ("
				+ "select apply_no, apply_address1, apply_vinyl, apply_date, apply_hope_date "
				+ "from apply "
				+ "where apply_state like '신청완료' "
				+ "and apply_area like ? "
				+ "order by apply_hope_date asc"
				+ ")T "
				+ ") where RN between ? and ?";
		Object[] data = {findArea, pageVo.getBeginRow(), pageVo.getEndRow()};
		return jdbcTemplate.query(sql, pickWaitVoMapper, data);
	}
	
	// 진행중 리스트, 신청자의 수거희망일이 지나버렸는지 확인하여 리스트추출 (time_passes 컬럼 추가해서 확인결과 받기)     
	public List <PickProceedVo> proceedListByPaging (String memberId, PageVO pageVo) {
		String sql = "select * from ("
				+ "select rownum RN, T.* from ("
				+ "select pick_no, apply_address1, apply_vinyl, apply_date, apply_hope_date, "
				+ "case when TRUNC(TO_DATE(apply_hope_date, 'YYYY-MM-DD HH24:MI:SS')) = TRUNC(SYSDATE) THEN 'N' "
				+ "WHEN ROUND((SYSDATE - TO_DATE(apply_hope_date, 'YYYY-MM-DD HH24:MI:SS')) * 24, 0) > 0 THEN 'Y' "
				+ "ELSE 'N' "
				+ "END AS time_passes "
				+ "from (select pick_no, apply_address1, apply_vinyl, apply_date, apply_hope_date, "
				+ "CASE WHEN ROUND((SYSDATE - TO_DATE(apply_hope_date, 'YYYY-MM-DD HH24:MI:SS')) * 24, 0) > 0 THEN 'Y' "
				+ "ELSE 'N' "
				+ "END AS time_passes "
				+ "from pick inner join apply on pick.apply_no = apply.apply_no "
				+ "where pick_state like '수거접수' and pick.member_id like ? "
				+ "order by apply_hope_date asc))T) "
				+ "where RN between ? and ?";
		Object[] data = {memberId, pageVo.getBeginRow(), pageVo.getEndRow()};
		return jdbcTemplate.query(sql, pickProceedVoMapper, data);
	}
	
	//수거 거부 리스트
	public List <PickRejectVo> rejectListByPaging (String memberId, PageVO pageVo) {
		String sql = "select * from ("
				+ "select rownum RN, T.* from ("
				+ "select apply.apply_no, pick.pick_no, apply.member_id, apply.apply_date, pick.pick_reject from pick "
				+ "join apply on pick.apply_no = apply.apply_no "
				+ "where pick.pick_state like '수거거부' "
				+ "and apply.apply_state like '접수거부' "
				+ "and pick.member_id like ? "
				+ "and apply.apply_area in (select member_pick_area from member_pick where member_pick.member_id like ?) "
				+ "order by apply_date desc)T ) "
				+ "where RN between ? and ?";
		Object[] data = {memberId, memberId, pageVo.getBeginRow(), pageVo.getEndRow()};
		return jdbcTemplate.query(sql, pickRejectVoMapper, data);
	}
	
	//신청->거부->거부취소
	public boolean rejectCancelToWait (int pickNo) {
		String sql = "delete pick where pick_no = ?";
		Object[] data = {pickNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//신청->접수(진행)->거부->거부취소
	public boolean rejectCancelToProceed (int pickNo) {
		String sql = "update pick set pick_reject = null, pick_schedule = null, pick_state = '수거접수' "
				+ "where pick_schedule is not null and pick_no = ?";
		Object[] data = {pickNo};
		return jdbcTemplate.update(sql, data) > 0;
	}

	//전체 신청건수
	public int countApply (String memberId) {
		String sql = "select count(*) from apply where apply_state like '신청완료' "
				+ "and APPLY_AREA in (select MEMBER_PICK_AREA from member_pick where member_id like ?)";
		Object[] data = {memberId};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	//오래된 신청건수 (신청한지 6시간 지난 것)
	public int countUrgentApply (String memberId) {
		String sql = "SELECT count(*) FROM apply WHERE ROUND((sysdate - apply_date) * 24, 2) > 6 "
				+ "and apply_state like '신청완료' "
				+ "and apply_area in (select member_pick_area from member_pick where member_id like ?)";
		Object[] data = {memberId};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	//수거 진행건수
	public int countProceed (String memberId) {
		String sql = "SELECT count(*) FROM pick join apply on apply.APPLY_NO = pick.APPLY_NO "
				+ "WHERE pick.pick_state LIKE '수거접수' "
				+ "and pick.member_id like ? "
				+ "AND apply.apply_area IN "
				+ "( SELECT MEMBER_PICK_AREA FROM member_pick WHERE member_pick.member_id LIKE ?)";
		Object[] data = {memberId, memberId};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	//수거 거부건수
	public int countReject (String memberId) {
		String sql = "SELECT count(*) FROM pick join apply on apply.APPLY_NO = pick.APPLY_NO "
				+ "WHERE pick.pick_state LIKE '수거거부' "
				+ "and pick.member_id like ? "
				+ "and apply.apply_area IN "
				+ "( SELECT MEMBER_PICK_AREA FROM member_pick WHERE member_pick.member_id LIKE ?)";
		Object[] data = {memberId,memberId};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	//수거 완료건수
	public int countFinish (String memberId) {
		String sql = "SELECT count(*) FROM pick join apply on apply.apply_no = pick.apply_no "
				+ "WHERE pick.pick_state LIKE '수거완료' "
				+ "and pick.member_id like ? "
				+ "and apply.apply_area IN ("
				+ "SELECT MEMBER_PICK_AREA FROM member_pick WHERE member_pick.member_id LIKE ?)";
		Object[] data = {memberId, memberId};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	//수거자 근무지 조회
	public String pickArea (String memberId) {
		String sql = "select member_pick_area from member_pick where member_id = ?";
		Object[] data = {memberId};
	    List<String> list = jdbcTemplate.queryForList(sql, String.class, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//신청정보 조회
	public ApplyDto selectOneByApply (int applyNo) {
		String sql = "select * from apply where apply_no = ?";
		Object[] data = {applyNo};
	    List<ApplyDto> list = jdbcTemplate.query(sql, applyMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//수거정보 조회
	public PickDto selectOneByPick (int pickNo) {
		String sql = "select * from pick where pick_no = ?";
		Object[] data = {pickNo};
		List<PickDto> pickDto = jdbcTemplate.query(sql, pickMapper, data);
		return pickDto.isEmpty() ? null : pickDto.get(0);
	}
	
	//applyNo 조회 (pickNo로)
	public int selectApplyNo (int pickNo) {
		String sql = "select apply_no from pick where pick_no = ?";
		Object[] data = {pickNo};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	//pickNo 조회 (applyNo로)
	public int selectPickNo (int applyNo) {
		String sql = "select pick_no from pick where apply_no = ?";
		Object[] data = {applyNo};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	// 신청자가 넣은 사진 찾기
	public int applyAttachNo (int applyNo) {
		String sql = "select attach_no from apply_attach where apply_no = ?";
		Object[] data = {applyNo};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	//수거자가 넣은 사진 찾기
	public int pickAttachNo (int pickNo) {
		String sql = "select attach_no from pick_attach where pick_no = ?";
		Object[] data = {pickNo};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	public void connect(int pickNo, int attachNo) {
		String sql = "insert into pick_attach(pick_no, attach_no) values (?, ?)";
		Object[] data = {pickNo, attachNo};
		jdbcTemplate.update(sql, data);
	}

	//////////////////////////////////////////////////////////////////////////////////////
	//모든 수거건을 조회 (서영)
	public List<PickDto> getPickList(){
	    String sql = "select * from pick ";
		return jdbcTemplate.query(sql, pickMapper);
	}
	
	//통합+페이징
	public List<PickDto> selectListByPaging(PageVO pageVO) {
//		if(pageVO.isSearch()) {
//			String sql = "select * from ("
//					+ "select rownum rn, TMP.* from ("
//					+ "select "
//					+ "pick_no, apply_no, member_id, pick_weight, pick_pay, "
//					+ "pick_schedule, pick_state, pick_reject, pick_delete, pick_finish_date "
//					+ "from pick "
//					+ "where instr("+pageVO.getColumn()+", ?) > 0 "
//							+ ")TMP"
//							+ ") where rn between ? and ?";
//			Object[] data = {
//					pageVO.getKeyword(),
//					pageVO.getBeginRow(),
//					pageVO.getEndRow()
//			};
//			return jdbcTemplate.query(sql, pickMapper, data);
//		}
//		else {
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select "
					+ "pick_no, apply_no, member_id, pick_weight, pick_pay, "
					+ "pick_schedule, pick_state, pick_reject, pick_delete, pick_finish_date "
					+ "from pick "
					+ ")TMP"
					+ ") where rn between ? and ?";
			Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, pickListMapper, data);
		//}
	}
	
	//카운트 (서영)
	public int count() {
		String sql = "select count(*) from pick";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public int count(String column, String keyword) {
		String sql = "select count(*) from pick "
				+ "where instr("+column+", ?) > 0";
		Object[] data = {keyword};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	public int count(PageVO pageVO) {
		if(pageVO.isSearch()) {
			String sql = "select coint(*) form pick "
					+ "where instr("+pageVO.getColumn()+",? ) > 0";
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {
			String sql = "select count(*) from pick";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}

	
}
	










