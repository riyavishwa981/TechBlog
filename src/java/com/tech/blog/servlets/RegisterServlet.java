
package com.tech.blog.servlets;

import com.tech.blog.entities.User;
import com.tech.blog.dao.UserDao;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

@MultipartConfig
public class RegisterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
          
            //fecth all the data
            String check = request.getParameter("check");
            if(check == null){
                out.println("Please accept the terms and condition");
            }else{
                //to get the email and check wether it already exists or not
                String email = request.getParameter("user_email");
                //create a user dao object...
                UserDao dao = new UserDao(ConnectionProvider.getConnection());
                if(dao.checkIfEmailAlreadyExists(email) != null){
                    out.println("invalid");
                }
               else{
                //baki ka data yaha nikalna h
                String name = request.getParameter("user_name");
                String password = request.getParameter("user_password");
                
                password = hashPassword(password);
                
                
                String gender = request.getParameter("gender");
                String about = request.getParameter("about");
                if(about.length()==0){
                    about = "'hey I am using TechBlog";
                }
                //create user object and set all data to that object
                User user = new User(name,email,password,gender,about);
               
                if(dao.saveUser(user)){
                    //save...
                    int user_id = dao.getUserId(user);
                    System.out.println(user_id);
                    
                    String user_path = request.getRealPath("/")+user_id;
                    File f = new File(user_path);
                    f.mkdir();
                    
                    String profile_path = user_path+File.separator+"profilePhotos";
                    String post_path = user_path+File.separator+"postPhotos";
                    
                    File f1 = new File(profile_path);
                    File f2 = new File(post_path);
                    boolean flag1 = f1.mkdir();
                    boolean flag2 = f2.mkdir();
                    
                    if(flag1 && flag2){
                        String getdipath = request.getRealPath("/")+"pics"+File.separator+ "default.png";
                        InputStream is = new FileInputStream(getdipath);
                        Helper.saveFile(is,profile_path+File.separator+ "default.png");
                        
                        String getpath = request.getRealPath("/")+"pics"+File.separator+ "pic1.jpg";
                        InputStream is1 = new FileInputStream(getpath);
                        Helper.saveFile(is1,post_path+File.separator+ "pic1.jpg");
                    }    
            
                    out.println("done");
                }else{
                    response.setStatus(500);
                    out.println("error");
                }
            }
            }    
        }
    }

    private String hashPassword(String plainTextPassword){
		return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
	}
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
