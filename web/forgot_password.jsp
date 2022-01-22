
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forgot Password Page</title>
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
        <!--navbar-->
        <%@include file="normal_navbar.jsp" %>
        <main class="d-flex align-items-center" style="height: 90vh">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 offset-md-4">
                        <div class="card">
                            <div class="card-header primary-background text-white text-center">
                                <span class="fa fa-user-circle fa-3x"></span>
                                <br>
                                <h4>Forgot Password</h4>
                            </div>

                            <div id="sendemail" class="card-body">
                                <form id="fp_form1" action="ForgotPasswordServlet"  method="POST">
                                    <div id="user_email" class="form-group">
                                        <label>Email address</label>
                                        <input name="user_email" required type="email" class="form-control" placeholder="Enter email">
                                        <small class="form-text text-muted">Enter email to receive the code</small>
                                    </div>

                                    <div class="container text-center" id="loader1" style="display:none;">
                                        <span class="fa fa-refresh fa-spin fa-3x"></span>
                                        <h4>Please wait...</h4>
                                    </div>
                                    <div class="container text-center">
                                        <button  id="submit-btn-1"  type="submit" class="btn btn-dark">Submit</button>
                                    </div>

                                </form>
                            </div>

                            <div id="sendcode" class="card-body" style="display:none;">
                                <form id="fp_form2"  method="POST">
                                    <div id="user_code" class="form-group">
                                        <label>Code</label> 
                                        <input name="user_code" required type="number" class="form-control"  placeholder="Enter code">
                                    </div>

                                    <div class="container text-center" id="loader2" style="display:none;">
                                        <span class="fa fa-refresh fa-spin fa-3x"></span>
                                        <h4>Please wait...</h4>
                                    </div>

                                    <div class="container text-center">
                                        <button id="submit-btn-2"  type="submit" class="btn btn-dark">Submit</button>
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

            $(document).ready(function () {
                $("#fp_form1").on('submit', function (event) {
                    event.preventDefault();
                    let form = new FormData(this);
                    console.log(form);
                    $("#submit-btn-1").hide();
                    $("#loader1").show();
                    $.ajax({
                        url: "ForgotPasswordServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            $("#submit-btn-1").show();
                            $("#loader1").hide();
                            if (data.trim() === 'invalid') {
                                swal({
                                    title: "Try Again!",
                                    text: "This email does not exist !",
                                    icon: "warning",
                                    button: "OK",
                                }).then((value) => {
                                    window.location = "forgot_password.jsp"
                                });
                            } else if (data.trim() === 'valid') {
                                swal({
                                    title: "Good job!",
                                    text: "You will recieve the code !",
                                    icon: "success",
                                    button: "OK",
                                }).then((value) => {
                                    
                                    $("#sendemail").hide();
                                    $("#sendcode").show();
                                });

                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $("#submit-btn-1").show();
                            $("#loader1").hide();
                            swal({
                                title: "Try Again",
                                text: "Something went wrong !",
                                icon: "error",
                                button: "OK",
                            }).then((value) => {
                                window.location = "forgot_password.jsp"
                            });
                        },
                        processData: false,
                        contentType: false,
                    })
                    
                })
            })
        </script>
        
        <script>
            $(document).ready(function () {
                $("#fp_form2").on('submit', function (event) {
                    event.preventDefault();
                    let form = new FormData(this);
                    console.log(form);
                    $("#submit-btn-2").hide();
                    $("#loader2").show();
                    $.ajax({
                        url: "VerifyCodeServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            $("#submit-btn-2").show();
                            $("#loader2").hide();
                            if (data.trim() === 'invalid') {
                                swal({
                                    title: "Try Again!",
                                    text: "The code is invalid !",
                                    icon: "warning",
                                    button: "OK",
                                }).then((value) => {
                                    $("#sendemail").hide();
                                    $("#sendcode").show();
                                });
                            } else if (data.trim() === 'valid') {
                                swal({
                                    title: "Code Verified !",
                                    text: "Now you can set up your new password",
                                    icon: "success",
                                    button: "OK",
                                }).then((value) => {
                                    window.location = "newpassword.jsp";
                                });

                            }else if(data.trim() === 'timeout'){
                                swal({
                                    title: "Code Expired !",
                                    text: "Try again to get another code",
                                    icon: "success",
                                    button: "OK",
                                }).then((value) => {
                                    window.location.reload();
                                });
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $("#submit-btn-2").show();
                            $("#loader2").hide();
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
