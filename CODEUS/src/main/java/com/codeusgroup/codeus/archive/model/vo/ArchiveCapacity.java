package com.codeusgroup.codeus.archive.model.vo;

public class ArchiveCapacity {
	private long currentCapacity;
	private long totalCapacity;
	
	public ArchiveCapacity() {}

	public ArchiveCapacity(long currentCapacity, long totalCapacity) {
		super();
		this.currentCapacity = currentCapacity;
		this.totalCapacity = totalCapacity;
	}

	public long getCurrentCapacity() {
		return currentCapacity;
	}

	public void setCurrentCapacity(long currentCapacity) {
		this.currentCapacity = currentCapacity;
	}

	public long getTotalCapacity() {
		return totalCapacity;
	}

	public void setTotalCapacity(long totalCapacity) {
		this.totalCapacity = totalCapacity;
	}

	@Override
	public String toString() {
		return "ArchiveCapacity [currentCapacity=" + currentCapacity + ", totalCapacity=" + totalCapacity + "]";
	}
	
}
