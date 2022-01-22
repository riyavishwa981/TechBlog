package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import java.io.IOException;
import java.io.PrintWriter;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.File;
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
public class EditServlet extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");
            out.println("</head>");
            out.println("<body>");

            //fetch all data
            String userEmail = request.getParameter("user_email");
            String userName = request.getParameter("user_name");
            String userPassword = request.getParameter("user_password");
            String userAbout = request.getParameter("user_about");
            Part part = request.getPart("image");
            String imageName = part.getSubmittedFileName();

            //get user from the session
            HttpSession s = request.getSession();
            User user = (User) s.getAttribute("currentUser");
            String oldimg = user.getProfile();
            user.setEmail(userEmail);
            user.setName(userName);
            user.setPassword(userPassword);
            user.setAbout(userAbout);
            if (imageName.length() != 0) {
                user.setProfile(imageName);
            }

            //update database
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());
            boolean ans = userDao.updateUser(user);
            if (ans) {
                if (imageName.length() == 0) {
                    Message msg = new Message("Profile details updated successfully", "success", "alert-success");
                    s.setAttribute("msg", msg);
                } else {
                    int user_id = userDao.getUserId(user);
                    String oldpath = request.getRealPath("/") + user_id+ File.separator+ "profilePhotos" + File.separator + oldimg;
                    String path = request.getRealPath("/") + user_id + File.separator+ "profilePhotos" + File.separator + user.getProfile();
                    
                    if(!oldimg.equals("default.png")){
                        Helper.deleteFile(oldpath);
                    }
                    
                    if (Helper.saveFile(part.getInputStream(), path)) {
                        out.println("Profile Updated");
                        Message msg = new Message("Profile details updated successfully", "success", "alert-success");
                        s.setAttribute("msg", msg);
                    } else {
                        Message msg = new Message("Something went wrong..", "error", "alert-danger");
                        s.setAttribute("msg", msg);
                    }
                }

            } else {
                out.println("not updated");
                Message msg = new Message("Something went wrong..", "error", "alert-danger");
                s.setAttribute("msg", msg);
            }

            response.sendRedirect("profile.jsp");

            out.println("</body>");
            out.println("</html>");
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
