<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Comment"%>
<%@page import="com.tech.blog.dao.CommentDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page errorPage="error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>
<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao pd = new PostDao(ConnectionProvider.getConnection());
    Post p = pd.getPostByPostId(postId);

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getpTitle()%> || TechBlog</title>
        <!--css-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>

            body{
                background: url(img/bg.jpg);
                background-repeat: repeat;
                background-attachment: fixed;
            }

            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 25px;
            }
            .post-date{
                font-style: italic;
                font-weight: bold;
            }
            .post-user-info{
                font-size: 20px;
            }
            .row-user{
                border: 1px solid #e2e2e2;
                padding-top: 15px;
            }

            .userKaName:hover{
                text-decoration: none;
            }

        </style>
    </head>
    <body>
        <!--navbar-->
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="#"><span class="fa fa-code"></span> TechBlog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="index.jsp"><span class="fa fa-home"></span> Home<span class="sr-only">(current)</span></a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="contactPage.jsp"><span class="fa fa-address-card-o"></span> Contact Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-edit"></span> Do Post</a>
                    </li>
                </ul>

                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><span><img  class="img-fluid" style="height:2.9vh; width:2.9vh;  border-radius: 50%" src="<%= user.getId()%>/profilePhotos/<%= user.getProfile()%>" alt="alt"/>&nbsp;<%= user.getName()%> </span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-plus"></span> Logout</a>
                    </li>

                </ul>

            </div>
        </nav>
        <!--end of navbar-->

        <%
            Message m = (Message) session.getAttribute("msg");
            if (m != null) {
        %>
        <div class="alert <%= m.getCssClass()%>" role="alert">
            <%= m.getContent()%>
        </div>
        <%
                session.removeAttribute("msg");
            }
        %>
        <!--main content of the body-->

        <div class="container">
            <div class="row my-4">
                <div class="col-md-8">
                    <div class="card" style="width: 150%;">
                        <div class="card-header primary-background text-white">
                            <h4 class="post-title"><%= p.getpTitle()%></h4>
                        </div>
                        <div class="card-body">
                            <img class="card-img-top my-2" src="<%=p.getUserId()%>/postPhotos/<%= p.getpPic()%>" alt="alt"/>
                            <div class="row my-3 row-user">
                                <div class="col-md-8">
                                    <%
                                        UserDao ud = new UserDao(ConnectionProvider.getConnection());

                                    %>
                                    <p class="post-user-info">Posted by <a href="blogger_profile.jsp?user_id=<%= p.getUserId()%>"><%= ud.getUserByUserId(p.getUserId()).getName()%></a>: </p>
                                </div>
                                <div class="col-md-4">
                                    <p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
                                </div>
                            </div>
                            <p class="post-content"><%= p.getpContent()%></p>
                            <br><br>
                            <div class="post-code">
                                <%
                                    String pco = p.getpCode();
                                    if (pco != null) {
                                %>
                                <h3>Code Implementation</h3>
                                <pre style="background-color: #e2e2e2; padding: 10px;"><%= p.getpCode()%></pre>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <div class="card-footer primary-background">
                            <%
                                String co = "";
                                LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                                if (ld.isLikedByUser(p.getPid(), user.getId())) {
                                    co = "btn-outline-success";
                                }
                            %>
                            <a href="#!" onclick="doLike(<%= p.getPid()%>, <%=user.getId()%>, this)" class="btn btn-outline-primary <%=co%> btn-sm"><i class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%=ld.countLikeOnPost(p.getPid())%></span></a>
                                <%

                                    CommentDao cd = new CommentDao(ConnectionProvider.getConnection());
                                    int count = cd.countCommentOnPost(p.getPid());

                                %>
                            <a href="#!" class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting-o"></i> <span><%= count%></span></a>
                            <%
                                boolean editbtn = false;
                                int puid = p.getUserId();
                                int cuid = user.getId();
                                if (puid == cuid) {
                                    editbtn = true;
                                }
                            %>
                            <%
                                if (editbtn) {
                            %>
                            <span class="dropdown">
                                <button class="btn btn-light dropdown-toggle btn-sm" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                </button>
                                <div class="dropdown-menu">

                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#edit-post-modal" >Edit Post</a>
                                    <a onclick="dePost(<%= p.getPid()%>,<%= cuid%>)" class="dropdown-item" href="!#">Delete Post</a>
                                </div>
                            </span>
                            <%
                                }
                            %>
                            <!--comment section-->
                            <div class="container mt-5">
                                <div class="d-flex justify-content-center row">
                                    <div class="col-md-12">
                                        <div class="d-flex flex-column comment-section">
                                            <div class="primary-background text-white p-2">
                                                <form method="post" id="add-comment">
                                                    <div class="d-flex flex-row align-items-start">
                                                        <img class="rounded-circle" src="<%= user.getId()%>/profilePhotos/<%= user.getProfile()%>"  width="40" height="37">
                                                        <textarea name="comment-area" class="form-control ml-1 shadow-none textarea"></textarea>
                                                    </div>
                                                    <div class="mt-2 text-right">
                                                        <button  class="btn btn-primary btn-sm shadow-none" type="submit">Post comment</button>
                                                        <button class="btn btn-outline-primary btn-sm ml-1 shadow-none" type="reset">Cancel</button>
                                                    </div>
                                                </form>

                                            </div>

                                            <%
                                                String mg = "";
                                                List<Comment> coms = cd.getComments(p.getPid());
                                                if (coms.size() == 0) {
                                                    mg = "No comments on this posts";
                                                } else {
                                            %>
                                            <br>
                                            <div class="ml-2" style="color:white;"><h2>Comments</h2></div>
                                            <br>
                                            <%
                                                int i = 0;
                                                for (Comment com : coms) {
                                            %>
                                            <div class="com-box primary-background text-white p-2">

                                                <div class="d-flex flex-row user-info"><img class="rounded-circle" src="<%= com.getUid()%>/profilePhotos/<%= ud.getUserByUserId(com.getUid()).getProfile()%>" width="40" height="37">
                                                    <div class="box" style="display:flex; justify-content: space-around;">
                                                        <div class="d-flex flex-column justify-content-start ml-2">
                                                            <a style="color:white;" href="blogger_profile.jsp?user_id=<%= com.getUid()%>" class="userKaName d-block font-weight-bold name ml-2"><%= ud.getUserByUserId(com.getUid()).getName()%></a><span class="date ml-2"><%= DateFormat.getDateTimeInstance().format(com.getDate())%></span>
                                                        </div>
                                                        <%
                                                            boolean showb = false;
                                                            if (com.getUid() == user.getId()) {
                                                                showb = true;
                                                            }
                                                            if (showb) {
                                                        %>
                                                        <button onclick="funn(<%=i%>)" type="button" id="edit-com<%=i%>" class="btn btn-secondary btn-sm" style="margin-top: 5px; margin-left:20px; margin-right: 10px; height: 1.5em; padding-top: 0px;">Edit</button>
                                                        <button id="delete-com<%=i%>" onclick="deComment(<%= com.getCid()%>, <%= com.getUid()%>)" type="button" class="btn btn-secondary btn-sm" style="margin-top: 5px; margin-left:10px; margin-right: 10px; height: 1.5em; padding-top: 0px;">Delete</button>
                                                        <form id="edit-com-form" action="EditCommentServlet" method="post" >
                                                            <button onclick="editfun(<%= com.getCid() %>, <%=i%>)" type="submit" id="save-com<%=i%>" class="btn btn-secondary btn-sm" style="display:none; margin-top: 5px; margin-left:20px; margin-right: 10px; height: 1.5em; padding-top: 0px;">Save</button>
                                                            <%
                                                                }
                                                            %>


                                                    </div>
                                                </div>
                                                <div class="mt-2">
                                                    <p id="comment-text<%=i%>" class="text-left"><%= com.getCommentcon()%></p>
                                                    <textarea id="comm-a<%=i%>" style="display:none;" name="comm-a" class="form-control ml-1 shadow-none textarea"></textarea>
                                                </div>
                                                </form>
                                            </div>
                                            <%
                                                        i++;
                                                    }
                                                }
                                            %> 
                                            <div class="text-white text-center"><h3><%= mg%></h3></div>

                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--end of comment section-->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end of the body-->

        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white text-center">
                        <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="<%=user.getId()%>/profilePhotos/<%= user.getProfile()%>" class="img-fluid" style="height:25vh; width: 30vh; border-radius: 50%; "/>
                            <h5 class="modal-title" mt-3 id="exampleModalLabel"><%= user.getName()%></h5>
                            <!--details-->
                            <div id="profile-details">
                                <table class="table">

                                    <tbody>
                                        <tr>
                                            <th scope="row"> ID :</th>
                                            <td><%= user.getId()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row"> Email :</th>
                                            <td><%= user.getEmail()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row"> Gender :</th>
                                            <td><%= user.getGender()%></td>
                                        </tr>

                                        <tr>
                                            <th scope="row"> Status :</th>
                                            <td><%= user.getAbout()%></td>
                                        </tr>

                                        <tr>
                                            <th scope="row"> Registered on :</th>
                                            <td><%= user.getDateTime().toString()%></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <!--profile-edit-->
                            <div id="profile-edit" style="display:none;">
                                <h3 class="mt-2">Please Edit Carefully</h3>
                                <form action="EditServlet" method="post" enctype="multipart/form-data">
                                    <table class="table">

                                        <tr>
                                            <td>ID :</td>
                                            <td><%= user.getId()%></td>
                                        </tr>

                                        <tr>
                                            <td>New Profile:</td>
                                            <td><input type="file" name="image" class="form-control"></td>
                                        </tr>
                                        <tr>
                                            <td>Name :</td>
                                            <td><input type="text" class="form-control" name="user_name" value="<%= user.getName()%>"></td>
                                        </tr>

                                        <tr>
                                            <td>Email :</td>
                                            <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail()%>"></td>
                                        </tr>

                                        <tr>
                                            <td>Gender :</td>
                                            <td><%= user.getGender().toUpperCase()%></td>
                                        </tr>
                                        <tr>
                                            <td>About :</td>
                                            <td>
                                                <textarea rows="3" class="form-control" name="user_about">
                                                    <%= user.getAbout()%>
                                                </textarea>
                                            </td>
                                        </tr>

                                    </table>
                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-primary">Save</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                    </div>
                </div>
            </div>
        </div>
        <!--end of profile modal-->

        <!--add post modal-->
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Provide Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="add-post-form" action="AddPostServlet" method="post">
                            <div class="form-group">
                                <select class="form-control" name="cid">
                                    <option value="" selected disabled>---Select Category---</option>
                                    <%
                                        PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = postd.getAllCategories();
                                        for (Category c : list) {

                                    %>
                                    <option value="<%= c.getCid()%>"><%=c.getName()%></option>

                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Give a Title</label>
                                <input name="pTitle" type="text" placeholder="Enter Post Title" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label>Write your Content</label>
                                <textarea name="pContent" placeholder="Enter your Content" class="form-control" style="height:200px;"></textarea>
                            </div>
                            <div class="form-group">
                                <label>Write your program (if any)</label>
                                <textarea pCode placeholder="Enter your Program" class="form-control" style="height:200px;"></textarea>
                            </div>
                            <div class="form-group">
                                <label>Post Image</label>
                                <input name="pPic" type="file" class="form-control"/>
                            </div>

                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-primary"> Post </button>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
        <!--end of post modal-->

        <!--edit post modal-->

        <div class="modal fade" id="edit-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">

                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Edit your post details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="edit-post-form" action="EditPostServlet" method="post" enctype="multipart/form-data">
                            <div class="form-group">
                                <select class="form-control" name="cid">
                                    <option value="" selected disabled>---Select Category---</option>
                                    <%
                                        for (Category c : list) {

                                    %>
                                    <option value="<%= c.getCid()%>"><%=c.getName()%></option>

                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Give a Title</label>
                                <input name="pTitle" type="text" placeholder="Enter Post Title" value="<%= p.getpTitle()%>" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label>Write your Content</label>
                                <textarea name="pContent" placeholder="Enter your Content" class="form-control" style="height:200px;" ><%= p.getpContent()%></textarea>
                            </div>
                            <%
                                String code = "";
                                if (p.getpCode() != null) {
                                    code = p.getpCode();
                                }
                            %>
                            <div class="form-group">
                                <label>Write your program (if any)</label>
                                <textarea name="pCode" placeholder="Enter your Program" class="form-control" style="height:200px;"><%= code%></textarea>
                            </div>
                            <div class="form-group">
                                <label>Post Image</label>
                                <input name="pPic" type="file" class="form-control" value="<%=p.getUserId()%>/postPhotos/<%= p.getpPic()%>"/>
                            </div>

                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-primary"> Save </button>
                            </div>
                        </form>

                    </div>
                </div>

            </div>
        </div>
        <!--end of edit post modal-->

        <!--javascript-->
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
        crossorigin="anonymous"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>


        <script src="js/myscript.js" type="text/javascript"></script>
        <!--toggle-->
        <script>
                                                            $(document).ready(function () {
                                                                let editStatus = false;
                                                                $('#edit-profile-button').click(function () {
                                                                    if (editStatus == false) {
                                                                        $("#profile-details").hide();
                                                                        $("#profile-edit").show();
                                                                        editStatus = true;
                                                                        $(this).text("Back");
                                                                    } else {
                                                                        $("#profile-details").show();
                                                                        $("#profile-edit").hide();
                                                                        editStatus = false;
                                                                    }
                                                                })
                                                            })
        </script>

        <script>
            $(document).ready(function (e) {

                $("#add-post-form").on("submit", function (event) {
                    //this code gets called when form is submited
                    event.preventDefault();
                    console.log("you have clicked on submit");
                    let form = new FormData(this);

                    //now requesting to server
                    $.ajax({
                        url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            if (data.trim() == 'done') {
                                swal({
                                    title: "Good job!",
                                    text: "Saved Successfully !",
                                    icon: "success",
                                });
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            swal({
                                title: "Error !",
                                text: "Something went wrong, please try again !",
                                icon: "error",
                            });
                        },
                        processData: false,
                        contentType: false
                    })
                })
            })
        </script>

        <script>
            $(document).ready(function (e) {

                $("#edit-post-form").on("submit", function (event) {
                    //this code gets called when form is submited
                    var url_string = window.location.href;
                    var url = new URL(url_string);
                    var c = url.searchParams.get("post_id");
                    let form = new FormData(this);

                    event.preventDefault();
                    console.log("you have clicked on submit");

                    //now requesting to server
                    $.ajax({
                        url: "EditPostServlet?post_id=" + c,
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            if (data.trim() == 'done') {
                                window.location.reload();
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {

                        },
                        processData: false,
                        contentType: false
                    })
                })
            })
        </script>

        <script>
            $(document).ready(function () {
                $('#add-comment').on("submit", function (event) {
                    event.preventDefault();

                    //this code gets called when form is submited
                    var url_string = window.location.href;
                    var url = new URL(url_string);
                    var c = url.searchParams.get("post_id");
                    let form = new FormData(this);

                    var object = {};
                    form.forEach(function (value, key) {
                        object[key] = value;
                    });

                    $.ajax({
                        url: "CommentServlet?post_id=" + c,
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            //alert(data);
                            if (data.trim() == 'done') {
                                swal({
                                    title: "Good job!",
                                    text: "Comment posted successfully !",
                                    icon: "success",
                                }).then((value) => {
                                    window.location.reload()
                                });
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //alert(data);
                            swal({
                                title: "Error !",
                                text: "Something went wrong, please try again !",
                                icon: "error",
                            });
                        },
                        processData: false,
                        contentType: false,
                    })
                })
            })
        </script>

        <script>
            function funn(id) {
                $("#edit-com" + id).hide();
                $("#delete-com" + id).hide();
                $("#save-com" + id).show();
                
                var m = document.getElementById("comment-text"+id).textContent;
                
                $("#comment-text"+id).hide();
                $("#comm-a"+id).show();
                document.getElementById("comm-a"+id).value = m;
            }
        </script>
        
        <script>
            function editfun(cid, id){
                
                    event.preventDefault();
                    var url_string = window.location.href;
                    var url = new URL(url_string);
                    var p = url.searchParams.get("post_id");
                    var fo = document.getElementById("comm-a"+id);
                    
                    let form={
                        comm_a: fo.value,
                        post_id:p.toString(),
                        com_id:cid.toString(),
                        
                    }
                    
                    console.log(form);
                    $.ajax({
                        url: "EditCommentServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            //alert(data);
                            if (data.trim() == 'done') {
                                swal({
                                    title: "Good job!",
                                    text: "Comment saved successfully !",
                                    icon: "success",
                                }).then((value) => {
                                    window.location.reload()
                                });
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //alert(data);
                            swal({
                                title: "Error !",
                                text: "Something went wrong, please try again !",
                                icon: "error",
                            });
                        },
//                        processData: false,
//                        contentType: false,
                    })
            }
        </script>
    </body>
</html>