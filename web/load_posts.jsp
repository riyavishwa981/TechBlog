<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<div class = "row" >  
    <%
        User user = (User) session.getAttribute("currentUser");
        PostDao d = new PostDao(ConnectionProvider.getConnection());
        int cid = Integer.parseInt(request.getParameter("cid"));
        List<Post> posts = null;
        if (cid == 0) {
            posts = d.getAllPosts();
        } else {
            posts = d.getPostByCatId(cid);
        }
        if (posts.size() == 0) {
            out.println("<h3 class = 'display-3 mt-3 text-center'>No Post In This Category</h3>");
        }
        for (Post p : posts) {
            int userIdForPic = p.getUserId();
            String photoName = p.getpPic();
            if (photoName.length() == 0) {
                photoName = "default.jpg";
            }

            String postContent = p.getpContent();
            if (postContent.length() > 100) {
                postContent = postContent.substring(0, 100) + "......";
            }
    %>
    <div class="col-md-6 mt-2" >
        <div class="card">
            <div class="container-fluid">
                <img class="card-img-top "  src="<%= userIdForPic%>/blog_pics/<%= photoName%>" alt="Card image cap">
            </div>
            <div class="card-body">
                <b> <%= p.getpTitle()%>  </b>
                <p >  <%= postContent%> </p>

            </div>
            <div class="card-footer bg text-center">
                <%
                    LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                    int likes = ld.countLikeOnPost(p.getPid());
                    StringBuilder cssClass = new StringBuilder("btn btn-outline-primary btn-small mr-sm-2");
                    if (ld.isLikedByUser(p.getPid(), user.getId())) {
                        cssClass.append(" btn-outline-success");

                    }
                    cssClass.toString();
                %>

                <a href="#!" onclick="doLike(<%=  p.getPid()%>, <%= user.getId()%>, this)" class ="<%= cssClass%>"> <i class="fa fa-thumbs-o-up"></i> <span class="like-counter"> <%= likes%> </span></a>
                <a href="show_blog_page.jsp?post_id=<%= p.getPid()%> " class ="btn btn-outline-primary btn-small">Read More</a>

                <a href="#!" class ="btn btn-outline-primary btn-small "> <i class="fa fa-comment-o"></i> <span>53</span> </a>
            </div>

        </div>
    </div>

    <%
        }

    %>

</div>
