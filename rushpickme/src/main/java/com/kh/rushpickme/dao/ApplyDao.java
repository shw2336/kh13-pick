package com.kh.rushpickme.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.rushpickme.dto.ApplyDto;
import com.kh.rushpickme.mapper.ApplyListVOMapper;
import com.kh.rushpickme.mapper.ApplyMapper;
import com.kh.rushpickme.vo.ApplyListVO;
import com.kh.rushpickme.vo.PageVO;


@Repository
public class ApplyDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ApplyMapper applyMapper;
	
	@Autowired
	private ApplyListVOMapper applyListVOMapper;
	

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
	//조회
	public ApplyDto selectOne(int applyNo) {
		String sql = "select * from apply where apply_no = ?";
		Object[] data = {applyNo};
		List<ApplyDto> list = jdbcTemplate.query(sql, applyMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	//수거 신청 목록 과 관련된 내용 
	public List<ApplyDto> state(int applyNo, String MemeberId, ApplyDto appltDto) {
		String sql="select * from apply where apply_no = ?";
		return jdbcTemplate.query(sql, applyMapper);
		
	}

	//수거 신청 목록 과 관련된 내용 
	public List<ApplyDto> requsetList() {
		String sql="select * from apply ";
		return jdbcTemplate.query(sql, applyMapper);
		
	}
	
	
	//수거 신청 (삭제, Delete)
	public boolean cancel(int applyNo) {
		String sql = "delete apply where apply_no = ?";
		Object[] data = {applyNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
//		//멤버아이디로 신청 내역 뽑기
//		public List<ApplyListVO> applyList(String memberId) {
//			String sql ="SELECT member_id, apply_no, apply_address1, apply_vinyl,apply_date, apply_hope_date, pick_pay FROM ( SELECT apply.member_id, apply.apply_no, apply_address1, apply_vinyl, apply_date, apply_hope_date, pick_pay from apply INNER JOIN pick ON apply.apply_no = pick.apply_no)where member_id =? ";
//			Object[]data = {memberId};
//			return jdbcTemplate.query(sql,applyListVOMapper , data);
//		}
//		//전체 리스트 조회 
//			public List<ApplyListVO> applyList() {
//				String sql="SELECT member_id, apply_no, apply_address1, apply_vinyl, apply_date, apply_hope_date, pick_pay FROM ( SELECT apply.member_id, apply.apply_no, apply_address1, apply_vinyl, apply_date, apply_hope_date, pick_pay, apply_state FROM apply INNER JOIN pick ON apply.apply_no = pick.apply_no) WHERE apply_state LIKE '신청완료' ORDER BY apply_hope_date ASC";
//				return jdbcTemplate.query(sql, applyListVOMapper);
//			}
//////////////////////////////////////////////////////////////////////////////////////////////////////////

	

		
	}



