
function doLike(pid,uid,temp){
    event.preventDefault();
    const data = {
        uid:uid,
        pid:pid,
        operation:'Like'
    }
    $.ajax({
        url:"LikeServlet",
        data:data,
        success: function (data, textStatus, jqXHR) {
            
            if(data.trim()=='true'){
                let c  = $(temp).find(".like-counter").html();
                console.log(c); 
                c++;
                
                $(temp).addClass(' btn-outline-success');
                $(temp).find(".like-counter").html(c);
            }
            else if(data.trim() == 'Deleted'){
                let c  = $(temp).find(".like-counter").html();
                console.log(c); 
                c--;
                
                $(temp).removeClass('btn-outline-success');
                $(temp).find(".like-counter").html(c);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(data);
        }
    })
}
