package com.kh.rushpickme.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.rushpickme.vo.QnaMemberNickVO;

@Service
public class QnaMemberNickVOMapper implements RowMapper<QnaMemberNickVO>{

	@Override
	public QnaMemberNickVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		QnaMemberNickVO qnaMemberNickVO = new QnaMemberNickVO();
		qnaMemberNickVO.setQnaNo(rs.getInt("qna_no"));
		qnaMemberNickVO.setMemberId(rs.getString("member_id"));
		qnaMemberNickVO.setMemberNick(rs.getString("member_nick"));
		qnaMemberNickVO.setQnaTitle(rs.getString("qna_title"));
		qnaMemberNickVO.setQnaContent(rs.getString("qna_content"));
		qnaMemberNickVO.setQnaDelete(rs.getString("qna_delete"));
		qnaMemberNickVO.setQnaHits(rs.getInt("qna_hits"));
		qnaMemberNickVO.setQnaWrite(rs.getDate("qna_write"));
		qnaMemberNickVO.setQnaEdit(rs.getDate("qna_edit"));
		
		qnaMemberNickVO.setQnaGroup(rs.getInt("qna_group"));
		qnaMemberNickVO.setQnaTarget(rs.getObject("qna_target", Integer.class));
		qnaMemberNickVO.setQnaDepth(rs.getInt("qna_depth"));
		
		return qnaMemberNickVO;
	}

}
