package com.kh.rushpickme.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.rushpickme.dto.ReviewDto;
import com.kh.rushpickme.mapper.ReviewListMapper;
import com.kh.rushpickme.mapper.ReviewMapper;
import com.kh.rushpickme.mapper.ReviewMemberNickListVOMapper;
import com.kh.rushpickme.mapper.ReviewMemberNickVOMapper;
import com.kh.rushpickme.vo.PageVO;
import com.kh.rushpickme.vo.ReviewMemberNickVO;

@Repository
public class ReviewDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ReviewMapper reviewMapper;

	@Autowired
	private ReviewListMapper reviewListMapper;
	
	@Autowired
	private ReviewMemberNickVOMapper reviewMemberNickVOMapper;
	
	@Autowired
	private ReviewMemberNickListVOMapper reviewMemberNickListVOMapper;
	
	//통합+페이징
	public List<ReviewMemberNickVO> selectListByPaging(PageVO pageVO){ 
		if(pageVO.isSearch()) {//검색
			String sql = "select * from ("
								+ "select rownum rn, TMP.* from ("
									+ "select "
										+ "review_no, ask_no, review.member_id, "
										+ "review_star, review_content, review_delete, review_hits, "
										+ "review_write, review_edit, member.member_nick "
									+ "from review left outer join member on review.member_id = member.member_id "
									+ "where instr("+pageVO.getColumn()+", ?) > 0 "
									+ "order by review_no desc"
								+ ")TMP"
							+ ") where rn between ? and ?";
			Object[] data = {
					pageVO.getKeyword(), 
					pageVO.getBeginRow(), 
					pageVO.getEndRow()
			};
			return jdbcTemplate.query(sql, reviewMemberNickVOMapper, data);
		}
		else {//목록
			String sql = "select * from ("
								+ "select rownum rn, TMP.* from ("
									+ "select "
										+ "review_no, ask_no, review.member_id, "
										+ "review_star, review_content, review_delete, review_hits, "
										+ "review_write, review_edit, member.member_nick "
									+ "from review left outer join member on review.member_id = member.member_id "
									+ "order by review_no desc"
								+ ")TMP"
							+ ") where rn between ? and ?";
			Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, reviewMemberNickVOMapper, data);
		}
	}
	
//	//카운트 - 목록일 경우와 검색일 경우를 각각 구현
//	public int count() {
//		String sql = "select count(*) from review";
//		return jdbcTemplate.queryForObject(sql, int.class);
//	}
//	public int count(String column, String keyword) {
//		String sql = "select count(*) from review "
//						+ "where instr("+column+", ?) > 0";
//		Object[] data = {keyword};
//		return jdbcTemplate.queryForObject(sql, int.class, data);
//	}
	
	//페이징 처리된 부분
	public int count(PageVO pageVO) {
		if(pageVO.isSearch()) {//검색
			String sql = "select count(*) from review left outer join member on review.member_id = member.member_id "
							+ "where instr("+pageVO.getColumn()+", ?) > 0";
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {//목록
			String sql = "select count(*) from review left outer join member on review.member_id = member.member_id";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	
	//단일조회
	public ReviewMemberNickVO selectOne(int reviewNo) {
		String sql = "select * from review left outer join member on review.member_id = member.member_id where review_no = ?";
		Object[] data = {reviewNo};
		List<ReviewMemberNickVO> list = jdbcTemplate.query(sql, reviewMemberNickVOMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//조회수 증가
	public boolean updateReviewHits(int reviewNo) {
		String sql = "update review "
						+ "set review_hits = review_hits + 1 "
						+ "where review_no = ?";
		Object[] data = {reviewNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//count, sequence, max, min, sum, avg처럼 결과가 하나만 나오는 경우
	//그 결과는 객체가 아니라 원시데이터 형태일 확률이 높다
	public int getSequence() {
		String sql = "select review_seq.nextval from dual";
		//jdbcTemplate.queryForObject(구문, 결과자료형);
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	//등록할 때 시퀀스 번호를 생성하면 절대 안된다
	public void insert(ReviewMemberNickVO reviewMemberNickVO) {
		//String sql = "insert into review(7개) values(?, ?, ?, ?, sysdate, null, 0)";
		//String sql = "insert into review(4개) values(?, ?, ?, ?)";
		String sql = "insert into review("
						+ "review_no, ask_no, member_id, review_star, "
						+ "review_content"
					+ ") values(?, ?, ?, ?, ?)";
		Object[] data = {
				reviewMemberNickVO.getReviewNo(), reviewMemberNickVO.getAskNo(),
				reviewMemberNickVO.getMemberId(), reviewMemberNickVO.getReviewStar(),
				reviewMemberNickVO.getReviewContent()
		};
		jdbcTemplate.update(sql, data);
	}
	public boolean delete(int reviewNo) {
		String sql = "delete review where review_no = ?";
		Object[] data = {reviewNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	public boolean update(ReviewMemberNickVO reviewMemberNickVO) {
		String sql = "update review "
						+ "set review_star=?, review_content=?, review_edit=sysdate "
						+ "where review_no = ?";
		Object[] data = {
				reviewMemberNickVO.getReviewStar(), reviewMemberNickVO.getReviewContent(),
				reviewMemberNickVO.getReviewNo()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
//	//인기 게시물 조회
//	public List<ReviewMemberNickVO> selectTopList(int count){
//		String sql = "select * from (select * from review order by review_hits desc)\r\n"
//				+ "where rownum<=?";
//		Object[] param = {count};
//		return jdbcTemplate.query(sql, reviewMemberNickVOMapper, param);
//	}
	
//	//별점
//	public boolean updateReviewStar(ReviewDto reviewDto) {
//		String sql = "update review set review_star = ? where ask_no = ?";
//	    Object[] data = {
//	        reviewDto.getReviewStar(),
//	        reviewDto.getAskNo()
//	    };
//		return jdbcTemplate.update(sql, data) > 0;
//	}
	
}









