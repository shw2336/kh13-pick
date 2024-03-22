package com.kh.rushpickme.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.rushpickme.dto.QnaDto;
//import com.kh.rushpickme.mapper.QnaListMapper;
import com.kh.rushpickme.mapper.QnaMapper;
import com.kh.rushpickme.mapper.QnaMemberNickListVOMapper;
import com.kh.rushpickme.mapper.QnaMemberNickVOMapper;
import com.kh.rushpickme.vo.PageVO;
import com.kh.rushpickme.vo.QnaMemberNickVO;

@Repository
public class QnaDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private QnaMapper qnaMapper;

//	@Autowired
//	private QnaListMapper qnaListMapper;
	
	@Autowired
	private QnaMemberNickVOMapper qnaMemberNickVOMapper;
	
	@Autowired
	private QnaMemberNickListVOMapper qnaMemberNickListVOMapper;
	
	
	//통합+페이징
	public List<QnaMemberNickVO> selectListByPaging(PageVO pageVO){ 
		if(pageVO.isSearch()) {//검색
			String sql = "select * from ("
								+ "select rownum rn, TMP.* from ("
									+ "select "
										+ "qna_no, qna.member_id, qna_title, "
										+ "qna_content, qna_delete, qna_hits, "
										+ "qna_write, qna_edit, "
										+ "qna_group, qna_target, qna_depth,"
										+ "member.member_nick "
									+ "from qna left outer join member on qna.member_id = member.member_id "
									+ "where instr("+pageVO.getColumn()+", ?) > 0 "
									//+ "order by qna_no desc"//옛날방식(최신순)
									+ "connect by prior qna_no=qna_target "
									+ "start with qna_target is null "
									+ "order siblings by qna_group desc, qna_no asc"
								+ ")TMP"
							+ ") where rn between ? and ?";
			
			Object[] data = {
					pageVO.getKeyword(), 
					pageVO.getBeginRow(), 
					pageVO.getEndRow()
			};
			return jdbcTemplate.query(sql, qnaMemberNickListVOMapper, data);
		}
		else {//목록
			String sql = "select * from ("
								+ "select rownum rn, TMP.* from ("
									+ "select "
										+ "qna_no, qna.member_id, qna_title, "
										+ "qna_content, qna_delete, qna_hits, "
										+ "qna_write, qna_edit, "
										+ "qna_group, qna_target, qna_depth, "
										+ "member.member_nick "
									+ "from qna left outer join member on qna.member_id = member.member_id "
									+ "connect by prior qna_no=qna_target "
									+ "start with qna_target is null "
									+ "order siblings by qna_group desc, qna_no asc"
								+ ")TMP"
							+ ") where rn between ? and ?";
			Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, qnaMemberNickListVOMapper, data);
		}
	}

	

	
	//카운트 - 목록일 경우와 검색일 경우를 각각 구현
//	public int count() {
//		String sql = "select count(*) from qna";
//		return jdbcTemplate.queryForObject(sql, int.class);
//	}
//	public int count(String column, String keyword) {
//		String sql = "select count(*) from qna left outer join member on qna.member_id = member.member_id  where instr("+ column+ ", ?) > 0";
//		Object[] data = {keyword};
//		return jdbcTemplate.queryForObject(sql, int.class, data);
//	}
	
	//페이징처리된부분
	public int count(PageVO pageVO) {
		if(pageVO.isSearch()) {//검색
			String sql = "select count(*) from qna left outer join member on qna.member_id = member.member_id  where instr("+ pageVO.getColumn()+", ?) > 0";
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {//목록
			String sql = "select count(*) from qna left outer join member on qna.member_id = member.member_id";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	
	//단일조회
	public QnaMemberNickVO selectOne(int qnaNo) {
		String sql = "select * from qna left outer join member on qna.member_id = member.member_id where qna_no = ?";
		Object[] data = {qnaNo};
		List<QnaMemberNickVO> list = jdbcTemplate.query(sql, qnaMemberNickVOMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//조회수 증가
	public boolean updateQnaHits(int qnaNo) {
		String sql = "update qna "
						+ "set qna_hits = qna_hits + 1 "
						+ "where qna_no = ?";
		Object[] data = {qnaNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//count, sequence, max, min, sum, avg처럼 결과가 하나만 나오는 경우
	//그 결과는 객체가 아니라 원시데이터 형태일 확률이 높다
	public int getSequence() {
		String sql = "select qna_seq.nextval from dual";
		//jdbcTemplate.queryForObject(구문, 결과자료형);
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	//등록할 때 시퀀스 번호를 생성하면 절대 안된다!
	public void insert(QnaMemberNickVO qnaMemberNickVO) {
		//String sql = "insert into qna(7개) values(?, ?, ?, ?, sysdate, null, 0)";
		//String sql = "insert into qna(4개) values(?, ?, ?, ?)";
		String sql = "insert into qna("
						+ "qna_no, member_id, qna_title, qna_content, "
						+ "qna_group, qna_target, qna_depth"
					+ ") values(?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {
				qnaMemberNickVO.getQnaNo(), qnaMemberNickVO.getMemberId(), 
				qnaMemberNickVO.getQnaTitle(), qnaMemberNickVO.getQnaContent(),
				qnaMemberNickVO.getQnaGroup(), qnaMemberNickVO.getQnaTarget(),
				qnaMemberNickVO.getQnaDepth()
		};
		jdbcTemplate.update(sql, data);
	}
	public boolean delete(int qnaNo) {
		String sql = "delete qna where qna_no = ?";
		Object[] data = {qnaNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	public boolean update(QnaMemberNickVO qnaMemberNickVO) {
		String sql = "update qna "
						+ "set qna_title=?, qna_content=?, qna_edit=sysdate "
						+ "where qna_no = ?";
		Object[] data = {
				qnaMemberNickVO.getQnaTitle(), qnaMemberNickVO.getQnaContent(),
				qnaMemberNickVO.getQnaNo()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
}









