package com.test.memory.vo;

public class MemberVO {
	private int mem_no;
	private String name;
	private String email;
	private String mem_pwd;
	private String mem_image;
	private int approvalNum;
	private int infoNumber;
	
	public int getMem_no() {
		return mem_no;
	}
	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMem_pwd() {
		return mem_pwd;
	}
	public void setMem_pwd(String mem_pwd) {
		this.mem_pwd = mem_pwd;
	}
	public String getMem_image() {
		return mem_image;
	}
	public void setMem_image(String mem_image) {
		this.mem_image = mem_image;
	}
	public int getApprovalNum() {
		return approvalNum;
	}
	public void setApprovalNum(int approvalNum) {
		this.approvalNum = approvalNum;
	}	
	public int getInfoNumber() {
		return infoNumber;
	}
	public void setInfoNumber(int infoNumber) {
			this.infoNumber = infoNumber;	
	}
	
	@Override
	public String toString() {
		return "MemberVO [mem_no=" + mem_no + ", name=" + name + ", email=" + email + ", mem_pwd=" + mem_pwd
				+ ", mem_image=" + mem_image + ", approvalNum=" + approvalNum + ", infoNumber=" + infoNumber + "]";
	}
	
}
