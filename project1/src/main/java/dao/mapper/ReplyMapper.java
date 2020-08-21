package dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Reply;

public interface ReplyMapper {

	
	
	


    @Select("select ifnull(max(rno),0) from reply where no=#{no} and bno=#{bno} ")
	public int maxnum(Reply reply);

    
    @Insert("insert into reply (no,rno,bno,name,content,regdate) values(#{no},#{rno},#{bno},#{name},#{content},now())")
	public void replyInsert(Reply reply);

    @Select("select * from reply where no=#{no} and bno=${bno}")
	public List<Reply> replyList(Reply reply);



}
