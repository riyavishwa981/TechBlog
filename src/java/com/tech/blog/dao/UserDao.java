package com.tech.blog.dao;

import com.tech.blog.entities.User;
import java.sql.*;

public class UserDao {

    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    //method to insert user to database;
    public boolean saveUser(User user) {
        boolean f = false;
        try {
            //user-> database
            String query = "insert into user(name,email,password,gender,about) values (?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());

            pstmt.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;

    }
    //get user by useremail and userpassword

    public User getUserByEmail(String email) {
        User user = null;
        try {
            String q = "select * from user where email=?";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setString(1, email);

            ResultSet set = pstmt.executeQuery();
            if (set.next()) {
                user = new User();
                //data from db
                String name = set.getString("name");
                //set to user object
                user.setName(name);
                user.setId(set.getInt("id"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public String checkIfEmailAlreadyExists(String email) {
        String user_email = null;
        try {
            String que = "Select * from user where email=?";
            PreparedStatement pstmt = con.prepareStatement(que);
            pstmt.setString(1, email);
            ResultSet set = pstmt.executeQuery();
            if (set.next()) {
                user_email = set.getString("email");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user_email;
    }

    public boolean updateUser(User user) {
        boolean f = false;
        try {
            String query = "update user set name=?, email=?,password=?, gender=?, about=?, profile=? where id=?";
            PreparedStatement p = con.prepareStatement(query);
            p.setString(1, user.getName());
            p.setString(2, user.getEmail());
            p.setString(3, user.getPassword());
            p.setString(4, user.getGender());
            p.setString(5, user.getAbout());
            p.setString(6, user.getProfile());
            p.setInt(7, user.getId());

            p.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }
    
    public boolean updatePassword(User user) {
        boolean f = false;
        try {
            String query = "update user set password=? where id=?";
            PreparedStatement p = con.prepareStatement(query);
            p.setString(1, user.getPassword());
            p.setInt(2, user.getId());

            p.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }
    
    

    public int getUserId(User user) {
        int user_id = 0;
        try {
            String email = user.getEmail();
            String que = "Select * from user where email=?";
            PreparedStatement pstmt = con.prepareStatement(que);
            pstmt.setString(1, email);
            ResultSet set = pstmt.executeQuery();
            if (set.next()) {
                user_id = set.getInt("id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user_id;
    }

    public User getUserByUserId(int userId) {
        User user = null;
        try {
            String q = "select * from user where id=?";
            PreparedStatement ps = this.con.prepareStatement(q);
            ps.setInt(1, userId);
            ResultSet set = ps.executeQuery();
            if(set.next()){
                user = new User();
                //data from db
                String name = set.getString("name");
                //set to user object
                user.setName(name);
                user.setId(set.getInt("id"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}
