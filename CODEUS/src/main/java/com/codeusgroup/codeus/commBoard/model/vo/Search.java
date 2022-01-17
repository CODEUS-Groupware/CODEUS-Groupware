package com.codeusgroup.codeus.commBoard.model.vo;

public class Search {
	private String searchCondition;
	private String searchValue;
	
	public Search() {}

	public Search(String searchCondition, String searchValue) {
		super();
		this.searchCondition = searchCondition;
		this.searchValue = searchValue;
	}

	public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	@Override
	public String toString() {
		return "nSearch [searchCondition=" + searchCondition + ", searchValue=" + searchValue + "]";
	}
	
	
	
	
}