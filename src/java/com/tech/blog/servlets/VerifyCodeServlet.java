/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.TimeUnit;
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
public class VerifyCodeServlet extends HttpServlet {

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
            Date currDate = null;
            HttpSession session = request.getSession();
            Date creationDate = (Date) session.getAttribute("cdate");
            SimpleDateFormat formatter = new SimpleDateFormat("yy/MM/dd HH:mm:ss");
            Date date = new Date();
            try {
                currDate = formatter.parse(formatter.format(date));
            } catch (Exception er) {
                er.printStackTrace();
            }
            System.out.println(creationDate);
            System.out.println(currDate);
            long diff = currDate.getTime() - creationDate.getTime();

            long days = TimeUnit.MILLISECONDS.toDays(diff);
            long remainingHoursInMillis = diff - TimeUnit.DAYS.toMillis(days);
            long hours = TimeUnit.MILLISECONDS.toHours(remainingHoursInMillis);
            long remainingMinutesInMillis = remainingHoursInMillis - TimeUnit.HOURS.toMillis(hours);
            long minutes = TimeUnit.MILLISECONDS.toMinutes(remainingMinutesInMillis);
            long remainingSecondsInMillis = remainingMinutesInMillis - TimeUnit.MINUTES.toMillis(minutes);
            long seconds = TimeUnit.MILLISECONDS.toSeconds(remainingSecondsInMillis);
            //System.out.println(diff + " " + minutes + " " + seconds);
            if (days > 0 || hours > 0) {
                out.println("timeout");
            } else {
                if (minutes > 10) {
                    out.println("timeout");
                } else {
                    Integer codefs = (Integer) session.getAttribute("code");
                    int codefu = Integer.parseInt(request.getParameter("user_code"));

                    if (codefs == codefu) {
                        out.println("valid");
                    } else {
                        out.println("invalid");
                    }
                }
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
