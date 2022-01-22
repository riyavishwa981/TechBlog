/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.tech.blog.servlets;

import com.tech.blog.entities.Post;
import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Message;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author DELL
 */
@MultipartConfig
public class EditPostServlet extends HttpServlet {

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
          
            //fetch from user input
            String pTitle = request.getParameter("pTitle");
            String pContent = request.getParameter("pContent");
            String pCode = request.getParameter("pCode");
            Part part = request.getPart("pPic");
            String pPicName = part.getSubmittedFileName();
            
            
            int pid = Integer.parseInt(request.getParameter("post_id"));
            PostDao pd = new PostDao(ConnectionProvider.getConnection());
            //fetch from postDao through postId
            //System.out.println(pid);
            HttpSession s = request.getSession();
            Post p = pd.getPostByPostId(pid);
            int user_id = p.getUserId();
            String oldimg = p.getpPic();
            p.setpTitle(pTitle);
            p.setpContent(pContent);
            p.setpCode(pCode);
            if(pPicName.length() != 0){
                p.setpPic(pPicName);
            }
            
            boolean flag = pd.updatePost(p);
            if(flag){
                if(pPicName.length()==0){
                    out.println("done");
                }
                else{
                    String oldpath = request.getRealPath("/") + user_id+ File.separator+ "postPhotos" + File.separator + oldimg;
                    String path = request.getRealPath("/") + user_id + File.separator+ "postPhotos" + File.separator + pPicName;
                    
                    if(!oldimg.equals("pic1.jpg")){
                        Helper.deleteFile(oldpath);
                    }
                    
                    if (Helper.saveFile(part.getInputStream(), path)) {
                        
                        Message msg = new Message("Profile details updated successfully", "success", "alert-success");
                        s.setAttribute("msg", msg);
                        out.println("done");
                        
                    } else {
                        
                        Message msg = new Message("Something went wrong..", "error", "alert-danger");
                        s.setAttribute("msg", msg);
                        out.println("notdone");
                    }
                    
                }
            }
            else {
               
                Message msg = new Message("Something went wrong..", "error", "alert-danger");
                s.setAttribute("msg", msg);
                out.println("notdone");
            }

//            response.sendRedirect("profile.jsp");
            
        }
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
