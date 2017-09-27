package com.test.memory.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.test.memory.dao.NoteDao;
import com.test.memory.vo.CategoryVO;
import com.test.memory.vo.NoteVO;

@Service
public class NoteServiceImpl implements NoteService{
	
	@Autowired
	private NoteDao dao;

	@Override
	public int note(NoteVO note) throws Exception {
		dao.insertNote(note);
		return note.getNoteNo();
	}
	@Override
	public void noteUpdate(NoteVO note) throws Exception {
		dao.updateNote(note);
	}

	@Override
	public List<NoteVO> noteList(NoteVO note) throws Exception {
		return dao.noteList(note);
	}
	
	@Override
	public List<NoteVO> fnoteList(NoteVO note) throws Exception {
		return dao.fnoteList(note);
	}

	@Override
	public void deleteNote(int noteNo) throws Exception {
		dao.deleteNote(noteNo);
	}

	@Override
	public NoteVO noteDetail(int noteNo) throws Exception {
		return dao.noteDetail(noteNo);
	}

	@Override
	public List<CategoryVO> addCategory(CategoryVO category) throws Exception {
		dao.addCategory(category);
		return dao.getCategory(category.getMemberNo());

	}
	@Override
	public List<CategoryVO> getCategory(CategoryVO category) throws Exception {
		return dao.getCategory(category.getMemberNo());
	}

	@Override
	public List<NoteVO> noteCategoryList(NoteVO note) throws Exception {
		return dao.noteCategoryList(note);
	}

	@Override
	public void deleteCategory(int categoryNo) throws Exception {
		 dao.deleteCategory(categoryNo);
	}
	@Override
	public List<NoteVO> noteByDate(String date, int memberNo) throws Exception {
		String date1 = date + " 00:00:00";
		String date2 = date + " 23:59:59";
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("date1", date1);
		map.put("date2", date2);
		map.put("memberNo", memberNo);
		return dao.noteByDate(map);
	}
	@Override
	public NoteVO emailNote(NoteVO note) throws Exception {
		return dao.emailNote(note);
	}
	@Override
	public List<CategoryVO> getFriendCategory(CategoryVO category) {
		return dao.getFriendCategory(category.getMemberNo());
	}
	@Override
	public void ckeditorImageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile file)
			throws Exception {
			OutputStream out = null;
			PrintWriter printWriter = null;	
			String fileName = file.getOriginalFilename();
			String imgFormat = fileName.substring(fileName.lastIndexOf(".") + 1);
			//확장자 체크
			if (!imgFormat.equals("jpg")&&!imgFormat.equals("JPG")&&!imgFormat.equals("jpeg")&&!imgFormat.equals("JPEG")
					&&!imgFormat.equals("png")&&!imgFormat.equals("PNG")&&!imgFormat.equals("gif")&&!imgFormat.equals("GIF")) {
			//이미지 파일이 아닌경우
				printWriter = response.getWriter();
				String callback = request.getParameter("CKEditorFuncNum");
				System.out.println(callback);
				printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
			               + callback
			               + ",alert('이미지 파일만 올리실 수 있습니다. [지원 확장자: jpg, jpeg, png, gif]')"
			               + ")</script>");
				printWriter.flush();
			}
			//이미지 파일이 맞는 경우
			else {
			fileName = UUID.randomUUID().toString(); //이미지 파일명 암호화 (이름 중복방지 포함)
			byte[] bytes = file.getBytes();
			String uploadPath = "c:\\data\\img_data" + "\\" + fileName; //실제 저장경로
			System.out.println(uploadPath);
			out = new FileOutputStream(new File(uploadPath));
			out.write(bytes);
			String callback = request.getParameter("CKEditorFuncNum");
			printWriter = response.getWriter();
			String fileUrl = request.getContextPath()+ "/data/img_data" + "/" +fileName; //url 경로
			System.out.println(fileUrl);
			printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
		               + callback
		               + ",'"
		               + fileUrl
		               + "','이미지를 업로드 하였습니다.'"
		               + ")</script>");
		    printWriter.flush();
			}
	}
	@Override
	public void noteCategoryUpdate(CategoryVO category) {
		dao.noteCategoryUpdate(category);
	}
		
}
