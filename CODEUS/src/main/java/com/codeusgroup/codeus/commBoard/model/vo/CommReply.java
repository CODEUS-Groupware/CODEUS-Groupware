package com.codeusgroup.codeus.commBoard.model.vo;

	import java.sql.Date;

	public class CommReply {
		private int rId;
		private String rContent;
		private int refBid;
		private String rWriter;
		private Date rCreateDate;
		private Date rModifyDate;
		private String rStatus;
		
		public CommReply() {}

		public CommReply(int rId, String rContent, int refBid, String rWriter, Date rCreateDate, Date rModifyDate,
				String rStatus) {
			super();
			this.rId = rId;
			this.rContent = rContent;
			this.refBid = refBid;
			this.rWriter = rWriter;
			this.rCreateDate = rCreateDate;
			this.rModifyDate = rModifyDate;
			this.rStatus = rStatus;
		}

		public int getrId() {
			return rId;
		}

		public void setrId(int rId) {
			this.rId = rId;
		}

		public String getrContent() {
			return rContent;
		}

		public void setrContent(String rContent) {
			this.rContent = rContent;
		}

		public int getRefBid() {
			return refBid;
		}

		public void setRefBid(int refBid) {
			this.refBid = refBid;
		}

		public String getrWriter() {
			return rWriter;
		}

		public void setrWriter(String rWriter) {
			this.rWriter = rWriter;
		}

		public Date getrCreateDate() {
			return rCreateDate;
		}

		public void setrCreateDate(Date rCreateDate) {
			this.rCreateDate = rCreateDate;
		}

		public Date getrModifyDate() {
			return rModifyDate;
		}

		public void setrModifyDate(Date rModifyDate) {
			this.rModifyDate = rModifyDate;
		}

		public String getrStatus() {
			return rStatus;
		}

		public void setrStatus(String rStatus) {
			this.rStatus = rStatus;
		}

		@Override
		public String toString() {
			return "CommReply [rId=" + rId + ", rContent=" + rContent + ", refBid=" + refBid + ", rWriter=" + rWriter
					+ ", rCreateDate=" + rCreateDate + ", rModifyDate=" + rModifyDate + ", rStatus=" + rStatus + "]";
		}
		
	}

