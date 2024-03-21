package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.dto.QnaDto;

@Service
public class QnaMapper implements RowMapper<QnaDto>{

	@Override
	public QnaDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		QnaDto qnaDto = new QnaDto();
		qnaDto.setQnaNo(rs.getInt("qna_no"));
		qnaDto.setMemberId(rs.getString("member_id"));
		qnaDto.setMemberNick(rs.getString("member_nick"));
		qnaDto.setQnaTitle(rs.getString("qna_title"));
		qnaDto.setQnaContent(rs.getString("qna_content"));
		qnaDto.setQnaDelete(rs.getString("qna_delete"));
		qnaDto.setQnaHits(rs.getInt("qna_hits"));
		qnaDto.setQnaWrite(rs.getDate("qna_write"));
		qnaDto.setQnaEdit(rs.getDate("qna_edit"));
		
		qnaDto.setQnaGroup(rs.getInt("qna_group"));
		qnaDto.setQnaTarget(rs.getObject("qna_target", Integer.class));
		qnaDto.setQnaDepth(rs.getInt("qna_depth"));
		
		return qnaDto;
	}

}
