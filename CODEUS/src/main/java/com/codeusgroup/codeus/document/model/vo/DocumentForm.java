package com.codeusgroup.codeus.document.model.vo;

public class DocumentForm {
	private int formNum;
	private String formName;
	
	public DocumentForm() {}

	public DocumentForm(int formNum, String formName) {
		super();
		this.formNum = formNum;
		this.formName = formName;
	}

	public int getFormNum() {
		return formNum;
	}

	public void setFormNum(int formNum) {
		this.formNum = formNum;
	}

	public String getFormName() {
		return formName;
	}

	public void setFormName(String formName) {
		this.formName = formName;
	}

	@Override
	public String toString() {
		return "DocumentForm [formNum=" + formNum + ", formName=" + formName + "]";
	}
	
}
