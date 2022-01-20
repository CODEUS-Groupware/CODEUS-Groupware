package com.codeusgroup.codeus.commBoard.model.vo;

import java.util.ArrayList;
import java.util.List;

public class MarketAtt {
	
	//첨부파일att 
	
	private int fileNo; //파일 num 
	private int bId; //마켓 num
	private String path;
	private String oriFileName;
	private String reFileName; //sysname
	private String fStatus; //파일 상태 
	
	private ArrayList<MarketAtt> attList;
	
	public ArrayList<MarketAtt> getFileList() {
		return attList;
	}

	public void setFileList(ArrayList<MarketAtt> attList) {
		this.attList = attList;
	}
	   
	
	public MarketAtt() {}


	
	

	public MarketAtt(int fileNo, int bId, String path, String oriFileName, String reFileName, String fStatus,
			ArrayList<MarketAtt> attList) {
		super();
		this.fileNo = fileNo;
		this.bId = bId;
		this.path = path;
		this.oriFileName = oriFileName;
		this.reFileName = reFileName;
		this.fStatus = fStatus;
		this.attList = attList;
	}





	public int getFileNo() {
		return fileNo;
	}





	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
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





	public ArrayList<MarketAtt> getAttList() {
		return attList;
	}





	public void setAttList(ArrayList<MarketAtt> attList) {
		this.attList = attList;
	}





	@Override
	public String toString() {
		return "MarketAtt [fileNo=" + fileNo + ", bId=" + bId + ", path=" + path + ", oriFileName=" + oriFileName
				+ ", reFileName=" + reFileName + ", fStatus=" + fStatus + ", attList=" + attList + "]";
	}




	
	
}
