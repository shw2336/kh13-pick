package com.kh.rushpickme.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.rushpickme.dto.MemberDto;
import com.kh.rushpickme.dto.MemberGreenDto;
import com.kh.rushpickme.dto.MemberPickDto;
import com.kh.rushpickme.mapper.MemberGreenMapper;
import com.kh.rushpickme.mapper.MemberListMapper;
import com.kh.rushpickme.mapper.MemberMapper;
import com.kh.rushpickme.mapper.MemberPickMapper;
import com.kh.rushpickme.vo.PageVO;

@Repository
public class MemberDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private MemberMapper mapper;
	@Autowired
	private MemberGreenMapper greenMapper;
	@Autowired
	private MemberPickMapper pickMapper;
	
	@Autowired
	private MemberListMapper memberListMapper;
	
	@Autowired
	private BuyDao buyDao;
	
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
	//회원 상세ㅋ
	public MemberDto selectOne(String memberId) {
		String sql = "select * from member where member_id = ?";
		Object[] data = {memberId};
		List<MemberDto> list = jdbcTemplate.query(sql, mapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//일반회원 상세(그린)
	public MemberGreenDto selectOneGreen(String memberId) {
		String sql = "select * from member_green where member_id = ?";
		Object[] data = {memberId};
		List<MemberGreenDto> list = jdbcTemplate.query(sql, greenMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//수거회원 상세(피커)
		public MemberPickDto selectOnePick(String memberId) {
			String sql = "select * from member_pick where member_id = ?";
			Object[] data = {memberId};
			List<MemberPickDto> list = jdbcTemplate.query(sql, pickMapper, data);
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
								+ "member_email=?,"
								+ "member_birth=? where member_id=? ";
								
							
			Object[] data = {
				memberDto.getMemberNick(),memberDto.getMemberContact(),memberDto.getMemberName(),
				memberDto.getMemberEmail(),memberDto.getMemberBirth(),memberDto.getMemberId()
				
			};
			return jdbcTemplate.update(sql, data) > 0;
		}
		
		//일반회원정보 변경
				public boolean updateGreenMember(MemberGreenDto memberGreenDto) {
					String sql = "update member_green set "
										+ "member_green_post=?, member_green_address1=?, member_green_address2=? "
										+ "where member_id =?" ;
										
		
					Object[] data = {
							memberGreenDto.getMemberGreenPost(),memberGreenDto.getMemberGreenAddress1(),
							memberGreenDto.getMemberGreenAddress2(),memberGreenDto.getMemberId()
					};
					return jdbcTemplate.update(sql, data) > 0;
				}
				//수거회원근무지 변경
				public boolean updatePickMember(MemberPickDto memberPickDto) {
					String sql = "update member_pick set "
							+ "member_pick_area "
							+ "where member_id =?";
					Object[] data = {
							memberPickDto.getMemberPickArea(),memberPickDto.getMemberId()
					};
					return jdbcTemplate.update(sql,data)>0;
				}
		
		public MemberDto selectOneByMemberNick(String memberNick) {
			String sql = "select * from member where member_nick = ?";
			Object[] data = {memberNick};
			List<MemberDto> list = jdbcTemplate.query(sql,mapper,data);
			return list.isEmpty() ? null : list.get(0);
		}

		//피커 멤버 승인
		public void approvePicker(String memberId) {
			String sql = "update member set member_type = 'picker' where member_id = ?";
			Object[] data = {memberId};
			jdbcTemplate.update(sql, data);
		}
		
		// 관리자에 의한 회원 정보 수정
		public boolean updateMemberByAdmin(MemberDto memberDto) {
		    String sql = "update member set "
		            + "member_nick=?, member_contact=?, "
		            + "member_type=? "
		            + "where member_id=?";
		    Object[] data = {
		            memberDto.getMemberNick(), memberDto.getMemberContact(),
		            memberDto.getMemberType(),
		            memberDto.getMemberId()
		    };
		    return jdbcTemplate.update(sql, data) > 0;
		}
		//연결
		public void connect(String memberId, int attachNo) {
			String sql ="insert into member_attach(member_id,attach_no) "
					+ "values(?,?)";
			Object[] data = {memberId,attachNo};
			jdbcTemplate.update(sql,data);
		}
		public int findAttachNo(String memberId) {
			String sql="select attach_no from member_attach where member_id=?";
			Object[] data= {memberId};
		return	jdbcTemplate.queryForObject(sql, int.class,data);
		}
		//포인트 충전/차감
		public boolean plusMemberPoint(String memberId, int point) {
		    String sql = "update member_green set member_green_point = member_green_point + ? where member_id = ?";
		    Object[] data = {point, memberId};
		    return jdbcTemplate.update(sql, data) > 0;
		}

		public boolean minusMemberPoint(String memberId, int point) {
			String sql = "update member "
							+ "set member_point = member_green_point - ? "
							+ "where member_id = ?";
			Object[] data = {point, memberId};
			return jdbcTemplate.update(sql, data) > 0;
		}
		
		//통합+페이징
		public List<MemberDto> selectListByPaging(PageVO pageVO) {
			if(pageVO.isSearch()) {
				String sql = "select * from ("
						+ "select rownum rn, TMP.* from("
						+ "select "
						+ "member_id, member_pw, member_nick, member_contact, "
						+ "member_name, member_type, member_email, member_birth "
						+ "from member "
						+ "where instr("+pageVO.getColumn()+", ?) > 0 "
								+ ")TMP"
								+ ") where rn between ? and ?";
				Object[] data = {
						pageVO.getKeyword(),
						pageVO.getBeginRow(),
						pageVO.getEndRow()
				};
				return jdbcTemplate.query(sql, memberListMapper, data);
			}
			else {
				String sql = "select * from ("
						+ "select rownum rn, TMP.* from ("
						+ "select "
						+ "member_id, member_pw, member_nick, member_contact, "
						+ "member_name, member_type, member_email, member_birth "
						+ "from member "
						+ ")TMP"
						+ ") where rn between ? and ?";
				Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
				return jdbcTemplate.query(sql, memberListMapper, data);
			}
		}
		
		//카운팅
		public int count() {
			String sql = "select count(*) from member";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
		public int count(String column, String keyword) {
			String sql = "select count(*) from member "
					+ "where instr("+column+", ?) > 0";
			Object[] data = {keyword};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		public int count(PageVO pageVO) {
			if(pageVO.isSearch()) {
				String sql = "select count(*) from member "
						+ "where instr("+pageVO.getColumn()+", ?) > 0";
				Object[] data = {pageVO.getKeyword()};
				return jdbcTemplate.queryForObject(sql, int.class, data);
			}
			else {
				String sql = "select count(*) from member";
				return jdbcTemplate.queryForObject(sql, int.class);
			}
		}
	

		// Green 포인트를 기준으로 구매할 수 있는 티켓 수 계산
		public int calculateAvailableTickets(int memberGreenPoint) {
		    int manTicket = 1; // 만원당 티켓 수
		    int availableTickets = memberGreenPoint / 10000 * manTicket;
		    return availableTickets;
		}

		// 구매한 티켓 수 업데이트
		public void updateTicketsByGreenPoint(String memberId, int memberGreenTicket) {
		    String sql = "UPDATE member_green SET member_green_ticket = ? WHERE member_id = ?";
		    Object[] data = {memberGreenTicket, memberId};
		    jdbcTemplate.update(sql, data);
		}
}

