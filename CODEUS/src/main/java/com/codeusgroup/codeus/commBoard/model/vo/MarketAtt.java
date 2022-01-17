package com.codeusgroup.codeus.commBoard.model.vo;

import java.util.ArrayList;
import java.util.List;

public class MarketAtt {
	
	//첨부파일att 
	
	private int filesNo; //파일 num 
	private int bId; //마켓 num
	private String path;
	private String oriFileName;
	private String reFileName; //sysname
	private String fStatus; //파일 상태 
	    
	
	public MarketAtt() {}


	public MarketAtt(int filesNo, int bId, String path, String oriFileName, String reFileName, String fStatus) {
		super();
		this.filesNo = filesNo;
		this.bId = bId;
		this.path = path;
		this.oriFileName = oriFileName;
		this.reFileName = reFileName;
		this.fStatus = fStatus;
	}


	public int getFilesNo() {
		return filesNo;
	}


	public void setFilesNo(int filesNo) {
		this.filesNo = filesNo;
	}


	public int getbId() {
		return bId;
	}


	public void setbId(int bId) {
		this.bId = bId;
	}


	public String getPath() {
		return path;
	}


	public void setPath(String path) {
		this.path = path;
	}


	public String getOriFileName() {
		return oriFileName;
	}
	
	
	private int fileCount;

	private List<MarketBoard> files = new ArrayList<>();


	public void setOriFileName(String oriFileName) {
		this.oriFileName = oriFileName;
	}


	public String getReFileName() {
		return reFileName;
	}


	public void setReFileName(String reFileName) {
		this.reFileName = reFileName;
	}


	public String getfStatus() {
		return fStatus;
	}


	public void setfStatus(String fStatus) {
		this.fStatus = fStatus;
	}


	@Override
	public String toString() {
		return "MarketAtt [filesNo=" + filesNo + ", bId=" + bId + ", path=" + path + ", oriFileName=" + oriFileName
				+ ", reFileName=" + reFileName + ", fStatus=" + fStatus + "]";
	}


	
	
	
	

}
