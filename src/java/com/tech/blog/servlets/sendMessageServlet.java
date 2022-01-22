/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.tech.blog.servlets;

import com.email.durgesh.Email;
import com.tech.blog.entities.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Hp
 */
@MultipartConfig
public class sendMessageServlet extends HttpServlet {

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
            String sender = u.getEmail();
            String name = request.getParameter("userName");
            String msg = request.getParameter("userMessage");
//            System.out.println(sender);
//            System.out.println(name);
//            System.out.println(msg);
            String content = "<html><head><style>* {\n"
                    + "	@include labotomized-owl;\n"
                    + "}\n"
                    + "\n"
                    + ".table-responsive {\n"
                    + "	border-collapse: collapse;\n"
                    + "	margin: $g-spacing / 2 0;\n"
                    + "	table-layout: fixed;\n"
                    + "	@include no-margin;\n"
                    + "	width: 100%;\n"
                    + "	color: $g-font-color;\n"
                    + "	* {\n"
                    + "		font-size: 13px;\n"
                    + "	}\n"
                    + "	i {\n"
                    + "		&.blank {\n"
                    + "			display: none;\n"
                    + "		}\n"
                    + "	}\n"
                    + "\n"
                    + "	th {\n"
                    + "		border-bottom: 1px solid shade($g-border-color, 25%);\n"
                    + "		text-align: left;\n"
                    + "		padding: $g-spacing / 2 $g-spacing / 1.4;\n"
                    + "		text-align: center;\n"
                    + "		&:not([data-title]) {\n"
                    + "			font-weight: bold;\n"
                    + "			@include bp(tablet) {\n"
                    + "				border-right: 1px solid #037f9e;\n"
                    + "			}\n"
                    + "		}\n"
                    + "		&.table-column {\n"
                    + "			width: 200px;\n"
                    + "		}\n"
                    + "		&.row {\n"
                    + "			background: #09bad6;\n"
                    + "			color: $white;\n"
                    + "		}\n"
                    + "	}\n"
                    + "	th[data-title]:before,\n"
                    + "	td[data-title]:before {\n"
                    + "		content: attr(data-title) \":\\00A0\";\n"
                    + "		font-weight: bold;\n"
                    + "		text-align: left;\n"
                    + "		@include bp(tablet) {\n"
                    + "			content: none;\n"
                    + "		}\n"
                    + "	}\n"
                    + "	tr {\n"
                    + "		margin: 0 0 0rem 0;\n"
                    + "		&:nth-child(odd) {\n"
                    + "			background: lighten($g-background-color-light, 5%);\n"
                    + "\n"
                    + "			&.header-row {\n"
                    + "				background: #037f9e !important;\n"
                    + "				color: $white;\n"
                    + "			}\n"
                    + "		}\n"
                    + "		&:nth-child(even) {\n"
                    + "			background: lighten($g-background-color-light, 1%);\n"
                    + "		}\n"
                    + "		td {\n"
                    + "			/* Behave  like a \"row\" */\n"
                    + "			border: 0;\n"
                    + "			border-bottom: 1px solid darken($g-background-color-light, 11%);\n"
                    + "			position: relative;\n"
                    + "			padding-left: 50%;\n"
                    + "			padding-right: $g-spacing / 2;\n"
                    + "			text-align: right;\n"
                    + "			padding: 15px;\n"
                    + "			@include bp(tablet) {\n"
                    + "				vertical-align: top;\n"
                    + "				border-bottom: 0;\n"
                    + "				padding: $g-spacing;\n"
                    + "				border-right: 1px solid $white;\n"
                    + "				text-align: center;\n"
                    + "			}\n"
                    + "			ul {\n"
                    + "				margin-left: 0;\n"
                    + "				margin-bottom: 5px;\n"
                    + "				padding: 0 0 0 $g-spacing;\n"
                    + "\n"
                    + "				li {\n"
                    + "					padding: 3px 0;\n"
                    + "				}\n"
                    + "			}\n"
                    + "		}\n"
                    + "	}\n"
                    + "\n"
                    + "	@include bp(tablet-only) {\n"
                    + "		/* Force table to not be like tables anymore */\n"
                    + "		table,\n"
                    + "		thead,\n"
                    + "		tbody,\n"
                    + "		th,\n"
                    + "		td,\n"
                    + "		tr {\n"
                    + "			display: block;\n"
                    + "			vertical-align: middle;\n"
                    + "		}\n"
                    + "\n"
                    + "		/* Hide table headers (but not display: none;, for accessibility) */\n"
                    + "		thead tr {\n"
                    + "			position: absolute;\n"
                    + "			top: -9999px;\n"
                    + "			left: -9999px;\n"
                    + "		}\n"
                    + "\n"
                    + "		tr {\n"
                    + "			td {\n"
                    + "				&:before {\n"
                    + "					/* Now like a table header */\n"
                    + "					position: absolute;\n"
                    + "					/* Top/left values mimic padding */\n"
                    + "					//top: 0;\n"
                    + "					left: 6px;\n"
                    + "					width: 45%;\n"
                    + "					padding-right: 10px;\n"
                    + "					white-space: nowrap;\n"
                    + "					padding-left: $g-spacing / 2;\n"
                    + "				}\n"
                    + "				&.empty {\n"
                    + "					display: none;\n"
                    + "				}\n"
                    + "			}\n"
                    + "		}\n"
                    + "	}\n"
                    + "}</style></head><body><div class=\"wrapper\">\n"
                    + "	<center>\n"
                    + "		<h1>FeedBack</h1>\n"
                    + "	</center>\n"
                    + "	<table class=\"table-responsive table-vaccine\">\n"
                    + "		<thead role=\"rowgroup\">\n"
                    + "			<tr role=\"row\" class=\"header-row\">\n"
                    + "				<th role=\"columnheader\" class=\"table-column\">Name</th>\n"
                    + "				<th role=\"columnheader\">Email</th>\n"
                    + "				<th role=\"columnheader\">Feedback</th>\n"
                    + "			</tr>\n"
                    + "		</thead>\n"
                    + "		<tbody role=\"rowgroup\">\n"
                    + "			<tr>\n"
                    + "				<th scope=\"row\" class=\"row\">" + name + "</th>\n"
                    + "				<td data-title=\"Reach\">" + sender + "</td>\n"
                    + "				<td data-title=\"Crank Length\">" + msg + "</td>\n"
                    + "			</tr>\n"
                    + "		</tbody>\n"
                    + "	</table>\n"
                    + "</div></body></html>";
            try {
                System.out.println(content);
                Email myEmail = new Email("techBlog5363@gmail.com", "ujju5363#");
                myEmail.setFrom(sender, name);
                myEmail.setSubject("Feedback");
                myEmail.setContent(content, "text/html");
                myEmail.addRecipient("techBlog5363@gmail.com");
                myEmail.send();
                out.println("done");
            } catch (Exception er) {
                er.printStackTrace();
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
