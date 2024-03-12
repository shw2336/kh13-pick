package com.kh.rushpickme.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.rushpickme.dto.MemberDto;
import com.kh.rushpickme.dto.MemberGreenDto;
import com.kh.rushpickme.dto.MemberPickDto;
import com.kh.rushpickme.mapper.MemberMapper;

@Repository
public class MemberDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private MemberMapper mapper;
	
	//회원 가입
	public void insert(MemberDto memberdto) {
		String sql = "insert into member("
				+ "member_id, member_pw, member_nick, "
				+ "member_contact, member_name, "
				+ " member_email, member_birth"
			+ ") values(?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {
			memberdto.getMemberId(), memberdto.getMemberPw(),memberdto.getMemberNick(),
			memberdto.getMemberContact(),memberdto.getMemberName(),
			memberdto.getMemberEmail(),memberdto.getMemberBirth()
		};
		jdbcTemplate.update(sql,data);
		}
	//회원 가입(그린)
		public void insertGreen(MemberGreenDto memberGreenDto) {
			String sql = "insert into member_green("
					+ "member_id, member_green_post, member_green_address1, "
					+ "member_green_address2 "
				+ ") values(?, ?, ?, ?)";
			Object[] data = {
				memberGreenDto.getMemberId(),memberGreenDto.getMemberGreenPost(),
				memberGreenDto.getMemberGreenAddress1(),memberGreenDto.getMemberGreenAddress2()
				
			};
			jdbcTemplate.update(sql,data);
			}
		//회원 가입(피커)
		public void insertPick(MemberPickDto memberPickDto) {
			String sql ="insert into member_pick("
					+ "member_id, member_pick_area) "
					+ "values(?,?)";
			Object [] data= {
				memberPickDto.getMemberId(),memberPickDto.getMemberPickArea()	
			};
			jdbcTemplate.update(sql,data);
		}
	
	//회원 목록 
	public List<MemberDto>selectList(){
		String sql = "select * from member order by member_id asc";
		return jdbcTemplate.query(sql, mapper);
	}
	
	//회원 검색
	public List<MemberDto>selectList(String column, String keyword){
		String sql = "select * from member where instr("+column+", ?) > 0 "
				+ "order by "+column+" asc, member_id asc";
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, mapper, data);
		
	}
	//회원 상세
	public MemberDto selectOne(String memberId) {
		String sql = "select * from member where member_id = ?";
		Object[] data = {memberId};
		List<MemberDto> list = jdbcTemplate.query(sql, mapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
		//비밀번호 변경
		public boolean updateMemberPw(MemberDto memberdto) {
			String sql = "update member set member_pw=? where member_id=?";
			Object[] data = {memberdto.getMemberPw(), memberdto.getMemberId()};
			return jdbcTemplate.update(sql, data) > 0;
		}
		
		//회원탈퇴
		public boolean delete(String memberId) {
			String sql = "delete member where member_id = ?";
			Object[] data = {memberId};
			return jdbcTemplate.update(sql, data) > 0;
		}
		//회원정보 변경
		public boolean updateMember(MemberDto memberDto) {
			String sql = "update member set "
								+ "member_nick=?, member_contact=?, member_name=?, "
								+ " member_email=?, "
								+ "member_birth=?, "
							+ "where member_id = ?";
			Object[] data = {
				memberDto.getMemberNick(),memberDto.getMemberContact(),memberDto.getMemberName(),
				memberDto.getMemberEmail(),
				memberDto.getMemberBirth()
			};
			return jdbcTemplate.update(sql, data) > 0;
		}
		
		public MemberDto selectOneByMemberNick(String memberNick) {
			String sql = "select * from member where member_nick = ?";
			Object[] data = {memberNick};
			List<MemberDto> list = jdbcTemplate.query(sql,mapper,data);
			return list.isEmpty() ? null : list.get(0);
		}
		//그린 멤버 승인
		public void approveGreen(String memberId) {
			String sql = "update member set member_type = 'green' where member_id = ?";
			Object[] data = {memberId};
			jdbcTemplate.update(sql, data);
		}
		
		//피커 멤버 승인
		public void approvePicker(String memberId) {
			String sql = "update member set member_type = 'picker' where member_id = ?";
			Object[] data = {memberId};
			jdbcTemplate.update(sql, data);
		}
		public boolean plusMemberPoint(String memberId, int point) {
			String sql = "update member "
							+ "set member_point = member_point + ? "
							+ "where member_id = ?";
			Object[] data = {point, memberId};
			return jdbcTemplate.update(sql, data) > 0;
		}
	
	
	
}
