package com.test.memory.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.memory.service.MemberService;
import com.test.memory.vo.FriendVO;
import com.test.memory.vo.MemberVO;

import org.springframework.ui.ModelMap; 
import org.springframework.web.bind.annotation.PathVariable; 
import org.springframework.web.bind.annotation.RequestMapping; 
import org.springframework.web.bind.annotation.RequestMethod; 
import org.springframework.web.bind.annotation.RequestParam; 
import org.springframework.web.multipart.MultipartFile; 


@Controller
@RequestMapping("/member")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService service;
	
		@RequestMapping(value = "join", method = RequestMethod.POST)
		@ResponseBody
		public boolean join(MemberVO vo) {
			System.out.println(vo);
			return service.join(vo);
		}
		
		
		@RequestMapping(value = "main", method = RequestMethod.GET)
		public String main() {
			return "main"; 
		}
		
		@RequestMapping(value = "login", method = RequestMethod.POST)
		@ResponseBody
		public MemberVO login(String email,String mem_pwd, HttpSession session, Model model) {
			System.out.println(email);
			System.out.println(mem_pwd);
			
			MemberVO vo = new MemberVO();
			vo.setEmail(email);
			vo.setMem_pwd(mem_pwd);
			
			
			MemberVO nvo = service.login(vo); 
			System.out.println(nvo + "메인 로그인");
			if(nvo == null){
				return null;
			}
			else if(nvo.getApprovalNum()==1){
				return nvo;
			}
			else{
				session.setAttribute("email", nvo.getEmail());
				session.setAttribute("memberNo", nvo.getMem_no());
				session.setAttribute("name", nvo.getName());
				return nvo;
			}
		}
		
		
		@RequestMapping(value = "login_ex", method = RequestMethod.POST)
		@ResponseBody
		public MemberVO login_ex(String email,String mem_pwd, HttpSession session, Model model) {
			System.out.println(email);
			MemberVO vo = new MemberVO();
			vo.setEmail(email);
			vo.setMem_pwd(mem_pwd);
			MemberVO nvo = service.login(vo); 
			if(nvo == null){
				return null;
			}
			else if(nvo.getApprovalNum()==1){
				return null;
			}
			else{
				session.setAttribute("email", nvo.getEmail());
				session.setAttribute("memberNo", nvo.getMem_no());
				session.setAttribute("name", nvo.getName());
				return nvo;
			}
		}
		
		
		//로그아웃
		@RequestMapping(value = "logout", method = RequestMethod.GET)
		public String logout(HttpSession session) {
			session.invalidate();
			return "redirect:/";
		}
		
		//회원탈퇴
		@RequestMapping(value = "unregister", method = RequestMethod.POST)
		public String unregister(MemberVO vo, HttpSession session, Model model) {
			String loginEmail = (String)session.getAttribute("email");
			vo.setEmail(loginEmail);
			boolean unregiResult = service.unregister(vo);
			model.addAttribute("unregiResult", unregiResult);
			if(unregiResult){
				session.invalidate();
				return "redirect:/";
			}else return "redirect:/index";
		}
		//리스트 출력
		@RequestMapping(value = "getList", method = RequestMethod.GET)
		@ResponseBody
		public ArrayList<MemberVO> getList() {
			return service.getList();
		}
		//정지 해제
		@RequestMapping(value = "click")
		@ResponseBody
		public boolean click(MemberVO vo) {
		
			return service.click(vo);
		}
		
		//멤버찾기
		@RequestMapping(value = "findMember", method = RequestMethod.POST)
		@ResponseBody
		public ArrayList<MemberVO> findMember(String findId, Model model) {
//					String loginEmail = (String)session.getAttribute("email");
			return service.findMember(findId);
		}
		
		//친구추가
		@RequestMapping(value = "addFriend", method = RequestMethod.POST)
		@ResponseBody
		public boolean addFriend(FriendVO friend) {
			return service.addFriend(friend);
		}
		
		//친구삭제
		@RequestMapping(value = "deleteFriend", method = RequestMethod.POST)
		@ResponseBody
		public boolean deleteFriend(FriendVO friend) {
			return service.deleteFriend(friend);
		}
		
		//친구목록불러오기
		@RequestMapping(value = "getFriendList", method = RequestMethod.POST)
		@ResponseBody
		public ArrayList<FriendVO> getFriendList(HttpSession session, Model model) {
			String loginEmail = (String)session.getAttribute("email");
			return service.getFriendList(loginEmail);
		}
		
		@RequestMapping(value = "getFriendmemNo", method = RequestMethod.POST)
		@ResponseBody
		public int getFriendmemNo(String email, Model model) {
			return service.getFriendmemNo(email);
		}
		
		@RequestMapping(value="/upload", method=RequestMethod.POST)
		@ResponseBody
		private void upload(HttpSession session,HttpServletRequest request, HttpServletResponse response, MultipartFile file, @RequestParam MultipartFile imageFile, Model model) throws Exception { 
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset-utf-8");
			
			try {
				service.setImage(request, response, imageFile);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
}
