package com.tech.blog.dao;
import com.tech.blog.entities.Comment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class CommentDao {
    Connection con;

    public CommentDao(Connection con) {
        this.con = con;
    }
    
   public boolean saveComment(Comment com){
       boolean flag = false;
       try{
           String q = "insert into comments(commentcon,pid,uid) values(?,?,?)";
           PreparedStatement pstmt = con.prepareStatement(q);
           pstmt.setString(1, com.getCommentcon());
           pstmt.setInt(2, com.getPid());
           pstmt.setInt(3, com.getUid());
           pstmt.executeUpdate();
           flag = true;
           
       }catch(Exception e){
           //e.printStackTrace();
       }
       return flag;
   }
    
   public int countCommentOnPost(int pid){
        int count = 0;
        try{
            String q = "select count(*) from comments where pid=?";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setInt(1, pid);
            ResultSet set = pstmt.executeQuery();
            
            if(set.next()){
                count = set.getInt("count(*)");
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return count;
    }
    
   public List<Comment> getComments(int pid){
       List<Comment> coms = new ArrayList<>();
       try{
           String q = "select * from comments where pid=?";
           PreparedStatement pstmt = con.prepareStatement(q);
           pstmt.setInt(1, pid);
           ResultSet set = pstmt.executeQuery();
           
           while(set.next()){
               int cid = set.getInt("cid");
               String commentcon = set.getString("commentcon");
               int uid = set.getInt("uid");
               Timestamp date = set.getTimestamp("date");
               Comment com = new Comment(cid,commentcon, pid,uid, date);
               coms.add(com);
           }
           
       }catch(Exception e){
           e.printStackTrace();
       }
       
       return coms;
   }
   
   public boolean deleteComment(int cid, int uid){
        boolean f = false;
        try{
            String q1 = "delete from comments where cid=?";
            PreparedStatement p = this.con.prepareStatement(q1);
            p.setInt(1, cid);
            
            p.executeUpdate();
            f = true;
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
    
   public boolean updateComment(Comment c){
        boolean f = false;
        try{
            String q = "update comments set commentcon=? where cid=?";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setString(1, c.getCommentcon());
            pstmt.setInt(2, c.getCid());
            
            pstmt.executeUpdate();
            f=true;
        }catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
}
