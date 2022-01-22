

<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>


<%
    User user = (User) session.getAttribute("currentUser");
//    System.out.println(user);
    if (user == null) {
        System.out.println(user);
        response.sendRedirect("login_page.jsp");
        return;
    }

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/mystyle.css"/>
        <!--css-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contact Us Page</title>
        <style>
            /*Contact page style*/

            *, *:before, *:after {
                box-sizing: border-box;
                -webkit-font-smoothing: antialiased;
                -moz-osx-font-smoothing: grayscale;
            }

            body {
                /*background: linear-gradient(to right, #ea1d6f 0%, #eb466b 100%);*/
                background: url(img/bg.jpg);
                background-repeat: repeat;
                background-attachment: fixed;
                font-size: 12px;
            }

            body, button, input {
                font-weight: 700;
            }

            .background {
                display: flex;
                min-height: 100vh;
            }

            .container {
                flex: 0 1 700px;
                margin: auto;
                padding: 10px;
            }

            .screen {
                position: relative;
                background: #3e3e3e;
                border-radius: 15px;
            }

            .screen:after {
                content: '';
                display: block;
                position: absolute;
                top: 0;
                left: 20px;
                right: 20px;
                bottom: 0;
                border-radius: 15px;
                box-shadow: 0 20px 40px rgba(0, 0, 0, .4);
                z-index: -1;
            }

            .screen-header {
                display: flex;
                align-items: center;
                padding: 10px 20px;
                background: #4d4d4f;
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
            }

            .screen-header-left {
                margin-right: auto;
            }

            .screen-header-button {
                display: inline-block;
                width: 8px;
                height: 8px;
                margin-right: 3px;
                border-radius: 8px;
                background: white;
            }

            .screen-header-button.close {
                background: #ed1c6f;
            }

            .screen-header-button.maximize {
                background: #e8e925;
            }

            .screen-header-button.minimize {
                background: #74c54f;
            }

            .screen-header-right {
                display: flex;
            }

            .screen-header-ellipsis {
                width: 3px;
                height: 3px;
                margin-left: 2px;
                border-radius: 8px;
                background: #999;
            }

            .screen-body {
                display: flex;
            }

            .screen-body-item {
                flex: 1;
                padding: 50px;
            }

            .screen-body-item.left {
                display: flex;
                flex-direction: column;
            }

            .app-title {
                display: flex;
                flex-direction: column;
                position: relative;
                color: #ea1d6f;
                font-size: 26px;
            }

            .app-title:after {
                content: '';
                display: block;
                position: absolute;
                left: 0;
                bottom: -10px;
                width: 25px;
                height: 4px;
                background: #ea1d6f;
            }

            .app-contact {
                margin-top: auto;
                font-size: 8px;
                color: #888;
            }

            .app-form-group {
                margin-bottom: 15px;
            }

            .app-form-group.message {
                margin-top: 40px;
            }

            .app-form-group.buttons {
                margin-bottom: 0;
                text-align: right;
            }

            .app-form-control {
                width: 100%;
                padding: 10px 0;
                background: none;
                border: none;
                border-bottom: 1px solid #666;
                color: #ddd;
                font-size: 14px;
                text-transform: uppercase;
                outline: none;
                transition: border-color .2s;
            }

            .app-form-control::placeholder {
                color: #666;
            }

            .app-form-control:focus {
                border-bottom-color: #ddd;
            }

            .app-form-button {
                background: none;
                border: none;
                color: #ea1d6f;
                font-size: 14px;
                cursor: pointer;
                outline: none;
            }

            .app-form-button:hover {
                color: #b9134f;
            }




            .dribbble {
                width: 20px;
                height: 20px;
                margin: 0 5px;
            }

            @media screen and (max-width: 520px) {
                .screen-body {
                    flex-direction: column;
                }

                .screen-body-item.left {
                    margin-bottom: 30px;
                }

                .app-title {
                    flex-direction: row;
                }

                .app-title span {
                    margin-right: 12px;
                }

                .app-title:after {
                    display: none;
                }
            }

            @media screen and (max-width: 600px) {
                .screen-body {
                    padding: 40px;
                }

                .screen-body-item {
                    padding: 0;
                }
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

        <form method="post" id = "messageForm">
            <div class="background">
                <div class="container">
                    <div class="screen">
                        <div class="screen-header">
                            <div class="screen-header-left">
                                <div class="screen-header-button close"></div>
                                <div class="screen-header-button maximize"></div>
                                <div class="screen-header-button minimize"></div>
                            </div>
                            <div class="screen-header-right">
                                <div class="screen-header-ellipsis"></div>
                                <div class="screen-header-ellipsis"></div>
                                <div class="screen-header-ellipsis"></div>
                            </div>
                        </div>
                        <div class="screen-body">
                            <div class="screen-body-item left">
                                <div class="app-title">
                                    <span>CONTACT</span>
                                    <span>US</span>
                                </div>
                                <div class="app-contact">CONTACT INFO : 9635398120</div>
                            </div>
                            <div class="screen-body-item">
                                <div class="app-form">

                                    <div class="app-form-group">
                                        <input class="app-form-control" placeholder="NAME" name = "userName" required>
                                    </div>
                                    <div class="app-form-group message">
                                        <textarea class="app-form-control" placeholder="MESSAGE" name = "userMessage" required ></textarea>
                                    </div>
                                    <div class="app-form-group buttons">
                                        <button class="app-form-button" type="reset">CANCEL</button>
                                        <button class="app-form-button" type="submit">SEND</button>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </form>

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
                        <button type="button" class="btn btn-outline-dark" data-dismiss="modal">Close</button>
                        <button id="edit-profile-button" type="button" class="btn btn-outline-dark">Edit</button>
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
                                <textarea name="pCode" placeholder="Enter your Program" class="form-control" style="height:200px;"></textarea>
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
    </body>
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
                            }).then((value) => {
                                window.location.reload();
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
            $("#messageForm").on("submit", function (event) {
                event.preventDefault();
                let form = new FormData(this);
                $.ajax({
                    url: "sendMessageServlet",
                    type: "Post",
                    data: form,
                    success: function (data, textStatus, jqXHR) {
                        if (data.trim() == 'done') {
                            swal({
                                text: "Email Sent Successfully !",
                                icon: "success",
                            }).then((value) => {
                                window.location = "profile.jsp";
                            });
                        }

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        swal({
                            text: "Something went wrong, please try again !",
                            icon: "error",
                        });
                    },
                    processData: false,
                    contentType: false,
                })
            })
        });

    </script>




</html>
