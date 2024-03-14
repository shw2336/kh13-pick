package com.kh.rushpickme.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.rushpickme.dto.PointDto;
import com.kh.rushpickme.mapper.PointMapper;

@Repository
public class PointDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private PointMapper pointMapper;
	
	public int getSequence() {
	    String sql = "select point_seq.nextval from dual";
	    return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	public void insert(PointDto pointDto) {
	    String sql = "insert into point(point_no, point_name, point_sell, point_charge) values(?, ?, ?, ?)";
	    Object[] data = {
	        pointDto.getPointNo(), pointDto.getPointName(),
	        pointDto.getPointSell(), pointDto.getPointCharge()
	    };
	    jdbcTemplate.update(sql, data);
	
	}
	
	
	
	public void connect(int pointNo, int attachNo) {
		String sql = "insert into image(point_no, attach_no) values(?, ?)";
		Object[] data = {pointNo, attachNo};
		jdbcTemplate.update(sql, data);
	}
	public List<PointDto> selectList() {
		String sql = "select * from point order by point_sell asc";
		return jdbcTemplate.query(sql, pointMapper);
	}
	public int findAttachNo(int pointNo) {
		String sql = "select attach_no from point_attach where point_no=?";
		Object[] data = {pointNo};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	public boolean delete(int pointNo) {
	    String sql = "delete from point where point_no = ?";
	    Object[] data = {pointNo};
	    return jdbcTemplate.update(sql, data) > 0;
	}
	
	public PointDto selectOne(int pointNo) {
		String sql = "select * from point where point_no = ?";
		Object[] data = {pointNo};
		List<PointDto> list = jdbcTemplate.query(sql, pointMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	public boolean update(PointDto pointDto) {
	    String sql = "update point "
	            + "set point_name = ?, point_sell = ?, point_charge = ? "
	            + "where point_no = ?";
	    Object[] data = {
	            pointDto.getPointName(), pointDto.getPointSell(),
	            pointDto.getPointCharge(), pointDto.getPointNo()
	    };
	    return jdbcTemplate.update(sql, data) > 0;
	}
	
}
