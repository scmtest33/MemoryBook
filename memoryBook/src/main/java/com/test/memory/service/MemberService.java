package com.test.memory.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.test.memory.vo.FriendVO;
import com.test.memory.vo.MemberVO;

public interface MemberService {
	public boolean join(MemberVO vo);
	public MemberVO emailCheck(MemberVO vo);
	public MemberVO login(MemberVO vo);
	public boolean unregister(MemberVO vo);
	public ArrayList<MemberVO> getList();
	public boolean click(MemberVO vo);
	public ArrayList<MemberVO> findMember(String loginEmail, String findId);
	public ArrayList<MemberVO> findMember2(String loginEmail, String findId);
	public boolean addFriend(String myEmail, FriendVO friend);
	public boolean deleteFriend(FriendVO friend);
	public ArrayList<FriendVO> getFriendList(String loginEmail);
	public int getFriendmemNo(String email);
	public boolean infoUpdate(MemberVO vo);
	public MemberVO myList(String email);
}
