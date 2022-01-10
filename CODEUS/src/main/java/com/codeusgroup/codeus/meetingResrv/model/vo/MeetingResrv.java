package com.codeusgroup.codeus.meetingResrv.model.vo;

import java.sql.Date;
import java.sql.Timestamp;

public class MeetingResrv {
    private int rev_no;
    private Date rev_date;
    private Timestamp rev_start_time;
    private Timestamp rev_end_time;
    private String rev_content;
    private int rev_status;
    private Date rev_apply_date;
    private String meet_name;
    private String mName;
    
    public MeetingResrv() {
    }
    
    public MeetingResrv(int rev_no, Date rev_date, Timestamp rev_start_time, Timestamp rev_end_time, String rev_content,
            int rev_status, Date rev_apply_date, String meet_name, String mName) {
        this.rev_no = rev_no;
        this.rev_date = rev_date;
        this.rev_start_time = rev_start_time;
        this.rev_end_time = rev_end_time;
        this.rev_content = rev_content;
        this.rev_status = rev_status;
        this.rev_apply_date = rev_apply_date;
        this.meet_name = meet_name;
        this.mName = mName;
    }
    
    public int getRev_no() {
        return rev_no;
    }
    
    public void setRev_no(int rev_no) {
        this.rev_no = rev_no;
    }
    
    public Date getRev_date() {
        return rev_date;
    }
    
    public void setRev_date(Date rev_date) {
        this.rev_date = rev_date;
    }
    
    public Timestamp getRev_start_time() {
        return rev_start_time;
    }
    
    public void setRev_start_time(Timestamp rev_start_time) {
        this.rev_start_time = rev_start_time;
    }
    
    public Timestamp getRev_end_time() {
        return rev_end_time;
    }
    
    public void setRev_end_time(Timestamp rev_end_time) {
        this.rev_end_time = rev_end_time;
    }
    
    public String getRev_content() {
        return rev_content;
    }
    
    public void setRev_content(String rev_content) {
        this.rev_content = rev_content;
    }
    
    public int getRev_status() {
        return rev_status;
    }
    
    public void setRev_status(int rev_status) {
        this.rev_status = rev_status;
    }
    
    public Date getRev_apply_date() {
        return rev_apply_date;
    }
    
    public void setRev_apply_date(Date rev_apply_date) {
        this.rev_apply_date = rev_apply_date;
    }
    
    public String getMeet_name() {
        return meet_name;
    }
    
    public void setMeet_name(String meet_name) {
        this.meet_name = meet_name;
    }
    
    public String getmName() {
        return mName;
    }
    
    public void setmName(String mName) {
        this.mName = mName;
    }
    
    @Override
    public String toString() {
        return "MeetingResrv [rev_no=" + rev_no + ", rev_date=" + rev_date + ", rev_start_time=" + rev_start_time
                + ", rev_end_time=" + rev_end_time + ", rev_content=" + rev_content + ", rev_status=" + rev_status
                + ", rev_apply_date=" + rev_apply_date + ", meet_name=" + meet_name + ", mName=" + mName + "]";
    }
}
