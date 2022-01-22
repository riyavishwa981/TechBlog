
package com.tech.blog.helper;
import java.sql.*;
public class ConnectionProvider {
    private static Connection con;
    public static Connection getConnection(){
        try{
            
            if(con==null){
                //driver class load
            Class.forName("com.mysql.jdbc.Driver");
            
            //create a connection
            con = DriverManager.getConnection("jdbc:mysql://sql6.freesqldatabase.com:3306/sql6463466","sql6463466", "Z3xVH6IjkJ");
            
            }
        }catch(Exception e){
            
            e.printStackTrace();
            
        }
        return con;
    }
}
