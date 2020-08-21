package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.CoworkingMapper;
import logic.Coworking;
import logic.Hashtag;

@Repository
public class CoworkingDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>();

	public int getmaxno() {
		return template.getMapper(CoworkingMapper.class).getmaxcono();
	}

	public void insert(Coworking coworking) {
		template.getMapper(CoworkingMapper.class).insert(coworking);
	}

	public Coworking getdetails(Integer gno) {
		param.clear();
		param.put("gno",gno);
		return template.getMapper(CoworkingMapper.class).getdetails(gno);
	}

	public List<Coworking> getWorkinglist(String searchtype, String searchinput, String searchsort, int category) {
		param.clear();
		param.put("searchtype", searchtype);
		param.put("searchinput", searchinput);
		if(searchsort.equals("regdate")) param.put("searchsort", searchsort);
		if(category == 1) param.put("category", "스터디");
		else if(category == 2) param.put("category", "프로젝트");
		else if(category == 3) param.put("category", "공모전");
		System.out.println(param);
		if(searchtype != null && searchtype.equals("hashname")) return template.getMapper(CoworkingMapper.class).getHashWorkinglist(param);
		return template.getMapper(CoworkingMapper.class).getWorkinglist(param);
	}

	public void insertHashtag(Hashtag hash) {
		template.getMapper(CoworkingMapper.class).insertHashtag(hash);
	}

	public List<Hashtag> getHashtaglist() {
		return template.getMapper(CoworkingMapper.class).getHashtaglist();
	}

	public List<Coworking> getUsergroup(String name) {
		param.clear();
		param.put("name",name);
		return template.getMapper(CoworkingMapper.class).getUsergroup(param);
	}
}
