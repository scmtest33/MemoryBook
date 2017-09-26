package com.test.memory.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.test.memory.vo.CategoryVO;
import com.test.memory.vo.NoteVO;

public interface NoteService {

	public int note(NoteVO note)throws Exception;

	public List<NoteVO> noteList(NoteVO note)throws Exception;

	public void deleteNote(int noteNo)throws Exception;

	public NoteVO noteDetail(int noteNo) throws Exception;

	public List<CategoryVO> addCategory(CategoryVO category) throws Exception;
	
	public List<CategoryVO> getCategory(CategoryVO category) throws Exception;

	public List<NoteVO> noteCategoryList(NoteVO note) throws Exception;

	public void deleteCategory(int categoryNo) throws Exception;

	public void noteUpdate(NoteVO note) throws Exception;

	public List<NoteVO> noteByDate(String date, int memberNo) throws Exception;

	public NoteVO emailNote(NoteVO note) throws Exception;

	public List<CategoryVO> getFriendCategory(CategoryVO category) throws Exception;

	public void ckeditorImageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile file) throws Exception;

	public void noteCategoryUpdate(CategoryVO category);

}
