package com.kh.rushpickme.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.rushpickme.dto.QnaDto;
import com.kh.rushpickme.mapper.QnaListMapper;
import com.kh.rushpickme.mapper.QnaMapper;
import com.kh.rushpickme.vo.PageVO;

@Repository
public class QnaDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private QnaMapper qnaMapper;

	@Autowired
	private QnaListMapper qnaListMapper;

	//목록
	public List<QnaDto> selectList() {
//		String sql = "select * from qna order by qna_no desc";
//		return jdbcTemplate.query(sql, qnaMapper);
		
		String sql = "select "
							+ "qna_no, member_id, qna_title, "
							+ "qna_content, qna_delete, qna_hits, "
							+ "qna_write, qna_edit "
						+ "from qna order by qna_no desc";
		return jdbcTemplate.query(sql, qnaListMapper);
	}
	//검색
	public List<QnaDto> selectList(String column, String keyword) {
//		String sql = "select * from qna "
//						+ "where instr("+column+", ?) > 0 "
//						+ "order by qna_no desc";
//		Object[] data = {keyword};
//		return jdbcTemplate.query(sql, qnaMapper, data);
		
		String sql = "select "
							+ "qna_no, member_id, qna_title, "
							+ "qna_content, qna_delete, qna_hits, "
							+ "qna_write, qna_edit "
						+ "from qna "
						+ "where instr("+column+", ?) > 0 "
						+ "order by qna_no desc";
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, qnaListMapper, data);
	}
	
	//목록+페이징
	//- page는 현재 조회할 페이지 번호
	//- size는 조회할 페이지의 출력개수
	//- 위 두개를 이용하여 시작행(beginRow)과 종료행(endRow)를 계산
	public List<QnaDto> selectListByPaging(int page, int size) {
		int endRow = page * size;
		int beginRow = endRow - (size-1);
		
		String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
								+ "select "
									+ "qna_no, member_id, qna_title, "
									+ "qna_content, qna_delete, qna_hits, "
									+ "qna_write, qna_edit "
								+ "from qna order by qna_no desc"
							+ ")TMP"
						+ ") where rn between ? and ?";
		Object[] data = {beginRow, endRow};
		return jdbcTemplate.query(sql, qnaListMapper, data);
	}
	
	//검색+페이징
	public List<QnaDto> selectListByPaging(
			String column, String keyword, int page, int size){
		int endRow = page * size;
		int beginRow = endRow - (size-1);
		
		String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
								+ "select "
									+ "qna_no, member_id, qna_title, "
									+ "qna_content, qna_delete, qna_hits, "
									+ "qna_write, qna_edit "
								+ "from qna "
								+ "where instr("+column+", ?) > 0 "
								+ "order by qna_no desc"
							+ ")TMP"
						+ ") where rn between ? and ?";
		Object[] data = {keyword, beginRow, endRow};
		return jdbcTemplate.query(sql, qnaListMapper, data);
	}
	
	//통합+페이징
	public List<QnaDto> selectListByPaging(PageVO pageVO){ 
		if(pageVO.isSearch()) {//검색
			String sql = "select * from ("
								+ "select rownum rn, TMP.* from ("
									+ "select "
										+ "qna_no, member_id, qna_title, "
										+ "qna_content, qna_delete, qna_hits, "
										+ "qna_write, qna_edit, "
										+ "qna_group, qna_target, qna_depth "
									+ "from qna "
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
			return jdbcTemplate.query(sql, qnaListMapper, data);
		}
		else {//목록
			String sql = "select * from ("
								+ "select rownum rn, TMP.* from ("
									+ "select "
										+ "qna_no, member_id, qna_title, "
										+ "qna_content, qna_delete, qna_hits, "
										+ "qna_write, qna_edit, "
										+ "qna_group, qna_target, qna_depth "
									+ "from qna "
									//+ "order by qna_no desc"//옛날방식(최신순)
									+ "connect by prior qna_no=qna_target "
									+ "start with qna_target is null "
									+ "order siblings by qna_group desc, qna_no asc"
								+ ")TMP"
							+ ") where rn between ? and ?";
			Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, qnaListMapper, data);
		}
	}
	
	//카운트 - 목록일 경우와 검색일 경우를 각각 구현
	public int count() {
		String sql = "select count(*) from qna";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public int count(String column, String keyword) {
		String sql = "select count(*) from qna "
						+ "where instr("+column+", ?) > 0";
		Object[] data = {keyword};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	public int count(PageVO pageVO) {
		if(pageVO.isSearch()) {//검색
			String sql = "select count(*) from qna "
							+ "where instr("+pageVO.getColumn()+", ?) > 0";
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {//목록
			String sql = "select count(*) from qna";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	
	//단일조회
	public QnaDto selectOne(int qnaNo) {
		String sql = "select * from qna where qna_no = ?";
		Object[] data = {qnaNo};
		List<QnaDto> list = jdbcTemplate.query(sql, qnaMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//조회수 증가
	public boolean updateqnaReadcount(int qnaNo) {
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
	public void insert(QnaDto qnaDto) {
		//String sql = "insert into qna(7개) values(?, ?, ?, ?, sysdate, null, 0)";
		//String sql = "insert into qna(4개) values(?, ?, ?, ?)";
		String sql = "insert into qna("
						+ "qna_no, member_id, qna_title, qna_content, "
						+ "qna_group, qna_target, qna_depth"
					+ ") values(?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {
			qnaDto.getQnaNo(), qnaDto.getMemberId(),
			qnaDto.getQnaTitle(), qnaDto.getQnaContent(),
			qnaDto.getQnaGroup(), qnaDto.getQnaTarget(),
			qnaDto.getQnaDepth()
		};
		jdbcTemplate.update(sql, data);
	}
	public boolean delete(int qnaNo) {
		String sql = "delete qna where qna_no = ?";
		Object[] data = {qnaNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	public boolean update(QnaDto qnaDto) {
		String sql = "update qna "
						+ "set qna_title=?, qna_content=?, qna_edit=sysdate "
						+ "where qna_no = ?";
		Object[] data = {
			qnaDto.getQnaTitle(), qnaDto.getQnaContent(),
			qnaDto.getQnaNo()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
}









