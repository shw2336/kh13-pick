package com.kh.rushpickme.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.rushpickme.dto.ReviewDto;
import com.kh.rushpickme.mapper.ReviewListMapper;
import com.kh.rushpickme.mapper.ReviewMapper;
import com.kh.rushpickme.vo.PageVO;

@Repository
public class ReviewDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ReviewMapper reviewMapper;

	@Autowired
	private ReviewListMapper reviewListMapper;

	//목록
	public List<ReviewDto> selectList() {
//		String sql = "select * from review order by review_no desc";
//		return jdbcTemplate.query(sql, reviewMapper);
		
		String sql = "select "
							+ "review_no, ask_no, member_id, "
							+ "review_star, review_content, review_delete "
							+ "review_write, review_edit "
						+ "from review order by review_no desc";
		return jdbcTemplate.query(sql, reviewListMapper);
	}
	//검색
	public List<ReviewDto> selectList(String column, String keyword) {
//		String sql = "select * from review "
//						+ "where instr("+column+", ?) > 0 "
//						+ "order by review_no desc";
//		Object[] data = {keyword};
//		return jdbcTemplate.query(sql, reviewMapper, data);
		
		String sql = "select "
							+ "review_no, ask_no, member_id, "
							+ "review_star, review_content, review_delete "
							+ "review_write, review_edit "
						+ "from review "
						+ "where instr("+column+", ?) > 0 "
						+ "order by review_no desc";
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, reviewListMapper, data);
	}
	
	//목록+페이징
	//- page는 현재 조회할 페이지 번호
	//- size는 조회할 페이지의 출력개수
	//- 위 두개를 이용하여 시작행(beginRow)과 종료행(endRow)를 계산
	public List<ReviewDto> selectListByPaging(int page, int size) {
		int endRow = page * size;
		int beginRow = endRow - (size-1);
		
		String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
								+ "select "
									+ "review_no, ask_no, member_id, "
									+ "review_star, review_content, review_delete "
									+ "review_write, review_edit "
								+ "from review order by review_no desc"
							+ ")TMP"
						+ ") where rn between ? and ?";
		Object[] data = {beginRow, endRow};
		return jdbcTemplate.query(sql, reviewListMapper, data);
	}
	
	//검색+페이징
	public List<ReviewDto> selectListByPaging(
			String column, String keyword, int page, int size){
		int endRow = page * size;
		int beginRow = endRow - (size-1);
		
		String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
								+ "select "
									+ "review_no, ask_no, member_id, "
									+ "review_star, review_content, review_delete "
									+ "review_write, review_edit "
								+ "from review "
								+ "where instr("+column+", ?) > 0 "
								+ "order by review_no desc"
							+ ")TMP"
						+ ") where rn between ? and ?";
		Object[] data = {keyword, beginRow, endRow};
		return jdbcTemplate.query(sql, reviewListMapper, data);
	}
	
	//통합+페이징
	public List<ReviewDto> selectListByPaging(PageVO pageVO){ 
		if(pageVO.isSearch()) {//검색
			String sql = "select * from ("
								+ "select rownum rn, TMP.* from ("
									+ "select "
										+ "review_no, ask_no, member_id, "
										+ "review_star, review_content, review_delete, "
										+ "review_write, review_edit "
									+ "from review "
									+ "where instr("+pageVO.getColumn()+", ?) > 0 "
									//+ "order by review_no desc"//옛날방식(최신순)
								+ ")TMP"
							+ ") where rn between ? and ?";
			Object[] data = {
					pageVO.getKeyword(), 
					pageVO.getBeginRow(), 
					pageVO.getEndRow()
			};
			return jdbcTemplate.query(sql, reviewListMapper, data);
		}
		else {//목록
			String sql = "select * from ("
								+ "select rownum rn, TMP.* from ("
									+ "select "
										+ "review_no, ask_no, member_id, "
										+ "review_star, review_content, review_delete, "
										+ "review_write, review_edit "
									+ "from review "
									//+ "order by review_no desc"//옛날방식(최신순)
								+ ")TMP"
							+ ") where rn between ? and ?";
			Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, reviewListMapper, data);
		}
	}
	
	//카운트 - 목록일 경우와 검색일 경우를 각각 구현
	public int count() {
		String sql = "select count(*) from review";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public int count(String column, String keyword) {
		String sql = "select count(*) from review "
						+ "where instr("+column+", ?) > 0";
		Object[] data = {keyword};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	public int count(PageVO pageVO) {
		if(pageVO.isSearch()) {//검색
			String sql = "select count(*) from review "
							+ "where instr("+pageVO.getColumn()+", ?) > 0";
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {//목록
			String sql = "select count(*) from review";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	
	//단일조회
	public ReviewDto selectOne(int reviewNo) {
		String sql = "select * from review where review_no = ?";
		Object[] data = {reviewNo};
		List<ReviewDto> list = jdbcTemplate.query(sql, reviewMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//count, sequence, max, min, sum, avg처럼 결과가 하나만 나오는 경우
	//그 결과는 객체가 아니라 원시데이터 형태일 확률이 높다
	public int getSequence() {
		String sql = "select review_seq.nextval from dual";
		//jdbcTemplate.queryForObject(구문, 결과자료형);
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	//등록할 때 시퀀스 번호를 생성하면 절대 안된다
	public void insert(ReviewDto reviewDto) {
		//String sql = "insert into review(7개) values(?, ?, ?, ?, sysdate, null, 0)";
		//String sql = "insert into review(4개) values(?, ?, ?, ?)";
		String sql = "insert into review("
						+ "review_no, ask_no, member_id, review_star, "
						+ "review_content"
					+ ") values(?, ?, ?, ?)";
		Object[] data = {
			reviewDto.getReviewNo(), reviewDto.getAskNo(),
			reviewDto.getMemberId(), reviewDto.getReviewStar(),
			reviewDto.getReviewContent()
		};
		jdbcTemplate.update(sql, data);
	}
	public boolean delete(int reviewNo) {
		String sql = "delete review where review_no = ?";
		Object[] data = {reviewNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	public boolean update(ReviewDto reviewDto) {
		String sql = "update review "
						+ "set review_star=?, review_content=?, review_edit=sysdate "
						+ "where review_no = ?";
		Object[] data = {
			reviewDto.getReviewStar(), reviewDto.getReviewContent(),
			reviewDto.getReviewNo()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
}









