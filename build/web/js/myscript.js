

function doLike(pid, uid, obj) {
    console.log(pid + "," + uid);
    const d = {
        uid: uid,
        pid: pid,
        operation: 'like'
    }
    $.ajax({
        url: "LikeServlet",
        data: d,
        success: function (data, textStatus, jqXHR) {
            console.log(data);
            if (data.trim() == 'true') {
                let c = $(obj).find(".like-counter").html();
                $(obj).addClass("btn-outline-success");
                c++;
                $(obj).find(".like-counter").html(c);
            } else if (data.trim() == 'truee') {
                let c = $(obj).find(".like-counter").html();
                $(obj).removeClass("btn-outline-success");
                c--;
                $(obj).find(".like-counter").html(c);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(data);
        }
    })
}

function dePost(pid, uid) {
    const d = {
        pid: pid,
        uid: uid
    }

    $.ajax({
        url: "DeletePostServlet",
        data: d,
        success: function (data, textStatus, jqXHR) {
            if (data.trim() == 'deleted') {
                swal({
                    title: "Post Deleted !",
                    text: "Post deleted successfully !",
                    icon: "success",
                }).then(window.location = "profile.jsp");
            } else {
                swal({
                    title: "Try Again !",
                    text: "Unable to delete the post !",
                    icon: "warning",
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

    })
}

function deComment(cid, uid) {
    const d = {
        cid: cid,
        uid: uid
    }

    $.ajax({
        url: "DeleteCommentServlet",
        data: d,
        success: function (data, textStatus, jqXHR) {
            if (data.trim() == 'deleted') {
                swal({
                    title: "Comment Deleted !",
                    text: "Comment deleted successfully !",
                    icon: "success",
                }).then((value) => {
                    window.location.reload()
                });
            } else {
                swal({
                    title: "Try Again !",
                    text: "Unable to delete the comment !",
                    icon: "warning",
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

    })
}

