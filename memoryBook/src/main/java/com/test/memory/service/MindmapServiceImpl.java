package com.test.memory.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.memory.dao.MindmapDAO;
import com.test.memory.vo.MindMapVO;

@Service
public class MindmapServiceImpl implements MindmapService {
	@Autowired
	private MindmapDAO dao;
	
	@Override
	public int insertmap(MindMapVO vo)throws Exception {
		return dao.insertmap(vo);
	}

	@Override
	public List<MindMapVO> mindmapList(MindMapVO vo)throws Exception {
		
		return dao.mindmapList(vo);
	}
	
	@Override
	public int deletemap(MindMapVO vo)throws Exception{
		
		return dao.deletemap(vo);
	}
	
	@Override
	public int updatemap(MindMapVO vo)throws Exception{
		return dao.updatemap(vo);
	}
	
}
