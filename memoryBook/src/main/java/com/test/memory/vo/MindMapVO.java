package com.test.memory.vo;

public class MindMapVO {
	private int mindnum;
	private String mindname;
	private String mindjson;
	private int mem_no;
	
	public MindMapVO(){
		
	}

	public MindMapVO(int mindnum, String mindname, String mindjson, int mem_no) {
		super();
		this.mindnum = mindnum;
		this.mindname = mindname;
		this.mindjson = mindjson;
		this.mem_no = mem_no;
	}

	public int getMindnum() {
		return mindnum;
	}

	public void setMindnum(int mindnum) {
		this.mindnum = mindnum;
	}

	public String getMindname() {
		return mindname;
	}

	public void setMindname(String mindname) {
		this.mindname = mindname;
	}

	public String getMindjson() {
		return mindjson;
	}

	public void setMindjson(String mindjson) {
		this.mindjson = mindjson;
	}

	public int getMem_no() {
		return mem_no;
	}

	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}

	@Override
	public String toString() {
		return "MindMapVO [mindnum=" + mindnum + ", mindname=" + mindname + ", mindjson=" + mindjson + ", mem_no="
				+ mem_no + "]";
	};
	
	

}
