package com.kh.rushpickme.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.rushpickme.dto.ApplyDto;
import com.kh.rushpickme.mapper.ApplyMapper;
import com.kh.rushpickme.mapper.ApplyRequestListMapper;
import com.kh.rushpickme.vo.ApplyRequestListVo;
import com.kh.rushpickme.vo.PageVO;


@Repository
public class ApplyDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ApplyMapper applyMapper;
	
	@Autowired
	private ApplyRequestListMapper applyRequestListMapper;

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
	//수거 신청 취소 
	public boolean requestCancel(int applyNo) {
		String sql="update apply set apply_cancel = 'Y' where apply_no = ?" ;
		Object[]data = {applyNo};
		return jdbcTemplate.update(sql,data)>0;
	}
	//수거 신청 리스트 전체
	public List<ApplyRequestListVo> requestListByPaging(PageVO pageVo, int applyNo ) {
		String sql= "select * from ("
				+ "select rownum RN, T.* from ("
				+ "select apply_no, apply_address1, apply_vinyl, apply_hope_date, pick_pay from apply where apply_state like '신청완료' and apply_no like ? "
				+ "order by apply_hope_date asc"
				+ ")T "
				+ ") where RN between ? and ?";
//		String sql="select apply_no, apply_address1, apply_vinyl, apply_hope_date, pick_pay FROM ("
//				+ "SELECT apply.apply_no, apply_address1, apply_vinyl, apply_hope_date, pick_pay "
//				+ "from apply INNER JOIN pick ON apply.apply_no = pick.apply_no)";
		Object[]data = {applyNo,pageVo.getBeginRow(),pageVo.getEndRow() };
		return jdbcTemplate.query(sql, applyRequestListMapper ,data);
	}
	
//	//수거 신청 전체 
//	public int totalApply(String memberId) {
//		String sql = "select count(*) from apply where apply_state like '신청완료' and APPLY_AREA in (select MEMBER_PICK_AREA from member_pick where member_id like ?)";
//	}
	
	public int count(PageVO pageVo) {
		if(pageVo.isSearch()) {
			String sql = "select count(*) from apply "
					+ "where instr("+pageVo.getColumn()+", ?) > 0";
			Object[] data= {pageVo.getKeyword()};
			return jdbcTemplate.queryForObject(sql,int.class,data);
		}
		else {
			String sql ="select count(*) from apply";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	public List<ApplyRequestListVo> selectList(){
		String sql = "select * from apply order by apply_no asc";
		return jdbcTemplate.query(sql, applyRequestListMapper);
	}
	
	public int countApply(String memberId) {
		String sql = "select count(*) from apply where apply_state like '신청완료' and APPLY_no in (select MEMBER_PICK_AREA from member_pick where member_id like ?)";
		Object[] data = {memberId};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	
	
	
	
	//최종 결제 내역 조회
	
	//
		
		
	}



