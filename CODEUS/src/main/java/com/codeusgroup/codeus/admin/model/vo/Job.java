package com.codeusgroup.codeus.admin.model.vo;

public class Job {
	private int jobId;
	private String jobName;
	private int jobOrder;
	private int jobStatus;
	private int memberCount;
	
	public Job() {}

	public Job(int jobId, String jobName, int jobOrder, int jobStatus, int memberCount) {
		super();
		this.jobId = jobId;
		this.jobName = jobName;
		this.jobOrder = jobOrder;
		this.jobStatus = jobStatus;
		this.memberCount = memberCount;
	}

	public int getJobId() {
		return jobId;
	}

	public void setJobId(int jobId) {
		this.jobId = jobId;
	}

	public String getJobName() {
		return jobName;
	}

	public void setJobName(String jobName) {
		this.jobName = jobName;
	}

	public int getJobOrder() {
		return jobOrder;
	}

	public void setJobOrder(int jobOrder) {
		this.jobOrder = jobOrder;
	}

	public int getJobStatus() {
		return jobStatus;
	}

	public void setJobStatus(int jobStatus) {
		this.jobStatus = jobStatus;
	}

	public int getMemberCount() {
		return memberCount;
	}

	public void setMemberCount(int memberCount) {
		this.memberCount = memberCount;
	}

	@Override
	public String toString() {
		return "Job [jobId=" + jobId + ", jobName=" + jobName + ", jobOrder=" + jobOrder + ", jobStatus=" + jobStatus
				+ ", memberCount=" + memberCount + "]";
	}

}
