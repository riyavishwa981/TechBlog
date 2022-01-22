<%@page import="com.tech.blog.dao.CommentDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page errorPage="error_page.jsp" %>

<div class="row">
    <%
        User user = (User) session.getAttribute("currentUser");
        //Thread.sleep(1000);
        PostDao d = new PostDao(ConnectionProvider.getConnection());
        int cid = Integer.parseInt(request.getParameter("cid"));
        List<Post> posts = null;
        if (cid == 0) {
            posts = d.getAllPosts();
        } else {
            posts = d.getPostByCatId(cid);
        }
        if (posts.size() == 0) {
            out.println("<h3 class='display-3 text-center'>No Posts in this category yet..</h3>");
            return;
        }
        for (Post p : posts) {
    %>

    <div class="col-md-6 mt-2">
        <div class="card">
            <img class="card-img-top" style="height:25vh; width:100%;" src="<%=p.getUserId()%>/postPhotos/<%= p.getpPic()%>" alt="Card image cap">
            <div class="card-body">
                <b><%= p.getpTitle()%></b>
                <%
                    String pc = "";
                    int len = p.getpContent().length();
                    if (len < 36) {
                        pc = p.getpContent();
                    } else {
                        pc = p.getpContent().substring(0, 36) + "...";
                    }
                %>

                <p><%=pc%></p>

            </div>
            <div class="card-footer text-center primary-background">
                <%
                    String co = "";
                    LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                    if (ld.isLikedByUser(p.getPid(), user.getId())) {
                        co = "btn-outline-success";
                    }
                %>

                <a href="#!" onclick="doLike(<%= p.getPid()%>, <%=user.getId()%>, this)" class="btn btn-outline-primary <%=co%> btn-sm"><i class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%=ld.countLikeOnPost(p.getPid())%></span></a>
                <a href="show_blog_page.jsp?post_id=<%=p.getPid()%>" class="btn btn-light btn-sm">Read More..</a>
                <%

                    CommentDao cd = new CommentDao(ConnectionProvider.getConnection());
                    int count = cd.countCommentOnPost(p.getPid());

                %>
                <a href="#!" class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting-o"></i> <span><%= count%></span></a>

            </div>
        </div>
    </div>

    <%
        }
    %>
</div>

