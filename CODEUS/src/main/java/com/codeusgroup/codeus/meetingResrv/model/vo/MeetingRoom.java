package com.codeusgroup.codeus.meetingResrv.model.vo;

import java.sql.Date;

public class MeetingRoom {
    private int meet_no;
    private String meet_name;
    private String meet_info;
    private Date meet_regi_date;
    private Date meet_update_date;
    private int meet_status;
    private String img_origin_name;
    private String img_change_name;
    
    public MeetingRoom() {
    }
    
    public MeetingRoom(int meet_no, String meet_name, String meet_info, Date meet_regi_date, Date meet_update_date,
            int meet_status, String img_origin_name, String img_change_name) {
        this.meet_no = meet_no;
        this.meet_name = meet_name;
        this.meet_info = meet_info;
        this.meet_regi_date = meet_regi_date;
        this.meet_update_date = meet_update_date;
        this.meet_status = meet_status;
        this.img_origin_name = img_origin_name;
        this.img_change_name = img_change_name;
    }
    
    public int getMeet_no() {
        return meet_no;
    }
    
    public void setMeet_no(int meet_no) {
        this.meet_no = meet_no;
    }
    
    public String getMeet_name() {
        return meet_name;
    }
    
    public void setMeet_name(String meet_name) {
        this.meet_name = meet_name;
    }
    
    public String getMeet_info() {
        return meet_info;
    }
    
    public void setMeet_info(String meet_info) {
        this.meet_info = meet_info;
    }
    
    public Date getMeet_regi_date() {
        return meet_regi_date;
    }
    
    public void setMeet_regi_date(Date meet_regi_date) {
        this.meet_regi_date = meet_regi_date;
    }
    
    public Date getMeet_update_date() {
        return meet_update_date;
    }
    
    public void setMeet_update_date(Date meet_update_date) {
        this.meet_update_date = meet_update_date;
    }
    
    public int getMeet_status() {
        return meet_status;
    }
    
    public void setMeet_status(int meet_status) {
        this.meet_status = meet_status;
    }
    
    public String getImg_origin_name() {
        return img_origin_name;
    }
    
    public void setImg_origin_name(String img_origin_name) {
        this.img_origin_name = img_origin_name;
    }
    
    public String getImg_change_name() {
        return img_change_name;
    }
    
    public void setImg_change_name(String img_change_name) {
        this.img_change_name = img_change_name;
    }
    
    @Override
    public String toString() {
        return "MeetingRoom [meet_no=" + meet_no + ", meet_name=" + meet_name + ", meet_info=" + meet_info
                + ", meet_regi_date=" + meet_regi_date + ", meet_update_date=" + meet_update_date + ", meet_status="
                + meet_status + ", img_origin_name=" + img_origin_name + ", img_change_name=" + img_change_name + "]";
    }
}
