package dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import dao.mapper.ReplyMapper;
import dao.mapper.SubscribeMapper;
import logic.Reply;
import logic.Subscribe;

@Repository
public class SubcribeDao {
	
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param= new HashMap<>();

	public void insert(Subscribe sub) {

			template.getMapper(SubscribeMapper.class).insert(sub); 
			
			
		
		
	}

	public void delete(Subscribe sub) {
		template.getMapper(SubscribeMapper.class).delete(sub); 
		
	}

	public Subscribe getSubscribe(String scrapper, String scrapped) {
		param.clear();
		param.put("scrapper",scrapper);
		param.put("scrapped",scrapped);
		return template.getMapper(SubscribeMapper.class).getSubscribe(param);
	}

}
