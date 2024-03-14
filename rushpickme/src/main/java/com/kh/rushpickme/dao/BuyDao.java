package com.kh.rushpickme.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.rushpickme.dto.BuyDto;
import com.kh.rushpickme.mapper.BuyMapper;

@Repository
public class BuyDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private BuyMapper buyMapper;
	
	public void insert(BuyDto buyDto) {
		String sql ="insert into buy("
				+ "buy_no, member_id, point_no, "
				+ "buy_qty, buy_total, point_name"
				+ ") "
				+ "values(buy_seq.nextval, ?, ?, ?, ?, ?)";
			
		Object[] data= {
				buyDto.getMemberId(), buyDto.getPointNo(),
				buyDto.getBuyQty(), buyDto.getBuyTotal(),buyDto.getPointName()
		};
		jdbcTemplate.update(sql,data);
	}
	
	//구매내역 조회 매서드
	public List<BuyDto> selectList(String memberId){
		String sql="select * from buy where member_id=? "
				+ "order by buy_no desc";
		
		Object[] data= {memberId};
		return jdbcTemplate.query(sql, buyMapper,data);
		
	}
	
	//상품에 따라 구매내역 조회
	public List<BuyDto> selectList(int pointNo){
		String sql="select * from buy where member_id=? "
				+ "order by buy_no desc";
		Object [] data = {pointNo};
		return jdbcTemplate.query(sql,buyMapper,data);
	}
	
	//관리자가 회원 구매내역 조회
	public List<BuyDto> selectList(){
		String sql ="select * from buy order by buy_no desc";
		return jdbcTemplate.query(sql, buyMapper);
	}
	
}
