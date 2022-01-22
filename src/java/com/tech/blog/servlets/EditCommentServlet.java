package com.tech.blog.servlets;

import com.tech.blog.dao.CommentDao;
import com.tech.blog.entities.Comment;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
@MultipartConfig
public class EditCommentServlet extends HttpServlet {

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
            HttpSession s = request.getSession();
            User u = (User) s.getAttribute("currentUser");
            int uid = u.getId();
            
            Map<String,String[]> map = request.getParameterMap();
             System.out.println(map.size());
            for(String key:map.keySet()){
                System.out.print(key+"  ->  ");
                for(String values : map.get(key)){
                    System.out.print(values+" ");
                }
                System.out.println();
            }
            
            String commentcon = request.getParameter("comm_a");
            System.out.println(commentcon);
            int pid = Integer.parseInt(request.getParameter("post_id"));
            int cid = Integer.parseInt(request.getParameter("com_id"));
            Comment com = new Comment(cid, commentcon, pid, uid, null);
            CommentDao cd = new CommentDao(ConnectionProvider.getConnection());
            if (cd.updateComment(com)) {
                out.println("done");
            } else {
                out.println("error");
            }
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