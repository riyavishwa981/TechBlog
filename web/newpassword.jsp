<%
    if(session.getAttribute("email")==null){
        response.sendRedirect("login_page.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Password Page</title>
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
        </style>
    </head>
    <body>
         <%@include file="normal_navbar.jsp" %>
         <main class="d-flex align-items-center" style="height: 90vh">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 offset-md-4">
                        <div class="card">
                            <div class="card-header primary-background text-white text-center">
                                <span class="fa fa-user-circle fa-3x"></span>
                                <br>
                                <h4>New Password</h4>
                            </div>

                            <div id="newpass" class="card-body">
                                <form id="change_pass" action="NewPasswordServlet"  method="POST">
                                    <div id="user_password" class="form-group">
                                        <label>New Password</label>
                                        <input name="password" required type="password" class="form-control"  placeholder="Password">
                                    </div>
                                    <div id="cuser_password" class="form-group">
                                        <label>Confirm New Password</label>
                                        <input name="cpassword" required type="password" class="form-control"  placeholder="Password">
                                    </div>
                                    <div class="container text-center" id="loader" style="display:none;">
                                        <span class="fa fa-refresh fa-spin fa-3x"></span>
                                        <h4>Please wait...</h4>
                                    </div>
                                    <div class="container text-center">
                                        <button  id="submit-btn"  type="submit" class="btn btn-dark">Submit</button>
                                    </div>

                                </form>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </main>
         
         
         
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
        crossorigin="anonymous"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/myscript.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        
        <script>
            $(document).ready(function (){
                $("#change_pass").on('submit', function (event){
                    event.preventDefault();
                    let form = new FormData(this);
                    console.log(form);
                    $("#submit-btn").hide();
                    $("#loader").show();
                    $.ajax({
                        url: "NewPasswordServlet",
                        type: 'POST',
                        data: form,
                        success:function(data, textStatus, jqXHR){
                            console.log(data);
                            $("#submit-btn").show();
                            $("#loader").hide();
                            if (data.trim() === 'invalid') {
                                swal({
                                    title: "Try Again!",
                                    text: "Your confirm password is not matching the new password !",
                                    icon: "warning",
                                    button: "OK",
                                }).then((value) => {
                                    window.location.reload();
                                });
                            }else if(data.trim() === 'done'){
                                swal({
                                    title: "Good job!",
                                    text: "Password changed successfully !",
                                    icon: "success",
                                    button: "OK",
                                }).then((value) => {
                                    window.location = "login_page.jsp";
                                });
                            }
                        },
                        error:function(jqXHR, textStatus, errorThrown){
                            $("#submit-btn").show();
                            $("#loader").hide();
                            swal({
                                title: "Try Again",
                                text: "Something went wrong !",
                                icon: "error",
                                button: "OK",
                            }).then((value) => {
                                window.location.reload();
                            });
                        },
                        processData: false,
                        contentType: false,
                    })
                })
            })
        </script>
    </body>
</html>
