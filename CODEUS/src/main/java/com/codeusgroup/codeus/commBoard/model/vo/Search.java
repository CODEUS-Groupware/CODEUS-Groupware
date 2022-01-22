package com.codeusgroup.codeus.commBoard.model.vo;

public class Search {
	private String searchCondition;
	private String searchValue;
	private String option;
	
	public Search() {}

	public Search(String searchCondition, String searchValue, String option) {
		super();
		this.searchCondition = searchCondition;
		this.searchValue = searchValue;
		this.option = option;
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

	public String getOption() {
		return option;
	}

	public void setOption(String option) {
		this.option = option;
	}

	@Override
	public String toString() {
		return "Search [searchCondition=" + searchCondition + ", searchValue=" + searchValue + ", option=" + option
				+ "]";
	}

	

	
	
	
	
	
}