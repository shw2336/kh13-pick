package com.kh.rushpickme.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewLikeDao {
	//[C] 좋아요 내역을 등록
	//[D] 좋아요 내역을 삭제
	//[R] 좋아요 여부를 확인
	//[R] 특정 글의 좋아요 개수를 확인
	@Autowired
	private JdbcTemplate jdbcTemplate;

	public void insert(String memberId, int reviewNo) {
		String sql = "insert into review_like(member_id, review_no) values(?, ?)";
		Object[] data = {memberId, reviewNo};
		jdbcTemplate.update(sql, data);
	}
	public boolean delete(String memberId, int reviewNo) {
		String sql = "delete review_like where member_id = ? and review_no = ?";
		Object[] data = {memberId, reviewNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	public boolean check(String memberId, int reviewNo) {
		String sql = "select count(*) from review_like "
						+ "where member_id = ? and review_no = ?";
		Object[] data = {memberId, reviewNo};
		int count = jdbcTemplate.queryForObject(sql, int.class, data);
		return count > 0;
	}
	public int count(int reviewNo) {
		String sql = "select count(*) from review_like where review_no = ?";
		Object[] data = {reviewNo};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
}