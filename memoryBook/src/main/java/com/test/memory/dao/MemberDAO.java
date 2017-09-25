package com.test.memory.dao;

import java.util.ArrayList;

import com.test.memory.vo.FriendVO;
import com.test.memory.vo.MemberVO;

public interface MemberDAO {
	public boolean join(MemberVO vo);
	public MemberVO emailCheck(MemberVO vo);
	public MemberVO login(MemberVO vo);
	public boolean unregister(MemberVO vo);
	public ArrayList<MemberVO> getList();
	public boolean click(MemberVO vo);
	public ArrayList<MemberVO> findMember(String findId);
	public boolean addFriend(String myEmail, FriendVO friend);
	public boolean friendCheck(String myEmail, FriendVO friend);
	public boolean deleteFriend(FriendVO friend);
	public ArrayList<FriendVO> getFriendList(String loginEmail);
	public int getFriendmemNo(String email);
	public boolean profilePhoto(MemberVO vo);
	public boolean infoUpdate(MemberVO vo);
}
