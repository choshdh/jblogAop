package com.javaex.vo;

public class CateVo {

	private int cateNo;
	private int userNo;
	private String cateName;
	private String description;
	private String regDate;
	private int postCnt;
	
	public CateVo() {
	}
	
	public CateVo(int userNo, String cateName, String description) {
		super();
		this.userNo = userNo;
		this.cateName = cateName;
		this.description = description;
	}

	public int getCateNo() {
		return cateNo;
	}

	public void setCateNo(int cateNo) {
		this.cateNo = cateNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public int getPostCnt() {
		return postCnt;
	}

	public void setPostCnt(int postCnt) {
		this.postCnt = postCnt;
	}

	@Override
	public String toString() {
		return "CateVo [cateNo=" + cateNo + ", userNo=" + userNo + ", cateName=" + cateName + ", description="
				+ description + ", regDate=" + regDate + ", postCnt=" + postCnt + "]";
	}


}
