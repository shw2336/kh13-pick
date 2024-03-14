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
    
    // 피커 회원 목록 조회
    public List<MemberDto> getPickerList() {
        String sql = "select * from member where member_type = '피커'";
        return jdbcTemplate.query(sql, mapper);
    }

    // 회원 상세 정보 조회
    public MemberDto selectOne(String memberId) {
        String sql = "select * from member where member_id = ?";
        Object[] data = {memberId};
        List<MemberDto> list = jdbcTemplate.query(sql, mapper, data);
        return list.isEmpty() ? null : list.get(0);
    }
}
