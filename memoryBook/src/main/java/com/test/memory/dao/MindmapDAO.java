package com.test.memory.dao;

import java.util.List;

import com.test.memory.vo.MindMapVO;

public interface MindmapDAO {

	public int insertmap(MindMapVO vo)throws Exception;
	public List<MindMapVO> mindmapList(MindMapVO vo)throws Exception;
	public int deletemap(MindMapVO vo)throws Exception;
	public int updatemap(MindMapVO vo)throws Exception;
	
	
}
