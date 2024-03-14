package com.kh.rushpickme.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.rushpickme.dto.MemberDto;
import com.kh.rushpickme.mapper.MemberMapper;

@Repository
public class AdminDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @Autowired
    private MemberMapper mapper;
    
    public List<MemberDto> selectList(String column) {
        String sql = "select * from member where member_nick like '%피커%' "
                   + "order by ? asc";
        Object[] data = {column};
        return jdbcTemplate.query(sql, mapper, data);
    }

	public MemberDto selectOne(String memberId) {
		String sql = "select * from member where member_id = ?";
		Object[] data={memberId};
		List<MemberDto> list = jdbcTemplate.query(sql, mapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
}
