package com.test.memory.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.test.memory.service.NoteService;
import com.test.memory.vo.CategoryVO;
import com.test.memory.vo.NoteVO;


@RestController
@RequestMapping("/note")
public class NoteController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	private FileInputStream fis;	//파일을 읽기위한
	private FileOutputStream fos;	//파일을 쓰기위한
	private ObjectInputStream ois;	//객체를 읽기위한
	private ObjectOutputStream oos;	//객체를 쓰기위한
	private String FILE_PATH = "C:/data/";
//	private String FILE_PATH = "G:/SPRING/git/data/";
	private String IMG_FILE_PATH = FILE_PATH+"img_data/"; //이미지파일 저장경로
	private String IMG_FILE_WPATH = "/data/img_data/"; //이미지파일 저장경로
	private String FILE_PATH_WEB = "http://localhost:8888/memory/data/img_data/"; //이미지파일 태그경로
	
	@Autowired
	private NoteService service;
	
	//노트 작성
	@RequestMapping("/note")
	public Map<String, Object> note(NoteVO note, HttpSession session) throws Exception {
		String FileName = UUID.randomUUID().toString(); //데이터 파일명 생성
		Map<String, Object> msg = new HashMap<>();
		
		//note데이터 save
		try{
			fos = new FileOutputStream(FILE_PATH + FileName);
			oos = new ObjectOutputStream(fos);
			oos.writeObject(note.getNoteContent());
		} catch(Exception e){
			// e.printStackTrace();
			System.out.println("[에러] 파일 쓰기에 실패했습니다.");
		} finally {
			note.setNoteContent(FileName); // 데이터 저장 후 내용을 파일이름으로 변경
			closeStreams();
			System.out.println(note);
			int noteNo = service.note(note);
			msg.put("msg", "새로운 노트가 등록되었습니다.");
			msg.put("noteNo", noteNo);
		}
		return msg;
	}
	
	//노트 수정
	@RequestMapping("/noteUpdate")
	public Map<String, Object> noteUpdate(NoteVO note, HttpServletRequest request, HttpSession session) throws Exception {
		String modified = UUID.randomUUID().toString(); //수정 된 파일명 생성
		Map<String, Object> msg = new HashMap<>();
		System.out.println(note);
		//note edit commit.
		NoteVO data = service.noteDetail(note.getNoteNo()); //원본 파일명 추출
		try{
			fos = new FileOutputStream(FILE_PATH + modified);
			oos = new ObjectOutputStream(fos);
			oos.writeObject(note.getNoteContent());
			} catch(Exception e){
				// e.printStackTrace();
				System.out.println("[에러] 파일 쓰기에 실패했습니다.");
			} finally {
				closeStreams();
				note.setNoteContent(modified); //연결파일이름을 수정된 파일명으로 설정
				service.noteUpdate(note);
				File file = new File(FILE_PATH + data.getNoteContent()); //수정 전 내용 데이터파일 경로
				if(file.exists()) file.delete(); //수정 전 내용 데이터파일 삭제처리
				msg.put("msg", "노트가 수정 되었습니다.");
				msg.put("noteNo", request.getParameter("noteNo"));
		}
		return msg;
	}
	
	//노트 내 이미지 업로드
	@RequestMapping(value="/note_img_upload", method=RequestMethod.POST)
	public void ckeditorImageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile file, @RequestParam MultipartFile upload) throws Exception {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset-utf-8");

		try {
			service.ckeditorImageUpload(request, response, upload);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/noteList")
	public List<NoteVO> noteList(HttpServletRequest request, HttpSession session) throws Exception {
		
		NoteVO note = new NoteVO();
		note.setMemberNo(Integer.parseInt(session.getAttribute("memberNo").toString()));
		note.setSearchWrd(request.getParameter("searchWrd"));

		List<NoteVO> noteList = service.noteList(note);
		for(NoteVO n : noteList){
			try{
				// 파일 스트림으로부터 파일명에 해당하는 파일을 읽어들인다
				fis = new FileInputStream(FILE_PATH + n.getNoteContent());
				
				// 파일 스트림으로부터 오브젝트 스트림 형태로 변경
				ois = new ObjectInputStream(fis);
				
				// 오브젝트 스트림으로부터 오브젝트를 읽어 String으로 형변환
				String content = (String) ois.readObject();
				n.setNoteContent(content);
				} catch(Exception e) {
					// e.printStackTrace();
					System.out.println("[에러] 파일 읽기에 실패하였습니다.");
				} finally {
					closeStreams();
			}
			Calendar cal = Calendar.getInstance();
			cal.setTime(n.getNoteRegDate());
			n.setNoteRegDate(cal.getTime());
		}
		return noteList;
	}
	
	//친구가 공개한 노트리스트 보기
	@RequestMapping("/friendNoteList")
	public List<NoteVO> friendNoteList(HttpServletRequest request) throws Exception {
		
		NoteVO note = new NoteVO();
		if(request.getParameter("friendNo").equals("")){
			note.setMemberNo(0);
		}else note.setMemberNo(Integer.parseInt(request.getParameter("friendNo")));


		List<NoteVO> noteList = service.fnoteList(note);
		for(NoteVO n : noteList){
			try{
				// 파일 스트림으로부터 파일명에 해당하는 파일을 읽어들인다
				fis = new FileInputStream(FILE_PATH + n.getNoteContent());
				
				// 파일 스트림으로부터 오브젝트 스트림 형태로 변경
				ois = new ObjectInputStream(fis);
				
				// 오브젝트 스트림으로부터 오브젝트를 읽어 String으로 형변환
				String content = (String) ois.readObject();
				n.setNoteContent(content);
				} catch(Exception e) {
					// e.printStackTrace();
					System.out.println("[에러] 파일 읽기에 실패하였습니다.");
				} finally {
					closeStreams();
			}
			Calendar cal = Calendar.getInstance();
			cal.setTime(n.getNoteRegDate());
			n.setNoteRegDate(cal.getTime());
		}
		return noteList;
	}
	
	//노트 카테고리 리스트
	@RequestMapping("/noteCategoryList")
	public List<NoteVO> noteCategoryList(HttpServletRequest request, HttpSession session) throws Exception {
		NoteVO note = new NoteVO();
		note.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
		note.setMemberNo(Integer.parseInt(session.getAttribute("memberNo").toString()));
		
		List<NoteVO> noteList = service.noteCategoryList(note);
		for(NoteVO n : noteList){
			try{
				// 파일 스트림으로부터 파일명에 해당하는 파일을 읽어들인다
				fis = new FileInputStream(FILE_PATH + n.getNoteContent());
				
				// 파일 스트림으로부터 오브젝트 스트림 형태로 변경
				ois = new ObjectInputStream(fis);
				
				// 오브젝트 스트림으로부터 오브젝트를 읽어 String으로 형변환
				String content = (String) ois.readObject();
				n.setNoteContent(content);
				} catch(Exception e) {
					// e.printStackTrace();
					System.out.println("[에러] 파일 읽기에 실패하였습니다.");
				} finally {
					closeStreams();
			}
			Calendar cal = Calendar.getInstance();
			cal.setTime(n.getNoteRegDate());
			n.setNoteRegDate(cal.getTime());
		}
		
		return noteList;
	}
	
	//카테고리 이름 수정
		@RequestMapping(value="/noteCategoryUpdate", method=RequestMethod.POST)
		public Map<String, Object> noteCategoryUpdate(CategoryVO category, HttpServletRequest request, HttpSession session) throws Exception {
			Map<String, Object> msg = new HashMap<>();
			category.setCategoryNo(Integer.parseInt(request.getParameter("categoryNo")));
			category.setCategoryName(request.getParameter("categoryName"));
			service.noteCategoryUpdate(category);
			return msg;
		}
	
	//친구의 노트 카테고리 리스트
	@RequestMapping("/freindNoteCategoryList")
	public List<NoteVO> freindNoteCategoryList(HttpServletRequest request) throws Exception {
		NoteVO note = new NoteVO();
		if((request.getParameter("friendCategoryNo").equals(""))||(request.getParameter("friendNo").equals(""))){
			note.setCategoryNo(0);
			note.setMemberNo(0);
		}else{
			note.setCategoryNo(Integer.parseInt(request.getParameter("friendCategoryNo")));
			note.setMemberNo(Integer.parseInt(request.getParameter("friendNo")));
		}
		
		List<NoteVO> noteList = service.noteCategoryList(note);
		for(NoteVO n : noteList){
			try{
				// 파일 스트림으로부터 파일명에 해당하는 파일을 읽어들인다
				fis = new FileInputStream(FILE_PATH + n.getNoteContent());
				
				// 파일 스트림으로부터 오브젝트 스트림 형태로 변경
				ois = new ObjectInputStream(fis);
				
				// 오브젝트 스트림으로부터 오브젝트를 읽어 String으로 형변환
				String content = (String) ois.readObject();
				n.setNoteContent(content);
				} catch(Exception e) {
					// e.printStackTrace();
					System.out.println("[에러] 파일 읽기에 실패하였습니다.");
				} finally {
					closeStreams();
			}
			Calendar cal = Calendar.getInstance();
			cal.setTime(n.getNoteRegDate());
			n.setNoteRegDate(cal.getTime());
		}
		
		return noteList;
	}
	
	//노트 작성일 검색
	@RequestMapping("/noteByDate")
	public List<NoteVO> noteByDate(HttpServletRequest request, HttpSession session) throws Exception {
		String date = request.getParameter("date");
		int memberNo = Integer.parseInt(session.getAttribute("memberNo").toString());
		
		List<NoteVO> noteList = service.noteByDate(date, memberNo);
		for(NoteVO n : noteList){
			Calendar cal = Calendar.getInstance();
			cal.setTime(n.getNoteRegDate());
			n.setNoteRegDate(cal.getTime());
		}
		
		return noteList;
	}
	
	//노트내용 보기
	@RequestMapping("/noteDetail")
	public NoteVO noteDetail(String noteNo) throws Exception {
		NoteVO n= service.noteDetail(Integer.parseInt(noteNo));
		try{
			// 파일 스트림으로부터 파일명에 해당하는 파일을 읽어들인다
			fis = new FileInputStream(FILE_PATH + n.getNoteContent());
			
			// 파일 스트림으로부터 오브젝트 스트림 형태로 변경
			ois = new ObjectInputStream(fis);
			
			// 오브젝트 스트림으로부터 오브젝트를 읽어 String형으로 형변환
			String content = (String) ois.readObject();
			n.setNoteContent(content);
			} catch(Exception e) {
				// e.printStackTrace();
				System.out.println("[에러] 파일 읽기에 실패하였습니다.");
			} finally {
				closeStreams();
		}
		Calendar cal = Calendar.getInstance();
		cal.setTime(n.getNoteRegDate());
		n.setNoteRegDate(cal.getTime());
		return n;
	}
	
	//노트 삭제
	@RequestMapping("/deleteNote")
	public Map<String, String> deleteNote(String noteNo) throws Exception {
		//삭제부
		NoteVO data = service.noteDetail(Integer.parseInt(noteNo));
		String fileName = data.getNoteContent(); //내용 데이터파일 이름추출
		service.deleteNote(Integer.parseInt(noteNo));
		File file = new File(FILE_PATH + fileName); //내용 데이터파일 경로
		if(file.exists()) file.delete(); //내용 데이터파일 삭제처리

		Map<String, String> msg = new HashMap<>();
		msg.put("msg", "노트가 삭제되었습니다.");
		return msg;
	}
	
	//카테고리 삭제
	@RequestMapping("/deleteCategory")
	public Map<String, String> deleteCategory(String categoryNo) throws Exception {
		service.deleteCategory(Integer.parseInt(categoryNo));
		Map<String, String> msg = new HashMap<>();
		msg.put("msg", "카테고리가 삭제되었습니다.");
		return msg;
	}
	
	//카테고리 등록
	@RequestMapping("/addCategory")
	public Map<String, Object> addCategory(HttpServletRequest request, HttpSession session) throws Exception {
		CategoryVO category = new CategoryVO();
		category.setCategoryName(request.getParameter("categoryName"));
		category.setMemberNo(Integer.parseInt(session.getAttribute("memberNo").toString()));
		
		List<CategoryVO> categoryList = service.addCategory(category);
		Map<String, Object> msg = new HashMap<>();
		msg.put("msg", "카테고리가 추가되었습니다.");
		msg.put("categoryList", categoryList);
		return msg;
	}
	
	//카테고리 가져오기
	@RequestMapping("/getCategory")
	public Map<String, Object> getCategory(HttpServletRequest request, HttpSession session) throws Exception {
		CategoryVO category = new CategoryVO();
		category.setMemberNo(Integer.parseInt(session.getAttribute("memberNo").toString()));
		
		List<CategoryVO> categoryList = service.getCategory(category);
		Map<String, Object> msg = new HashMap<>();
		msg.put("categoryList", categoryList);
		return msg;
	}
	
	//친구의 카테고리 가져오기
	@RequestMapping("/getFriendCategory")
	public Map<String, Object> getFriendCategory(HttpServletRequest request) throws Exception {
		//로그인시 처음에는 친구넘버 초기값이 클리어되어 있기때문에 에러발생 친구이름 클릭시 해결.  
		CategoryVO category = new CategoryVO();
		if(request.getParameter("friendNo").equals("")){
			category.setMemberNo(0);
		}else category.setMemberNo(Integer.parseInt(request.getParameter("friendNo")));
		
		List<CategoryVO> friendCategory = service.getFriendCategory(category);
		Map<String, Object> msg = new HashMap<>();
		msg.put("friendCategory", friendCategory);
		return msg;
	}
	
	//메일로 노트내용 보내기
	@RequestMapping("/mailNote")
	public Map<String, Object> mailNote(HttpServletRequest request, HttpSession m_session) throws Exception{
		// 메일발송 데이터 입력
		int noteNo = Integer.parseInt(request.getParameter("noteNo"));
		int memberNo = Integer.parseInt(m_session.getAttribute("memberNo").toString());

		NoteVO note = new NoteVO();
		note.setNoteNo(noteNo);
		note.setMemberNo(memberNo);
		NoteVO noteVO = service.emailNote(note);

		// 보내는 서버 주소
		String host = "smtp.naver.com";
		// 메일 제목 설정
		String subject = noteVO.getNoteTitle();
		// 메일 내용 읽어오기
		String content = noteVO.getNoteContent();
		// 보내는 사람 이메일 주소
		String from = "scmtest@naver.com";
		// 보내는사람 이름
		String writer = m_session.getAttribute("name").toString();
		// 받는사람 이메일주소
		String to = request.getParameter("emailTo");

		try {
			// 파일 스트림으로부터 파일명에 해당하는 파일을 읽어들인다
			fis = new FileInputStream(FILE_PATH + content);

			// 파일 스트림으로부터 오브젝트 스트림 형태로 변경
			ois = new ObjectInputStream(fis);

			// 오브젝트 스트림으로부터 오브젝트를 읽어 String형으로 형변환
			content = (String) ois.readObject();
		} catch (Exception e) {
			// e.printStackTrace();
			System.out.println("[에러] 파일 읽기에 실패하였습니다.");
		} finally {
			closeStreams();
		}

		Properties props = new Properties();
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.host", host);
		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.user", from);
		props.put("mail.smtp.auth", "true");

		Session session = Session.getDefaultInstance(props, new Authenticator() {
			@Override
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("scmtest", "13adqezc");
			}
		});

		Message message = new MimeMessage(session);

		try {
			StringBuffer sb = new StringBuffer();
			sb.append(subject);
			sb.append("<br>");
			sb.append(content);
			message.setFrom(new InternetAddress(from, MimeUtility.encodeText(writer, "UTF-8", "B")));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
			message.setSubject(subject);
			message.setContent(sb.toString(), "text/html;charset=UTF-8");
			Transport.send(message);
		} catch (MessagingException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}
        
    	Map<String, Object> msg = new HashMap<>();
		msg.put("msg", "이메일 보내기 완료");
        return msg;
    }
	
	//파일 관련 스트림 close
	private void closeStreams() {
		try {
			if(fis != null) fis.close();
			if(fos != null) fos.close();
			if(ois != null) ois.close();
			if(oos != null) oos.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
