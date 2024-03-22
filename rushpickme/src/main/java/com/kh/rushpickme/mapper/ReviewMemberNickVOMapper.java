package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.vo.ReviewMemberNickVO;

@Service
public class ReviewMemberNickVOMapper implements RowMapper<ReviewMemberNickVO>{

	@Override
	public ReviewMemberNickVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReviewMemberNickVO reviewMemberNickVO = new ReviewMemberNickVO();
		reviewMemberNickVO.setReviewNo(rs.getInt("review_no"));
		reviewMemberNickVO.setAskNo(rs.getInt("ask_no"));
		reviewMemberNickVO.setMemberId(rs.getString("member_id"));
		reviewMemberNickVO.setMemberNick(rs.getString("member_nick"));
		reviewMemberNickVO.setReviewStar(rs.getInt("review_star"));
		reviewMemberNickVO.setReviewContent(rs.getString("review_content"));
		reviewMemberNickVO.setReviewDelete(rs.getString("review_delete"));
		reviewMemberNickVO.setReviewHits(rs.getInt("review_hits"));
		reviewMemberNickVO.setReviewWrite(rs.getDate("review_write"));
		reviewMemberNickVO.setReviewEdit(rs.getDate("review_edit"));
		
		return reviewMemberNickVO;
	}

}
