package controller;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import logic.Coworking;
import logic.DevService;
import logic.Hashtag;
import logic.Message;
import logic.Reply;
import logic.Report;
import logic.SNSFile;
import logic.Subscribe;
import logic.TIL;
import logic.User;

@RestController // @ResponseBody: View 없이 직접 데이터를 클라이언트에 전송
@RequestMapping("ajax")
public class AjaxController {

	@Autowired
	private DevService service;

	@RequestMapping(value = "fileupload", produces = "text/plain; charset=UTF-8", method = RequestMethod.POST)
	public String fileupload(MultipartFile[] files, HttpServletRequest request) {
		System.out.println("ajax");
		System.out.println(files);
		for (MultipartFile file : files) {
			System.out.println(file.getOriginalFilename());
			service.uploadFileCreate(file, request, "test/file/");
			SNSFile f = service.maxfno();
			f.setfileurl("file/");
			f.setFilename(file.getOriginalFilename());
			service.insert_file(f);
		}
		return null;
	}

	@RequestMapping(value = "hashtag", produces = "text/plain; charset=UTF-8", method = RequestMethod.POST)
	public String hashtag(HttpServletRequest request) {
		String[] arr = request.getParameterValues("hash");
		System.out.println(Arrays.toString(arr));
		Hashtag hash = new Hashtag();
		hash.setNo(6);
		hash.setWno(service.getmaxcono() + 1);
		for (int i = 0; i < arr.length; i++) {
			hash.setHno(i + 1);
			hash.setHashname(arr[i]);
			service.insertHashtag(hash);
		}
		return null;
	}

	@RequestMapping(value = "searchworking", produces = "text/plain; charset=UTF-8", method = RequestMethod.POST)
	public String searchworking(HttpServletRequest request) {
		String searchinput = request.getParameter("searchinput");
		String searchtype = request.getParameter("searchtype");
		String searchsort = request.getParameter("searchsort");
		int category = Integer.parseInt(request.getParameter("category"));
		System.out.println(request.getParameter("searchinput"));
		System.out.println(request.getParameter("searchtype"));
		if (searchinput.trim().equals("")) {
			searchinput = null;
			searchtype = null;
		}
		List<Coworking> list = service.getWorkinglist(searchtype, searchinput, searchsort, category);
		List<Hashtag> hash = service.getHashtaglist();
		HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
		for (int i = 0; i < list.size(); i++) {
			map.put(list.get(i).getGno(), i);
		}
		for (Hashtag h : hash) {
			if (map.containsKey(h.getWno())) {
				list.get(map.get(h.getWno())).addHashlist(h.getHashname());
			}

		}
		StringBuilder sb = new StringBuilder("[");
		int i = 0;
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		for (Coworking co : list) {
			sb.append("{\"gno\":\"" + co.getGno() + "\",");
			sb.append("\"name\":\"" + co.getName() + "\",");
			sb.append("\"title\":\"" + co.getTitle() + "\",");
			sb.append("\"category\":\"" + co.getCategory() + "\",");
			sb.append("\"content\":\"" + co.getContent() + "\",");
			sb.append("\"maxnum\":\"" + co.getMaxnum() + "\",");
			sb.append("\"startdate\":\"" + sf.format(co.getStartdate()) + "\",");
			sb.append("\"enddate\":\"" + sf.format(co.getEnddate()) + "\",");
			sb.append("\"deadline\":\"" + sf.format(co.getDeadline()) + "\",");
			sb.append("\"hashlist\":[");
			for (int j = 0; j < co.getHashlist().size(); j++) {
				sb.append("\"" + co.getHashlist().get(j) + "\"");
				if (j < co.getHashlist().size() - 1)
					sb.append(",");
			}
			sb.append("]}");
			i++;
			if (i < list.size())
				sb.append(",");
		}
		sb.append("]");
		System.out.println(sb);
		return sb.toString();
	}

	@PostMapping(value = "findid", produces = "text/plain; charset=UTF-8")
	public String findid(HttpServletRequest request) {
		String name = request.getParameter("name");
		String email = request.getParameter("email");

		String id = service.findId(name, email);
		if (id != null) {
			return "회원님의 아이디는 " + id + "입니다.";
		} else {
			return "해당 아이디가 존재하지 않습니다.";
		}
	}
	
	@PostMapping(value = "findpw", produces = "text/plain; charset=UTF-8")
	public String findpw(HttpServletRequest request) {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String pw = service.findPw(id, name, email);
		if (pw != null) {
			return "회원님의 비밀번호는 " + pw + "입니다.";
		} else {
			return "입력하신 정보가 잘못되었습니다.";
		}
	}

	@PostMapping(value = "changepw", produces = "text/plain; charset=UTF-8")
	public String changepw(HttpServletRequest request) {
		String currentpw = request.getParameter("currentpw");
		String newpw = request.getParameter("newpw");
		String newpw2 = request.getParameter("newpw2");

		String id = request.getParameter("id");

		System.out.println("" + currentpw + newpw + id);

		User DBUser = service.getUser(id);

		if(!currentpw.equals(DBUser.getPw())) {
			return "현재 비밀번호를 확인하세요";
		} else if (newpw.equals(DBUser.getPw())) {
			return "변경 비밀번호와 현재 비밀번호가 같습니다.";
		} else if (newpw.length() < 4) {
			return "비밀번호는 4자 이상 입력하세요";
		} else if (!newpw.equals(newpw2) ) {
			return "입력하신 정보에 오류가 있습니다.";
		} else {
			service.changepw(id, newpw);
			return "비밀번호가 변경되었습니다.";
		}
	}

	@PostMapping(value = "sendMessage", produces = "text/plain; charset=UTF-8")
	public String sendMessage(HttpServletRequest request) {
		try {
			String me_from = request.getParameter("me_from");
			String me_to = request.getParameter("me_to");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			int meno = service.maxmno() + 1;

			Message msg = new Message();
			msg.setMeno(meno);
			msg.setMe_from(me_from);
			msg.setMe_to(me_to);
			msg.setTitle(title);
			msg.setContent(content);

			service.messageInsert(msg);
			return "쪽지를 발송했습니다";
		} catch (Exception e) {
			return "오류가 발생했습니다";
		}
	}

	@PostMapping(value = "report", produces = "text/plain; charset=UTF-8")
	public String report(HttpServletRequest request) {
		try {
			String content = request.getParameter(("content"));
			String reportedName = request.getParameter("reportedName");
			int no = Integer.parseInt(request.getParameter("no"));
			int wno = service.getmaxwno_Report(no) + 1;
			int reno = service.getmaxreno_Report() +1;

			Report report = new Report();
			report.setNo(no);
			report.setWno(wno);
			report.setReno(reno);
			report.setName(reportedName);
			report.setContent(content);

			System.out.println(report);
			service.reportInsert(report);
			return "신고가 완료되었습니다";
		} catch (Exception e) {
			return "오류가 발생했습니다";
		}

	}

	@RequestMapping(value = "commentinsert", produces = "text/plain; charset=UTF-8", method = RequestMethod.POST)
	public String commentinsert(HttpServletRequest request) {
		System.out.println("ajax");
		Reply reply = new Reply();
		reply.setNo(Integer.parseInt(request.getParameter("no")));
		reply.setBno(Integer.parseInt(request.getParameter("bno")));
		reply.setContent(request.getParameter("content"));
		reply.setName(request.getParameter("name"));
		System.out.println(reply);

		service.replyInsert(reply);
		return null;
	}

	@RequestMapping(value = "commentList", produces = "text/plain; charset=UTF-8", method = RequestMethod.GET)
	public String commentList(HttpServletRequest request) {
		System.out.println("ajax");
		Reply reply = new Reply();
		reply.setNo(Integer.parseInt(request.getParameter("no")));
		reply.setBno(Integer.parseInt(request.getParameter("bno")));
		List<Reply> replylist = service.replyList(reply);
		System.out.println(replylist);
		StringBuilder sb = new StringBuilder();
		sb.append("[");
		int i = 0;
		for (Reply r : replylist) {
			sb.append("{\"no\":\"" + r.getNo() + "\",");
			sb.append("\"rno\":\"" + r.getRno() + "\",");
			sb.append("\"bno\":\"" + r.getBno() + "\",");
			sb.append("\"name\":\"" + r.getName() + "\",");
			sb.append("\"content\":\"" + r.getContent() + "\",");
			sb.append("\"regdate\":\"" + r.getRegdate() + "\"}");
			i++;
			if (i < replylist.size())
				sb.append(",");
		}
		sb.append("]");
		System.out.println(sb);
		return sb.toString();
	}
	
	@PostMapping(value = "subinsert", produces="text/plain; charset=UTF-8")
	public String subinsert(HttpServletRequest request, HttpSession session) {
		Subscribe sub = new Subscribe(); //로직 호출
		
		String scrapped = request.getParameter("name"); 
		User scrapper = (User)session.getAttribute("loginUser");
		
		
		sub.setScrapped(scrapped);
		sub.setScrapper(scrapper.getName());
		
		
		
		service.subinsert(sub);
		
		return null;
	}
	
	@PostMapping(value = "subdelete", produces="text/plain; charset=UTF-8")
	public String subdelete(HttpServletRequest request, HttpSession session) {
		Subscribe sub = new Subscribe(); //로직 호출
		
		String scrapped = request.getParameter("name"); 
		User scrapper = (User)session.getAttribute("loginUser");
		System.out.println(scrapper);
		System.out.println(scrapped);
		
		sub.setScrapped(scrapped);
		sub.setScrapper(scrapper.getName());
		
		
		
		service.subdelete(sub);
		
		return null;
	}
	
	
	
	
	
}
