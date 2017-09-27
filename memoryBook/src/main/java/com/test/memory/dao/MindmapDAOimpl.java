package com.test.memory.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.memory.vo.MindMapVO;

@Repository
public class MindmapDAOimpl implements MindmapDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insertmap(MindMapVO vo) throws Exception {
		MindmapMapper mapper = sqlSession.getMapper(MindmapMapper.class);
		
		return mapper.insertmap(vo);
		
	}

	@Override
	public List<MindMapVO> mindmapList(MindMapVO vo)throws Exception {
		MindmapMapper mapper = sqlSession.getMapper(MindmapMapper.class);
		
		return mapper.mindmapList(vo);
		
	}
	
	@Override
	public int deletemap(MindMapVO vo)throws Exception{
		MindmapMapper mapper = sqlSession.getMapper(MindmapMapper.class);
		
		return mapper.deletemap(vo);
	}
	
	@Override
	public int updatemap(MindMapVO vo)throws Exception{
		MindmapMapper mapper = sqlSession.getMapper(MindmapMapper.class);
		
		return mapper.updatemap(vo);
	}

}
