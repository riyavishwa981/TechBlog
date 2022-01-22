
package com.tech.blog.dao;
import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class PostDao {
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    
    public ArrayList<Category> getAllCategories(){
        ArrayList<Category> list = new ArrayList<>();
        try{
            String q = "select * from categories";
            Statement st = this.con.createStatement();
            ResultSet set = st.executeQuery(q);
            while(set.next()) {
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("description");
                Category c = new Category(cid,name,description);
                list.add(c);
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
    
    public boolean savePost(Post p){
        boolean f = false;
        try{
            String q = "insert into posts(pTitle, pContent, pCode, pPic, catId, userId) values(?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());
            
            pstmt.executeUpdate();
            f=true;
        }catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
    
    //update post
    public boolean updatePost(Post p){
        boolean f = false;
        try{
            String q = "update posts set pTitle=?, pContent=?, pCode=?, pPic=?,catId=? where pid=? and userId=?";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getPid());
            pstmt.setInt(7, p.getUserId());
            
            pstmt.executeUpdate();
            f=true;
        }catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
    
    //get all the posts
    public List<Post> getAllPosts(){
        List<Post> list = new ArrayList<>();
        //fetch all the post
        try{
            PreparedStatement p = con.prepareStatement("select * from posts order by pid desc");
            ResultSet set = p.executeQuery();
            while(set.next()){
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int catId = set.getInt("catId");
                int userId = set.getInt("userId");
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                list.add(post);
                
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
    
    //get all post by id
    public List<Post> getPostByCatId(int catId){
        List<Post> list = new ArrayList<>();
        // fetch all post by id
        try{
            PreparedStatement p = con.prepareStatement("select * from posts where catId=?");
            p.setInt(1,catId);
            ResultSet set = p.executeQuery();
            while(set.next()){
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int userId = set.getInt("userId");
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                list.add(post);
                
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
    
    public Post getPostByPostId(int postId){
        Post p = null;
        try{
            String q = "select * from posts where pid=?";
            PreparedStatement ps = this.con.prepareStatement(q);
            ps.setInt(1, postId);
            ResultSet set = ps.executeQuery();
            if(set.next()){
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int catId = set.getInt("catId");
                int userId = set.getInt("userId");
                p = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
            }
            
        } catch(Exception e){
            e.printStackTrace();
        }
        return p;
    }
    
    public List<Post> getPostByUserId(int userId){
        List<Post> list = new ArrayList<>();
        try{
            String q = "select * from posts where userId=?";
            PreparedStatement ps = this.con.prepareStatement(q);
            ps.setInt(1, userId);
            ResultSet set = ps.executeQuery();
            while(set.next()){
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int catId = set.getInt("catId");
                int uid = set.getInt("userId");
                Post p = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, uid);
                list.add(p);
            }
            
        } catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
    
    public int getTotalPosts(int userId){
        int count = 0;
        try{
            String q = "select count(*) from posts where userId=?";
            PreparedStatement ps = this.con.prepareStatement(q);
            ps.setInt(1, userId);
            ResultSet set = ps.executeQuery();
            if(set.next()){
                count = set.getInt("count(*)");
            }
            
        } catch(Exception e){
            e.printStackTrace();
        }
        return count;
    }
    
    public boolean deletePost(int pid, int uid){
        boolean f = false;
        try{
            String q1 = "delete from likes where pid=?";
            String q2 = "delete from posts where pid=? and userId=?";
            PreparedStatement p1 = this.con.prepareStatement(q1);
            p1.setInt(1, pid);
            p1.executeUpdate();
             
            PreparedStatement p2 = this.con.prepareStatement(q2);
            p2.setInt(1, pid);
            p2.setInt(2, uid);
            p2.executeUpdate();
            f = true;
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
}
