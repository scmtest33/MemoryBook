package com.test.memory.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.memory.dao.MemberDAO;
import com.test.memory.dao.MindmapDAO;
import com.test.memory.service.MemberService;
import com.test.memory.service.MindmapService;
import com.test.memory.vo.FriendVO;
import com.test.memory.vo.MemberVO;
import com.test.memory.vo.MindMapVO;

import org.springframework.ui.ModelMap; 
import org.springframework.web.bind.annotation.PathVariable; 
import org.springframework.web.bind.annotation.RequestMapping; 
import org.springframework.web.bind.annotation.RequestMethod; 
import org.springframework.web.bind.annotation.RequestParam; 
import org.springframework.web.multipart.MultipartFile; 


@Controller
@RequestMapping("/mindmap")
public class MindMapController {
	
	private static final Logger logger = LoggerFactory.getLogger(MindMapController.class);
	
	@Autowired
	private MindmapService mind;
	
	@Autowired
	private MindmapDAO dao;
	
		
		
		@RequestMapping(value="save", method=RequestMethod.POST)
		@ResponseBody
		private String insertmap(MindMapVO vo, Model model) throws Exception { 
			System.out.println(vo.getMem_no());
			System.out.println(vo.getMindjson());
			System.out.println(vo.getMindname());
			int re = mind.insertmap(vo);
			
			
			if(re == 1){
				return "true";
			}
			
			return "false";
			
			
			
		/*	try {
				OutputStream out = null;
				String jsonname = UUID.randomUUID().toString() + ".json";
				
				byte[] bytes = text1.getBytes();
				String path = "c:\\data\\mem_mindmap\\";
				
				String savePath = path + jsonname;
				
				out = new FileOutputStream(new File(savePath));
				out.write(bytes);
				
				return "true";
				
			} catch (Exception e) {
				
				return "false";
				
			}*/
							
			
		}
		
		@RequestMapping(value="load", method=RequestMethod.POST)
		@ResponseBody
		private List<MindMapVO> load(MindMapVO vo) throws Exception{
			System.out.println(vo.getMem_no());
			List<MindMapVO> mv = mind.mindmapList(vo);
			System.out.println(mv);
			
			return mv;
		
		}
		
		@RequestMapping(value="delete", method=RequestMethod.POST)
		@ResponseBody
		private String deletemap(MindMapVO vo) throws Exception{
			System.out.println(vo.getMindnum());
			int r = mind.deletemap(vo);
			System.out.println(r);
			
			if(r == 1){
				return "true";
			}
			
			return "false";
		
		}
		
		

		@RequestMapping(value="modify", method=RequestMethod.POST)
		@ResponseBody
		private String updatemap(MindMapVO vo) throws Exception{
			System.out.println(vo.getMindnum());
			int r = mind.updatemap(vo);
			System.out.println(r);
			
			if(r == 1){
				return "true";
			}
			
			return "false";
		
		}
		
		
		
	
}
