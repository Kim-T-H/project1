package logic;

import java.util.Date;

public class TIL {
	private int no;
	private int bno;
	private String name;
	private String title;
	private String content;
	private Date regdate;
	private boolean open;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public boolean isOpen() {
		return open;
	}
	public void setOpen(boolean open) {
		this.open = open;
	}
	@Override
	public String toString() {
		return "TIL [no=" + no + ", bno=" + bno + ", name=" + name + ", title=" + title + ", content=" + content
				+ ", regdate=" + regdate + ", open=" + open + "]";
	}
	
	
	
	
	
}
