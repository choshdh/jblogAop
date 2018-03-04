package com.javaex.vo;

public class FileVo {

	private int fileNo;
	private String fileSaveDir;
	private String fileOriginalName;
	private String fileExName;
	private String fileSaveName;
	private String filePath;
	private long fileSize;
	private String fileRegDate;
	
	public FileVo() {
		// TODO Auto-generated constructor stub
	}

	public FileVo(String fileSaveDir, String fileOriginalName, String fileExName, String fileSaveName, String filePath, long fileSize) {
		this.fileSaveDir = fileSaveDir;
		this.fileOriginalName = fileOriginalName;
		this.fileExName = fileExName;
		this.fileSaveName = fileSaveName;
		this.filePath = filePath;
		this.fileSize = fileSize;
	}
	
	public int getFileNo() {
		return fileNo;
	}
	
	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}

	public String getFileSaveDir() {
		return fileSaveDir;
	}

	public void setFileSaveDir(String fileSaveDir) {
		this.fileSaveDir = fileSaveDir;
	}

	public String getFileOriginalName() {
		return fileOriginalName;
	}

	public void setFileOriginalName(String fileOriginalName) {
		this.fileOriginalName = fileOriginalName;
	}

	public String getFileExName() {
		return fileExName;
	}

	public void setFileExName(String fileExName) {
		this.fileExName = fileExName;
	}

	public String getFileSaveName() {
		return fileSaveName;
	}

	public void setFileSaveName(String fileSaveName) {
		this.fileSaveName = fileSaveName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getFileRegDate() {
		return fileRegDate;
	}

	public void setFileRegDate(String fileRegDate) {
		this.fileRegDate = fileRegDate;
	}

	@Override
	public String toString() {
		return "FileVo [fileSaveDir=" + fileSaveDir + ", fileOriginalName=" + fileOriginalName + ", fileExName="
				+ fileExName + ", fileSaveName=" + fileSaveName + ", filePath=" + filePath + ", fileSize=" + fileSize
				+ ", fileRegDate=" + fileRegDate + "]";
	}
	
	
	
	
}
