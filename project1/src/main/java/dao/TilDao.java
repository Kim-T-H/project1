package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Repository;

import dao.mapper.BoardMapper;
import dao.mapper.TilMapper;
import logic.TIL;

@Repository
public class TilDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();

	public void insert(TIL til) {

		template.getMapper(TilMapper.class).insert(til);
	}

	public int maxnum() {
		return template.getMapper(TilMapper.class).maxnum();

	}

	public List<TIL> list() {
		param.clear();
		return template.getMapper(TilMapper.class).list(param);

	}

	public TIL selectOne(int no, int bno) {

		param.clear();
		param.put("no", no);
		param.put("bno", bno);
		return template.getMapper(TilMapper.class).selectOne(param);
	}

	public void delete(TIL til) {
		template.getMapper(TilMapper.class).delete(til);

	}

	public void update(TIL til) {
		template.getMapper(TilMapper.class).update(til);
		
	}

	public List<TIL> mytillist(String name) {
		param.clear();
		param.put("name", name);
		return template.getMapper(TilMapper.class).mytillist(param);
	}

	public int getcount(Integer no, Integer bno) {
		param.clear();
		param.put("no",no);	
		param.put("bno",bno);	
		return template.getMapper(TilMapper.class).getcount(param);
	}
}
