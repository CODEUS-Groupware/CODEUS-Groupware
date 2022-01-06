package com.codeusgroup.codeus.member.model.vo;

import java.sql.Date;

public class Member {
	private String mId;
	private String mPwd;
	private String mName;
	private String birthDate;
	private String email;
	private String phone;
	private String address;
	private String profile;
	private String imgOriginName;
	private String imgChangeName;
	private Date enrollDate;
	private Date updateDate;
	private Date hireDate;
	private Date endDate;
	private int status;
	private String managerYn;
	private String jobId;
	private String jobName;
	private String deptId;
	private String deptName;
    
	
	public Member() {}


	public Member(String mId, String mPwd, String mName, String birthDate, String email, String phone, String address,
			String profile, String imgOriginName, String imgChangeName, Date enrollDate, Date updateDate, Date hireDate,
			Date endDate, int status, String managerYn, String jobId, String jobName, String deptId, String deptName) {
		super();
		this.mId = mId;
		this.mPwd = mPwd;
		this.mName = mName;
		this.birthDate = birthDate;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.profile = profile;
		this.imgOriginName = imgOriginName;
		this.imgChangeName = imgChangeName;
		this.enrollDate = enrollDate;
		this.updateDate = updateDate;
		this.hireDate = hireDate;
		this.endDate = endDate;
		this.status = status;
		this.managerYn = managerYn;
		this.jobId = jobId;
		this.jobName = jobName;
		this.deptId = deptId;
		this.deptName = deptName;
	}


	public String getmId() {
		return mId;
	}


	public void setmId(String mId) {
		this.mId = mId;
	}


	public String getmPwd() {
		return mPwd;
	}


	public void setmPwd(String mPwd) {
		this.mPwd = mPwd;
	}


	public String getmName() {
		return mName;
	}


	public void setmName(String mName) {
		this.mName = mName;
	}


	public String getBirthDate() {
		return birthDate;
	}


	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getProfile() {
		return profile;
	}


	public void setProfile(String profile) {
		this.profile = profile;
	}


	public String getImgOriginName() {
		return imgOriginName;
	}


	public void setImgOriginName(String imgOriginName) {
		this.imgOriginName = imgOriginName;
	}


	public String getImgChangeName() {
		return imgChangeName;
	}


	public void setImgChangeName(String imgChangeName) {
		this.imgChangeName = imgChangeName;
	}


	public Date getEnrollDate() {
		return enrollDate;
	}


	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}


	public Date getUpdateDate() {
		return updateDate;
	}


	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}


	public Date getHireDate() {
		return hireDate;
	}


	public void setHireDate(Date hireDate) {
		this.hireDate = hireDate;
	}


	public Date getEndDate() {
		return endDate;
	}


	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}


	public int getStatus() {
		return status;
	}


	public void setStatus(int status) {
		this.status = status;
	}


	public String getManagerYn() {
		return managerYn;
	}


	public void setManagerYn(String managerYn) {
		this.managerYn = managerYn;
	}


	public String getJobId() {
		return jobId;
	}


	public void setJobId(String jobId) {
		this.jobId = jobId;
	}


	public String getJobName() {
		return jobName;
	}


	public void setJobName(String jobName) {
		this.jobName = jobName;
	}


	public String getDeptId() {
		return deptId;
	}


	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}


	public String getDeptName() {
		return deptName;
	}


	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}


	@Override
	public String toString() {
		return "Member [mId=" + mId + ", mPwd=" + mPwd + ", mName=" + mName + ", birthDate=" + birthDate + ", email="
				+ email + ", phone=" + phone + ", address=" + address + ", profile=" + profile + ", imgOriginName="
				+ imgOriginName + ", imgChangeName=" + imgChangeName + ", enrollDate=" + enrollDate + ", updateDate="
				+ updateDate + ", hireDate=" + hireDate + ", endDate=" + endDate + ", status=" + status + ", managerYn="
				+ managerYn + ", jobId=" + jobId + ", jobName=" + jobName + ", deptId=" + deptId + ", deptName="
				+ deptName + "]";
	}

	
}	