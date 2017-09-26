package com.test.memory.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.memory.vo.FriendVO;
import com.test.memory.vo.MemberVO;


@Repository
public class MemberDAOImpl implements MemberDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public boolean join(MemberVO vo) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		int num = mapper.join(vo);
		if(num == 1){
			return true;
		}
		return false;
	}
	
	@Override
	public MemberVO emailCheck(MemberVO vo) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.emailCheck(vo);
	}
	
	@Override
	public MemberVO login(MemberVO vo) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.login(vo);
	}
	
	@Override
	public boolean unregister(MemberVO vo) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			return mapper.unregister(vo);
	}

	@Override
	public ArrayList<MemberVO> getList() {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.getList();
	}
	
	@Override
	public boolean click(MemberVO vo) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.click(vo);
	}
	
	@Override
	public ArrayList<MemberVO> findMember(String loginEmail, String findId) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		System.out.println("지금 로그인한 이메일 : "+ loginEmail);
		ArrayList<MemberVO> list = mapper.findMember(loginEmail, findId); 
		return list;
	}
	
	@Override
	public boolean addFriend(String myEmail, FriendVO friend) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		if(friendCheck(myEmail, friend)){
			int num = mapper.addFriend(friend);
			if(num == 1){
				return true;
			}
			return false;
		}
		else return false;
	}
	
	@Override
	public boolean friendCheck(String myEmail, FriendVO friend) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		ArrayList<String> flist = mapper.friendCheck(myEmail);
		
		
		for(String friendMail : flist){
			System.out.println("친구목록에서 : " + friendMail);
			System.out.println("내가클릭한친구 : " + friend.getFriend_Email());
			
			
			if(friendMail.equals(friend.getFriend_Email())) {
				return false;
			}
		}
		return true;
	}
	
	@Override
	public boolean deleteFriend(FriendVO friend) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		int num = mapper.deleteFriend(friend);
		if(num == 1){
			return true;
		}
		return false;
	}
	
	@Override
	public ArrayList<FriendVO> getFriendList(String loginEmail) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.getFriendList(loginEmail);
	}

	@Override
	public int getFriendmemNo(String email) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.getFriendmemNo(email);
	}

	@Override
	public boolean profilePhoto(MemberVO vo) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.profilePhoto(vo);
	}
	
	@Override
	public boolean infoUpdate(MemberVO vo) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.infoUpdate(vo);
	}
	
	@Override
	public MemberVO myList(String email) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.myList(email);
	}
}
