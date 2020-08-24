package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import exception.BoardException;

import logic.DevService;
import logic.Goodorbad;

import logic.Subscribe;
import logic.TIL;
import logic.User;


@Controller // controller
@RequestMapping("til") // path
public class TILController {
	@Autowired
	DevService service;

	@GetMapping("*")
	public ModelAndView list(Integer no, Integer bno, HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		TIL til = null;
		if (bno == null) { // num �Ķ���Ͱ� ���� ���
			til = new TIL();
		} else {

			til = service.getTil(no, bno); // board:파라미터 bno에 해당하는 게시물 정보 저장
			System.out.println(
					"===============================================================================================");
		}
		System.out.println(til);
		
		mav.addObject("til", til);
		return mav;
	}

	@PostMapping("write")
	public ModelAndView board(TIL til, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			System.out.println(til);
			service.Til_insert(til);
			mav.setViewName("redirect:main.dev");

		} catch (Exception e) {
			e.printStackTrace();
			throw new BoardException("게시물 등록에 실패 했습니다.", "write.dev");
		}
		return mav;
	}

	@RequestMapping("main")
	public ModelAndView tillist(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<TIL> tillist = service.tillist();
		mav.addObject("tillist", tillist);

		return mav;

	}

	@RequestMapping("mytil")
	public ModelAndView mytillist(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String name = ((User)session.getAttribute("loginUser")).getName();
		List<TIL> tillist = service.mytillist(name);
		mav.addObject("tillist", tillist);

		return mav;

	}

	@GetMapping("delete")
	public ModelAndView delete(TIL til, Integer no, Integer bno, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		try {
			TIL dbTil = service.getTil(no, bno);

			System.out.println("dbTil:" + dbTil.getName());

			service.tilDelete(dbTil);
			mav.setViewName("redirect:main.dev");
			return mav;

		} catch (Exception e) {
			e.printStackTrace();

		}
		return mav;
	}
	
	@PostMapping("update")
	public ModelAndView update(TIL til, HttpServletRequest request) {
		System.out.println(til);
		ModelAndView mav= new ModelAndView();
		int no = Integer.parseInt(request.getParameter("no"));
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		til.setNo(no);
		til.setBno(bno);
		System.out.println(til);
		try {
			service.tilUpdate(til, request);
			
			mav.setViewName("redirect:info.dev?no=" + til.getNo() + "&bno=" + til.getBno());
		}catch(Exception e) {
			e.printStackTrace();
			throw new BoardException("게시물 수정 오류입니다.", "update.dev?no=" + til.getNo() + "&&bno=" + til.getBno());
		}
		
		return mav;
	}
	
	@GetMapping("info")
	public ModelAndView info(Integer no, Integer bno, HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		TIL til = null;
		if (bno == null) { 
			til = new TIL();
		} else {

			til = service.getTil(no, bno); // board:파라미터 bno에 해당하는 게시물 정보 저장
			System.out.println(
					"===============================================================================================");
		}
		User user = (User)session.getAttribute("loginUser");
		if (user != null) {
			String scrapped = til.getName();
			String scrapper = ((User)session.getAttribute("loginUser")).getName();
			Subscribe sub = new Subscribe();
			sub = service.getSubscribe(scrapper, scrapped);
			mav.addObject("sub",sub);
			
			
			
			
			String name=((User)session.getAttribute("loginUser")).getName();
			int wno=til.getBno();

			Goodorbad gob= new Goodorbad();
			gob = service.getPoint(no,wno,name); 
			mav.addObject("gob", gob);
			
			int count = service.getcount(no,bno);
			mav.addObject("count",count);
			
			
			System.out.println(gob);
			System.out.println("??????????????????");
			System.out.println(sub);
		}
		
		mav.addObject("til", til);
		return mav;
	}
	
	
	@RequestMapping("subuser")
	public ModelAndView subuser(Subscribe sub, HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		
		User scrapper = (User)session.getAttribute("loginUser");
		sub.setScrapper(scrapper.getName());
		List<User> list = service.getUserList();
		List<Subscribe> subuser = service.getsubuser();
		mav.addObject("list", list);
		mav.addObject("subuser", subuser);

		System.out.println("????"); 
		System.out.println(list);
		System.out.println(subuser);
		
		
		
	
		
		
		
		return mav;
	}
	

}
