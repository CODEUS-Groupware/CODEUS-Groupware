package com.codeusgroup.codeus.admin.model.vo;

import java.sql.Date;

public class Department {
	private int deptId;
	private String deptName;
	private String deptManager;
	private String deptManagerName;
	private String deptManagerJob;
	private	int upperDept;
	private int deptLevel;
	private int deptOrder;
	private int deptStatus;
	private Date createDate;
	private int hasChildren;
	
	public Department() {}

	public Department(int deptId, String deptName, String deptManager, String deptManagerName, String deptManagerJob,
			int upperDept, int deptLevel, int deptOrder, int deptStatus, Date createDate, int hasChildren) {
		super();
		this.deptId = deptId;
		this.deptName = deptName;
		this.deptManager = deptManager;
		this.deptManagerName = deptManagerName;
		this.deptManagerJob = deptManagerJob;
		this.upperDept = upperDept;
		this.deptLevel = deptLevel;
		this.deptOrder = deptOrder;
		this.deptStatus = deptStatus;
		this.createDate = createDate;
		this.hasChildren = hasChildren;
	}

	public int getDeptId() {
		return deptId;
	}

	public void setDeptId(int deptId) {
		this.deptId = deptId;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getDeptManager() {
		return deptManager;
	}

	public void setDeptManager(String deptManager) {
		this.deptManager = deptManager;
	}

	public String getDeptManagerName() {
		return deptManagerName;
	}

	public void setDeptManagerName(String deptManagerName) {
		this.deptManagerName = deptManagerName;
	}

	public String getDeptManagerJob() {
		return deptManagerJob;
	}

	public void setDeptManagerJob(String deptManagerJob) {
		this.deptManagerJob = deptManagerJob;
	}

	public int getUpperDept() {
		return upperDept;
	}

	public void setUpperDept(int upperDept) {
		this.upperDept = upperDept;
	}

	public int getDeptLevel() {
		return deptLevel;
	}

	public void setDeptLevel(int deptLevel) {
		this.deptLevel = deptLevel;
	}

	public int getDeptOrder() {
		return deptOrder;
	}

	public void setDeptOrder(int deptOrder) {
		this.deptOrder = deptOrder;
	}

	public int getDeptStatus() {
		return deptStatus;
	}

	public void setDeptStatus(int deptStatus) {
		this.deptStatus = deptStatus;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public int getHasChildren() {
		return hasChildren;
	}

	public void setHasChildren(int hasChildren) {
		this.hasChildren = hasChildren;
	}

	@Override
	public String toString() {
		return "Department [deptId=" + deptId + ", deptName=" + deptName + ", deptManager=" + deptManager
				+ ", deptManagerName=" + deptManagerName + ", deptManagerJob=" + deptManagerJob + ", upperDept="
				+ upperDept + ", deptLevel=" + deptLevel + ", deptOrder=" + deptOrder + ", deptStatus=" + deptStatus
				+ ", createDate=" + createDate + ", hasChildren=" + hasChildren + "]";
	}

}
