package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.dto.ReviewDto;

@Service
public class ReviewListMapper implements RowMapper<ReviewDto>{

	@Override
	public ReviewDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReviewDto reviewDto = new ReviewDto();
		reviewDto.setReviewNo(rs.getInt("review_no"));
		reviewDto.setAskNo(rs.getInt("ask_no"));
		reviewDto.setMemberId(rs.getString("member_id"));
		reviewDto.setReviewStar(rs.getInt("review_star"));
		reviewDto.setReviewContent(rs.getString("review_content"));
		reviewDto.setReviewDelete(rs.getString("review_delete"));
		reviewDto.setReviewHits(rs.getInt("review_hits"));
		reviewDto.setReviewWrite(rs.getDate("review_write"));
		reviewDto.setReviewEdit(rs.getDate("review_edit"));
		
		return reviewDto;
	}

}
