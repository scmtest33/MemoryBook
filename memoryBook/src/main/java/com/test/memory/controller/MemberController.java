package com.test.memory.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.UUID;

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

import com.test.memory.dao.MemberDAO;
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
	
	@Autowired
	private MemberDAO dao;
	
		@RequestMapping(value = "main", method = RequestMethod.GET)
		public String main() {
			return "main"; 
		}
	
		@RequestMapping(value = "join", method = RequestMethod.POST)
		@ResponseBody
		public boolean join(MemberVO vo) {
			return service.join(vo);
		}
		
		@RequestMapping(value = "emailCheck", method = RequestMethod.POST)
		@ResponseBody
		public boolean emailCheck(String email, HttpSession session, Model model) {
			
			MemberVO vo = new MemberVO();
			vo.setEmail(email);
			
			MemberVO nvo = service.emailCheck(vo);
			if (nvo != null) {
				return false;
			} else return true;
		}
		
		@RequestMapping(value = "login", method = RequestMethod.POST)
		@ResponseBody
		public MemberVO login(String email,String mem_pwd, HttpSession session, Model model) {
			
			MemberVO vo = new MemberVO();
			vo.setEmail(email);
			vo.setMem_pwd(mem_pwd);
			
			
			MemberVO nvo = service.login(vo);
			if(nvo == null){
				return null;
			}
			else if(nvo.getApprovalNum()==1){
				return nvo;
			} else {
				System.out.println(nvo);
				String mem_img = nvo.getMem_image();
				if(mem_img == null) mem_img = "null";
				session.setAttribute("email", nvo.getEmail());
				session.setAttribute("memberNo", nvo.getMem_no());
				session.setAttribute("name", nvo.getName());
				session.setAttribute("infoNumber", nvo.getInfoNumber());
				session.setAttribute("mem_image", mem_img);
				return nvo;
			}
		}
		
		
		@RequestMapping(value = "login_ex", method = RequestMethod.POST)
		@ResponseBody
		public MemberVO login_ex(String email,String mem_pwd, HttpSession session, Model model) {
			MemberVO vo = new MemberVO();
			vo.setEmail(email);
			vo.setMem_pwd(mem_pwd);
			MemberVO nvo = service.login(vo); 
				session.setAttribute("email", nvo.getEmail());
				session.setAttribute("memberNo", nvo.getMem_no());
				session.setAttribute("name", nvo.getName());
				session.setAttribute("mem_image", nvo.getMem_image());
				session.setAttribute("infoNumber", nvo.getInfoNumber());
				return nvo;
			
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
		public ArrayList<MemberVO> findMember(HttpSession session, String findId, Model model) {
			String loginEmail = (String)session.getAttribute("email");
			return service.findMember(loginEmail, findId);
		}
		
		//친구추가
				@RequestMapping(value = "addFriend", method = RequestMethod.POST)
				@ResponseBody
				public boolean addFriend(HttpSession session, FriendVO friend) {
					String myEmail = (String)session.getAttribute("email");
					return service.addFriend(myEmail, friend);
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
		
		//프로필 사진 업로드
		@RequestMapping(value="/upload", method=RequestMethod.POST)
		@ResponseBody
		private String upload(HttpSession session,HttpServletRequest request, HttpServletResponse response, MultipartFile file, @RequestParam MultipartFile imageFile, Model model) throws Exception { 
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset-utf-8");
			try {
				OutputStream out = null;
				MemberVO vo = new MemberVO();
				String fileName = imageFile.getOriginalFilename();
				String imgFormat = fileName.substring(fileName.lastIndexOf(".") + 1);
				//확장자 체크
				if (!imgFormat.equals("jpg")&&!imgFormat.equals("JPG")&&!imgFormat.equals("jpeg")&&!imgFormat.equals("JPEG")
						&&!imgFormat.equals("png")&&!imgFormat.equals("PNG")&&!imgFormat.equals("gif")&&!imgFormat.equals("GIF")) {
				//이미지 파일이 아닌경우
					return "error";
				}
				//이미지 파일이 맞는 경우
				else {
				fileName = UUID.randomUUID().toString(); //이미지 파일명 암호화 (이름 중복방지 포함)
				
				byte[] bytes = imageFile.getBytes();
				String path = "c:\\data\\mem_image\\"; //폴더 위치
//				String path = "g:\\SPRING\\git\\data\\mem_image\\"; //폴더 위치
				String savePath = path + fileName; //실제 저장경로
				
				//파일저장
				out = new FileOutputStream(new File(savePath));
				out.write(bytes);
				
				//처리
				model.addAttribute("FileUrl", fileName);
				String img_file = (String)session.getAttribute("mem_image");
				String oldFilePath = path + img_file; //이전파일명 확보
				String email =(String)session.getAttribute("email");
				vo.setEmail(email);
				vo.setMem_image(fileName); //DB전송용 현재파일명 세팅
				dao.profilePhoto(vo);
				session.setAttribute("mem_image", fileName); //현재파일로 세션변경
				
				//이전파일 삭제
				if(oldFilePath != null && img_file != null) { //null인 경우에는 오류방지를 위해 미작동
					File oldFile = new File(oldFilePath); //내용 데이터파일 경로
					if(oldFile.exists()) oldFile.delete(); //내용 데이터파일 삭제처리
				}
				return fileName;
				}
			} catch (IOException e) {
				e.printStackTrace();
				return "IOException";
			}
		}
		
		//회원정보 수정
		@RequestMapping(value="/infoUpdate", method=RequestMethod.POST)
		@ResponseBody
		private boolean infoUpdate(MemberVO vo, HttpSession session, Model model) throws Exception { 
			System.out.println(vo);
			return service.infoUpdate(vo);
		}
		
		//내 프로필 정보 받아오기
		@RequestMapping(value = "myList", method = RequestMethod.GET)
		@ResponseBody
		public MemberVO myList(HttpSession session, Model model, MemberVO vo) {
			
			String email =(String)session.getAttribute("email");
			model.addAttribute("approvalnum", vo.getApprovalNum()).toString();
			return service.myList(email);
		}
}
