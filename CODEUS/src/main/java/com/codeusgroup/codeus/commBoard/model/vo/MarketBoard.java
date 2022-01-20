package com.codeusgroup.codeus.commBoard.model.vo;

import java.sql.Date;
import java.util.List;

public class MarketBoard {

	
	private int bId; //보드 번호
	private String mbType;  //'중고'
	private String mbCategory;  //'중고'
	private String mbTitle;  //상품명 
	private String marketPrice ; // 필요*
	private String mbContent;  //상품 내용
	private int mbViews; //조회수
	private String originalFileName;
	private String renameFileName;
	private Date mbCreateDate;
	private Date mbModifyDate;
	private String mbStatus; 
	private String mbPin;
	private String mbWriter; 

	
	public MarketBoard() {}


	public MarketBoard(int bId, String mbType, String mbCategory, String mbTitle, String marketPrice, String mbContent,
			int mbViews, String originalFileName, String renameFileName, Date mbCreateDate, Date mbModifyDate,
			String mbStatus, String mbPin, String mbWriter) {
		super();
		this.bId = bId;
		this.mbType = mbType;
		this.mbCategory = mbCategory;
		this.mbTitle = mbTitle;
		this.marketPrice = marketPrice;
		this.mbContent = mbContent;
		this.mbViews = mbViews;
		this.originalFileName = originalFileName;
		this.renameFileName = renameFileName;
		this.mbCreateDate = mbCreateDate;
		this.mbModifyDate = mbModifyDate;
		this.mbStatus = mbStatus;
		this.mbPin = mbPin;
		this.mbWriter = mbWriter;
	}


	public int getbId() {
		return bId;
	}


	public void setbId(int bId) {
		this.bId = bId;
	}


	public String getMbType() {
		return mbType;
	}


	public void setMbType(String mbType) {
		this.mbType = mbType;
	}


	public String getMbCategory() {
		return mbCategory;
	}


	public void setMbCategory(String mbCategory) {
		this.mbCategory = mbCategory;
	}


	public String getMbTitle() {
		return mbTitle;
	}


	public void setMbTitle(String mbTitle) {
		this.mbTitle = mbTitle;
	}


	public String getMarketPrice() {
		return marketPrice;
	}


	public void setMarketPrice(String marketPrice) {
		this.marketPrice = marketPrice;
	}


	public String getMbContent() {
		return mbContent;
	}


	public void setMbContent(String mbContent) {
		this.mbContent = mbContent;
	}


	public int getMbViews() {
		return mbViews;
	}


	public void setMbViews(int mbViews) {
		this.mbViews = mbViews;
	}


	public String getOriginalFileName() {
		return originalFileName;
	}


	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}


	public String getRenameFileName() {
		return renameFileName;
	}


	public void setRenameFileName(String renameFileName) {
		this.renameFileName = renameFileName;
	}


	public Date getMbCreateDate() {
		return mbCreateDate;
	}


	public void setMbCreateDate(Date mbCreateDate) {
		this.mbCreateDate = mbCreateDate;
	}


	public Date getMbModifyDate() {
		return mbModifyDate;
	}


	public void setMbModifyDate(Date mbModifyDate) {
		this.mbModifyDate = mbModifyDate;
	}


	public String getMbStatus() {
		return mbStatus;
	}


	public void setMbStatus(String mbStatus) {
		this.mbStatus = mbStatus;
	}


	public String getMbPin() {
		return mbPin;
	}


	public void setMbPin(String mbPin) {
		this.mbPin = mbPin;
	}


	public String getMbWriter() {
		return mbWriter;
	}


	public void setMbWriter(String mbWriter) {
		this.mbWriter = mbWriter;
	}


	@Override
	public String toString() {
		return "MarketBoard [bId=" + bId + ", mbType=" + mbType + ", mbCategory=" + mbCategory + ", mbTitle=" + mbTitle
				+ ", marketPrice=" + marketPrice + ", mbContent=" + mbContent + ", mbViews=" + mbViews
				+ ", originalFileName=" + originalFileName + ", renameFileName=" + renameFileName + ", mbCreateDate="
				+ mbCreateDate + ", mbModifyDate=" + mbModifyDate + ", mbStatus=" + mbStatus + ", mbPin=" + mbPin
				+ ", mbWriter=" + mbWriter + ", getbId()=" + getbId() + ", getMbType()=" + getMbType()
				+ ", getMbCategory()=" + getMbCategory() + ", getMbTitle()=" + getMbTitle() + ", getMarketPrice()="
				+ getMarketPrice() + ", getMbContent()=" + getMbContent() + ", getMbViews()=" + getMbViews()
				+ ", getOriginalFileName()=" + getOriginalFileName() + ", getRenameFileName()=" + getRenameFileName()
				+ ", getMbCreateDate()=" + getMbCreateDate() + ", getMbModifyDate()=" + getMbModifyDate()
				+ ", getMbStatus()=" + getMbStatus() + ", getMbPin()=" + getMbPin() + ", getMbWriter()=" + getMbWriter()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}


	
	

	
	
}
	
