package com.codeusgroup.codeus.commBoard.model.vo;

public class Search {
	private String searchCondition;
	private String searchValue;
	private String searchType = "";
	private String keyword = "";
	private String optionValue;
	private String optionValue2;
	
	public Search() {}

	public Search(String searchCondition, String searchValue, String searchType, String keyword, String optionValue,
			String optionValue2) {
		super();
		this.searchCondition = searchCondition;
		this.searchValue = searchValue;
		this.searchType = searchType;
		this.keyword = keyword;
		this.optionValue = optionValue;
		this.optionValue2 = optionValue2;
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

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getOptionValue() {
		return optionValue;
	}

	public void setOptionValue(String optionValue) {
		this.optionValue = optionValue;
	}

	public String getOptionValue2() {
		return optionValue2;
	}

	public void setOptionValue2(String optionValue2) {
		this.optionValue2 = optionValue2;
	}

	@Override
	public String toString() {
		return "Search [searchCondition=" + searchCondition + ", searchValue=" + searchValue + ", searchType="
				+ searchType + ", keyword=" + keyword + ", optionValue=" + optionValue + ", optionValue2="
				+ optionValue2 + ", getSearchCondition()=" + getSearchCondition() + ", getSearchValue()="
				+ getSearchValue() + ", getSearchType()=" + getSearchType() + ", getKeyword()=" + getKeyword()
				+ ", getOptionValue()=" + getOptionValue() + ", getOptionValue2()=" + getOptionValue2()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}

	
	
	
	
	
}