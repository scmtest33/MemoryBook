package com.test.memory.dao;

import java.util.ArrayList;

import com.test.memory.vo.FriendVO;
import com.test.memory.vo.MemberVO;

public interface MemberMapper {
	public int join(MemberVO vo);
	public MemberVO emailCheck(MemberVO vo);
	public MemberVO login(MemberVO vo);
	public boolean unregister(MemberVO vo);
	public ArrayList<MemberVO> getList();
	public boolean click(MemberVO vo);
	public ArrayList<MemberVO> findMember(String loginEmail, String findId);
	public int addFriend(FriendVO friend);
	public ArrayList<String> friendCheck(String myEmail);
	public int deleteFriend(FriendVO friend);
	public ArrayList<FriendVO> getFriendList(String loginEmail);
	public int getFriendmemNo(String email);
	public boolean profilePhoto(MemberVO vo);
	public boolean infoUpdate(MemberVO vo);
	public MemberVO myList(String email);
}
