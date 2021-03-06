package com.test.memory.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;
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
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.test.memory.service.DragService;
import com.test.memory.vo.DragVO;


@RestController
@RequestMapping("/drag")
public class DragController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	private FileInputStream fis;	//파일을 읽기위한 스트림
	private FileOutputStream fos;	//파일을 쓰기위한 스트림
	private ObjectInputStream ois;	//객체를 읽기위한 스트림
	private ObjectOutputStream oos;	//객체를 쓰기위한 스트림
	private ArrayList<String> IMG_REF = new ArrayList<>(); //이미지 경로를 저장하는 배열변수
	private ArrayList<String> IMG_FILE = new ArrayList<>(); //이미지 파일명을 저장하는 배열변수
	private String FILE_PATH = "C:/data/";
//	private String FILE_PATH = "G:/SPRING/git/data/";
	private String IMG_FILE_PATH = FILE_PATH+"img_data/"; //이미지파일 저장경로
	private String FILE_PATH_WEB = "http://localhost:8888/memory/data/img_data/"; //이미지파일 태그경로
	
	@Autowired
	private DragService service;
	
	//드래그 등록
	@RequestMapping("/registDrag")
	public Map<String, String> registDrag(DragVO drag, HttpSession session) throws Exception {
		// 태그 저장부
		byte ptext[] = drag.getDragContent().getBytes();
		String value = new String(ptext, "UTF-8").replaceAll("amp;", "&").replaceAll("&lt;", "<").replaceAll("&gt;", ">");

		// 이미지 추출부
		Pattern p = Pattern.compile("<img\\s+([a-zA-Z0-9]+\\s*=\\s*\"?.*?)?\\s*src\\s*=\\s*\"?(.*?)[\"|>]", Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(value);
		while(m.find()) { 
			String imagePath = m.group(2); // img 태그내 src값 추출결과
			String imageTag = imagePath; // src태그에 삽입 될 내용 - 태그적용시 옵션 짤림방지
			// 파일저장시 불필요한 옵션 자르기 (ex> ?type=w540, 옵션이 있는 경우에만 작동)
			if(imagePath.lastIndexOf("?") > 0) {
				imagePath = imagePath.substring(0, imagePath.lastIndexOf("?"));
			}
			
			// 이미지를 읽어와서 BufferedImage에 넣는다.
			BufferedImage image = ImageIO.read(new URL(imagePath));

			// 파일명 자르기
			String imgFile = imagePath.substring(imagePath.lastIndexOf("/") + 1);

			// 확장자 자르기
			String imgFormat = imgFile.substring(imgFile.lastIndexOf(".") + 1);
			
			// 파일이름 변환
			String imgName = UUID.randomUUID().toString();

			// 해당경로에 이미지를 저장함.
			try {
				ImageIO.write(image, imgFormat, new File(IMG_FILE_PATH + imgName));
			} catch (Exception e) { // 오류발생시 취소하면서 이미 저장된 이미지파일 및 리스트 삭제
				//e.printStackTrace();
				for (int i = 0; i < IMG_FILE.size(); i++) {
					File file = new File(FILE_PATH + IMG_FILE.get(i)); //내용 데이터파일 경로
					if(file.exists()) file.delete(); //내용 데이터파일 삭제처리
				}
				IMG_REF.clear();
				IMG_FILE.clear();
				System.out.println("[에러] 이미지파일 저장 실패");
			} finally {
				IMG_REF.add(imageTag);
				IMG_FILE.add(imgName);
			}
		}
		
		// 이미지태그 경로 변환부 (img태그가 있는 경우에만 작동)
		if (!IMG_REF.isEmpty()) {
			for (int i = 0; i < IMG_REF.size(); i++) {
				value = value.replaceAll(IMG_REF.get(i), FILE_PATH_WEB + IMG_FILE.get(i));
			}
		}

		// drag데이터 save
		String FileName = UUID.randomUUID().toString();
		try {
			fos = new FileOutputStream(FILE_PATH + FileName);
			oos = new ObjectOutputStream(fos);
			oos.writeObject(value);
			drag.setDragContent(FileName);
			System.out.println("저장완료");
		} catch (Exception e) { // 오류발생시 취소하면서 저장된 데이터 및 리스트 삭제
			// e.printStackTrace();
			for (int i = 0; i < IMG_FILE.size(); i++) {
				File img_File = new File(FILE_PATH + IMG_FILE.get(i)); //이미지 데이터파일 경로
				if(img_File.exists()) img_File.delete(); //해당 이미지파일 삭제처리
			}
			File data_File = new File(FILE_PATH + FileName); //내용 데이터파일 경로
			if(data_File.exists()) data_File.delete(); //해당 데이터파일 삭제처리
			IMG_FILE.clear();
			IMG_REF.clear();
			drag.setDragContent(null);
			System.out.println("[에러] 데이터 파일 쓰기 실패");
		} finally {
			closeStreams();
		}

		// drag url추출부
		if (drag.getDragUrl() != null) {
			drag.setDragUrl(drag.getDragUrl().replaceAll("nun;", "=").replaceAll("amp;", "&"));
		} else {
			drag.setDragUrl("none");
		}
		
		// drag 타이틀 추출부
		if (drag.getDragUrlTitle() != null) {
			drag.setDragUrlTitle(drag.getDragUrlTitle());
		} else {
			drag.setDragUrlTitle("제목 없음");
		}

		// 회원번호 추출부
		drag.setMemberNo(Integer.parseInt(session.getAttribute("memberNo").toString()));

		// DB저장부
		service.insertDrag(drag);

		// 이미지 리스트 초기화
		IMG_FILE.clear();
		IMG_REF.clear();

		Map<String, String> msg = new HashMap<>();
		msg.put("msg", "새로운 드래그가 등록되었습니다.");
		return msg;
	}
	
	
	//드래그 리스트
	@RequestMapping("/dragList")
	public List<DragVO> dragList(HttpServletRequest request, HttpSession session) throws Exception {
		DragVO drag = new DragVO();
		drag.setMemberNo(Integer.parseInt(session.getAttribute("memberNo").toString()));
		drag.setSearchWrd(request.getParameter("searchWrd_drag"));
		
		List<DragVO> dragList = service.dragList(drag);
		for(DragVO n : dragList){
			try{
				// 파일 스트림으로부터 파일명에 해당하는 파일을 읽어들인다
				fis = new FileInputStream(FILE_PATH + n.getDragContent());
				
				// 파일 스트림으로부터 오브젝트 스트림 형태로 변경
				ois = new ObjectInputStream(fis);
				
				// 오브젝트 스트림으로부터 오브젝트를 읽어 String으로 형변환
				String content = (String) ois.readObject();
				n.setDragContent(content);
				} catch(Exception e) {
					// e.printStackTrace();
					System.out.println("[에러] 파일 읽기에 실패하였습니다.");
				} finally {
					closeStreams();
			}
			Calendar cal = Calendar.getInstance();
			cal.setTime(n.getDragRegDate());
			n.setDragRegDate(cal.getTime());
		}
		
		return dragList;
	}
	
	
	//드래그 선택
	@RequestMapping("/selectDrag")
	public DragVO selectDrag(String dragNo) throws Exception {
		DragVO n = service.selectDrag(Integer.parseInt(dragNo));
		try{
			// 파일 스트림으로부터 파일명에 해당하는 파일을 읽어들인다
			fis = new FileInputStream(FILE_PATH + n.getDragContent());
			
			// 파일 스트림으로부터 오브젝트 스트림 형태로 변경
			ois = new ObjectInputStream(fis);
			
			// 오브젝트 스트림으로부터 오브젝트를 읽어 String으로 형변환
			String content = (String) ois.readObject();
			n.setDragContent(content);
			} catch(Exception e) {
				// e.printStackTrace();
				System.out.println("[에러] 파일 읽기에 실패하였습니다.");
			} finally {
				closeStreams();
		}
		Calendar cal = Calendar.getInstance();
		cal.setTime(n.getDragRegDate());
		n.setDragRegDate(cal.getTime());
		return n;
	}
	
	
	//드래그 내용 보기
	@RequestMapping("/dragDetail")
	public DragVO dragDetail(String dragNo) throws Exception {
		DragVO d = service.dragDetail(Integer.parseInt(dragNo));
		try{
			// 파일 스트림으로부터 파일명에 해당하는 파일을 읽어들인다
			fis = new FileInputStream(FILE_PATH + d.getDragContent());
			
			// 파일 스트림으로부터 오브젝트 스트림 형태로 변경
			ois = new ObjectInputStream(fis);
			
			// 오브젝트 스트림으로부터 오브젝트를 읽어 String형으로 형변환
			String content = (String) ois.readObject();
			d.setDragContent(content);
			} catch(Exception e) {
				// e.printStackTrace();
				System.out.println("[에러] 파일 읽기에 실패하였습니다.");
			} finally {
				closeStreams();
		}
		Calendar cal = Calendar.getInstance();
		cal.setTime(d.getDragRegDate());
		d.setDragRegDate(cal.getTime());
		return d;
	}
	
	
	//드래그 삭제
	@RequestMapping("/deleteDrag")
	public Map<String, String> deleteNote(String dragNo) throws Exception {
		DragVO data = service.selectDrag(Integer.parseInt(dragNo));
		String fileName = data.getDragContent();
		service.deleteDrag(Integer.parseInt(dragNo));
		File file = new File(FILE_PATH + fileName); //내용 데이터파일 경로
		if(file.exists()) file.delete(); //내용 데이터파일 삭제처리
		Map<String, String> msg = new HashMap<>();
		msg.put("msg", "드래그가 삭제 되었습니다.");
		return msg;
	}
	
	
	//드래그 내용 메일로 보내기
	@RequestMapping("/mailDrag")
	public Map<String, Object> mailDrag(HttpServletRequest request, HttpSession m_session) throws Exception{
	    //메일발송 데이터 입력
		int dragNo = Integer.parseInt(request.getParameter("dragNo"));
	    int memberNo = Integer.parseInt(m_session.getAttribute("memberNo").toString());
	   
	    DragVO drag = new DragVO();
	    drag.setDragNo(dragNo);
	    drag.setMemberNo(memberNo);
	    DragVO dragVO = service.emailDrag(drag);
		
		//보내는 서버 주소
		String host = "smtp.naver.com";		// here
		//메일 제목 설정
		String subject = dragVO.getDragUrlTitle(); 
		//메일 내용 읽어오기
		String content = dragVO.getDragContent();
		//보내는 사람 이메일 주소
		String from = "scmtest@naver.com";
		//보내는사람 이름
		String writer = m_session.getAttribute("name").toString();
		//받는사람 이메일주소
		String to = request.getParameter("emailTo");
		
		try{
		// 파일 스트림으로부터 파일명에 해당하는 파일을 읽어들인다
		fis = new FileInputStream(FILE_PATH + content);
		
		// 파일 스트림으로부터 오브젝트 스트림 형태로 변경
		ois = new ObjectInputStream(fis);
		
		// 오브젝트 스트림으로부터 오브젝트를 읽어 String형으로 형변환
		content = (String) ois.readObject();
		} catch(Exception e) {
			// e.printStackTrace();
			System.out.println("[에러] 파일 읽기에 실패하였습니다.");
		} finally {
			closeStreams();
		}
		
		Properties props = new Properties();
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.host", host);
		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory" );
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.user", from);
		props.put("mail.smtp.auth", "true");
		
		Session session = Session.getDefaultInstance(props, new Authenticator() {
			@Override
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("scmtest","13adqezc");
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
