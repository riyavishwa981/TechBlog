package com.tech.blog.servlets;

import com.email.durgesh.Email;
import com.tech.blog.dao.UserDao;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
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
public class ForgotPasswordServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    int code;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            //to get the email and check wether it already exists or not
            String email = request.getParameter("user_email");
            //System.out.println(email);
            //create a user dao object...
            UserDao dao = new UserDao(ConnectionProvider.getConnection());
            if (dao.checkIfEmailAlreadyExists(email) != null) {

                String e = dao.checkIfEmailAlreadyExists(email);
                //System.out.println(e);
                out.println("valid");
                code = gen();
                HttpSession session = request.getSession();
                session.setAttribute("code", code);
                session.setAttribute("email", e);
                SimpleDateFormat formatter = new SimpleDateFormat("yy/MM/dd HH:mm:ss");
                Date date = new Date();
                try{
                    Date creDate = formatter.parse(formatter.format(date));
                    session.setAttribute("cdate", creDate);
                }catch(Exception er){
                    er.printStackTrace();
                }
    
              
                try {
                    Email myEmail = new Email("techBlog5363@gmail.com", "ujju5363#");
//                    From set kardo
                    myEmail.setFrom("techBlog5363@gmail.com", "TechBlog");
                    myEmail.setSubject("Verification Code");
                    myEmail.setContent("<h4>This is your verification code :- " + code + ".</h4><h1><strong>It will only be valid for 10 minutes! </h1>", "text/html");
                    myEmail.addRecipient(email);
                    myEmail.send();

                } catch (Exception er) {
                    System.out.println(er.getMessage());
                    er.printStackTrace();
                }

            } else {
                out.println("invalid");
            }
        }
    }

    public int gen() {
        Random r = new Random(System.currentTimeMillis());
        return 10000 + r.nextInt(20000);
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
