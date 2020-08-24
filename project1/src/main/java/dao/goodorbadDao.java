package dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import dao.mapper.GoodorbadMapper;

import logic.Goodorbad;

@Repository
public class goodorbadDao {

	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>();
	
	
	public void insert(Goodorbad gob) {
		template.getMapper(GoodorbadMapper.class).insert(gob);
	}

	public int getmaxgno(int no, int wno) {
		param.clear();
		param.put("no",no);
		param.put("wno",wno);
		return template.getMapper(GoodorbadMapper.class).getmaxgno(param);
	}

	public void likedelete(int no, int wno, String name) {
		param.clear();
		param.put("no",no);
		param.put("wno",wno);
		param.put("name",name);
		System.out.println(param);
		template.getMapper(GoodorbadMapper.class).likedelete(param);
	}

	public Goodorbad getlike(Integer no, int wno, String name) {
		param.clear();
		param.put("no",no);
		param.put("wno",wno);
		param.put("name",name);
		
		System.out.println(param);
		return template.getMapper(GoodorbadMapper.class).getlike(param);
	}
	
	
	
	

}
