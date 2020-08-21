package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.TIL;

public interface TilMapper {

	@Insert("insert into board(no,bno,name,title,content,regdate,open)"
			+" values (#{no},#{bno},#{name},#{title},#{content},now(),#{open})")
	void insert(TIL til);

	@Select("select ifnull(max(bno),0) from board")
	int maxnum();

	@Select("select * from board  where no = 3 and open=0 ORDER BY regdate desc")
	List<TIL> list(Map<String, Object> param);



	@Select("select no,bno,name,title,content,regdate,open from board where no=#{no} and bno=#{bno}")
	TIL selectOne(Map<String, Object> param);

	@Delete("delete from board where no= #{no} and bno=#{bno}")
	void delete(TIL til);

	@Update("update board set name= #{name}, title= #{title}, content= #{content}, open=#{open}   where no= #{no} and bno=#{bno}")
	void update(TIL til);
	
	@Select("select * from board where no = 3 and name=#{name} ORDER BY regdate desc")
	List<TIL> mytillist(Map<String, Object> param);

}
