
package com.tech.blog.entities;
import java.sql.Timestamp;
public class Comment {
    private int cid;
    private String commentcon;
    private int pid;
    private int uid;
    private Timestamp date;

    public Comment(int cid, String commentcon, int pid, int uid, Timestamp date) {
        this.cid = cid;
        this.commentcon = commentcon;
        this.pid = pid;
        this.uid = uid;
        this.date = date;
    }

    public Comment(String commentcon, int pid, int uid) {
        this.commentcon = commentcon;
        this.pid = pid;
        this.uid = uid;
    }

    
    public Comment() {
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public String getCommentcon() {
        return commentcon;
    }

    public void setCommentcon(String commentcon) {
        this.commentcon = commentcon;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }
    
    
}
