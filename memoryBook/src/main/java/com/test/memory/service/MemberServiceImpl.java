package com.test.memory.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.test.memory.dao.MemberDAO;
import com.test.memory.vo.FriendVO;
import com.test.memory.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDAO dao;
	
	@Override
	public boolean join(MemberVO vo) {
		return dao.join(vo);
	}

	@Override
	public MemberVO emailCheck(MemberVO vo) {
		return dao.emailCheck(vo);
	}
	
	@Override
	public MemberVO login(MemberVO vo) {
		return dao.login(vo);
	}
	
	@Override
	public boolean unregister(MemberVO vo) {
		return dao.unregister(vo);
	}

	@Override
	public ArrayList<MemberVO> getList() {
		return dao.getList();
		
	}

	@Override
	public boolean click(MemberVO vo) {
		return dao.click(vo);
	}
	
	@Override
	public ArrayList<MemberVO> findMember(String findId) {
		return dao.findMember(findId);
	}
	
	@Override
	public boolean addFriend(String myEmail, FriendVO friend) {
		return dao.addFriend(myEmail, friend);
	}
	
	@Override
	public boolean deleteFriend(FriendVO friend) {
		return dao.deleteFriend(friend);
	}
	
	@Override
	public ArrayList<FriendVO> getFriendList(String loginEmail) {
		return dao.getFriendList(loginEmail);
	}

	@Override
	public int getFriendmemNo(String email) {
		return dao.getFriendmemNo(email);
	}
	
	@Override
	public boolean infoUpdate(MemberVO vo) {
		return dao.infoUpdate(vo);
	}
}
