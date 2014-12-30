var t = n = 0, count;

function set_image_roll_show() {
    $(document).ready(function () {
        count = $("#banner_list a").length;
        $("#banner_list a:not(:first-child)").hide();
        $("#banner li").click(function () {
            var i = $(this).attr('rel') - 1;//获取Li元素内的值，即1，2，3，4
            n = i;
            if (i >= count) return;
            $("#banner_list a").filter(":visible").fadeOut(500).parent().children().eq(i).fadeIn(500);
            $(this).css({"background": "#f19149 ", "color": "#000"}).siblings().css({"background": "#FFFFFF", 'color': '#fff'});
        });
        t = setInterval("showAuto()", 3000);
        $("#banner").hover(function () {
            clearInterval(t)
        }, function () {
            t = setInterval("showAuto()", 3000);
        });
    })
}

function showAuto() {
    n = n >= (count - 1) ? 0 : ++n;
    $("#banner li").eq(n).trigger('click');
}

function set_home_label_status(btn) {
    console.log($(btn).attr('name'))
    var label = $(btn).text().replace(/(^\s+)|(\s+$)/g, "");
    $(btn).css({"background": "#dddddd ", "disabled": "disabled"}).siblings().css({"background": "#f4f4f4 ", "disabled": false});

    $.ajax({
        type: "POST",
        url: 'save_header_label_content_to_session',
        data: {'label_content': label}
    }).success(function () {
        if($(btn).attr('name')==1){
            window.location = 'site_label_detail';
        }else{
            window.location = 'home_label_detail';
        }
        });
}

function set_header_status() {
    var present_label = $('#label_content').text().replace(/(^\s+)|(\s+$)|(\/)/g, "");
    var as = $('a');
    for (var i = 0; i < as.length; i++) {
        if (as[i].id == present_label) {
            $("#" + present_label).css({"background": "#dddddd ", "disabled": "disabled"}).siblings().css({"background": "#f4f4f4 ", "disabled": false});
            break;
        }
    }
    $("#主页").css({"background": "#f4f4f4 ", "disabled": false});
}

function home_search() {
    var input = $("#search_location_input").val();
    $.ajax({
        type: "POST",
        url: 'save_label_content_to_session',
        data: {'label_content': input}
    }).success(function () {
            window.location = '/site_label_detail';
        });
}

function show_restaurant_list(canting) {
    var label_content = $(canting).attr('rel');
    var canting_num = $(canting).attr('name');
    if (canting_num != 0) {
        $.ajax({
            type: "POST",
            url: 'save_label_content_to_session',
            data: {'label_content': label_content}
        }).success(function () {
                window.location = '/site_label_detail';
            })
    }
}

function set_image_hover() {
    $('img').attr('name', 'image_hover').hover(function () {
        var id_num = $(this).attr('id');
        if ($('#image_show' + id_num).attr('rel') != '/photos/original/missing.png') {
            $('#image_show' + id_num).removeClass('hidden');
        } else {
            $('#image_show' + id_num).addClass('hidden');
        }
    }, function () {
        var id_num = $(this).attr('id');
        $('#image_show' + id_num).addClass('hidden');
    });
}

function home_label_detail_search(btn) {
        var input = $('#home_label_detail_input').val();
        var merchants = JSON.parse($(btn).attr('rel').replace(/=>/g, ':'));
        for (var i = 0; i < merchants.length; i++) {
            var restaurant_name = merchants[i]["restaurant_name"];
            $("div[id^=" + restaurant_name +"]").addClass('hidden')
            var find_dish = false;
            for (var j = 0; j < merchants[i]["dish"].length; j++) {
                var dish_name = merchants[i]["dish"][j]["dish_name"];
                if (dish_name.match(input)) {
                    find_dish = true
                }
            }
            if (restaurant_name.match(input) || find_dish) {
                $("div[id^=" + restaurant_name +"]").removeClass('hidden')
            }
        }
}

function restaurant_detail_search(btn) {
        var input = $('#restaurant_detail_input').val();
        var dishes = JSON.parse($(btn).attr('rel').replace(/=>/g, ':'));
    console.log(dishes);
    console.log(btn);
        for (var i = 0; i < dishes.length; i++) {
            var label_id = dishes[i]["label_content"].replace(/(\/)/, '');
            $("#show" + label_id).addClass('hidden');
            var is_find = false;
            for (var j = 0; j < dishes[i]["dish_names"].length; j++) {
                var dish_name = dishes[i]["dish_names"][j];
                $("#show" + label_id + dish_name).addClass('hidden');

                if (dish_name.match(input)) {
                    is_find = true;
                    $("#show" + label_id + dish_name).removeClass('hidden');
                }
            }
            if (is_find) {
                $("#show" + label_id).removeClass('hidden');
            }
        }
}

function set_favor_status(){
    var rel=$("#merchant_favors_info").attr("rel");
    if (rel){
        var favor_infos=JSON.parse(rel.replace(/=>/g, ':'));
        var flag=false;
        for(var i=0;i<favor_infos["user_favors"].length;i++){
            if(favor_infos["user_favors"][i]==favor_infos["merchant_id"]) {
                flag=true;
            }
        }
        if(flag){
        $("#favor").removeClass('hidden')
        }else{
        $("#not_favor").removeClass('hidden')
        }
    }

}

function not_ever_favor(user_id,merchant_id){
    $('#not_favor').load('/delete_favor #not_favor_block',{"user_id":user_id,"merchant_id":merchant_id},function(){
        $("#favor").fadeOut(0);
        $("#not_favor").removeClass('hidden')
        $("#not_favor").fadeIn(0)
    });
}

function favor_it(user_id,merchant_id){
    $('#favor').load('/add_favor #favor_block',{"user_id":user_id,"merchant_id":merchant_id},function(){
        $("#not_favor").fadeOut(0)
        $("#favor").removeClass('hidden');
        $("#favor").fadeIn(0);

    })
}

function enter_search_location_btn() {
    $("#search_location_input").keydown(function (event) {
        if (event.keyCode == 13) {
            $("#search_location_btn").click();
        }
    })
}

function enter_home_label_detail_search() {
    $("#home_label_detail_input").keydown(function (event) {
        if (event.keyCode == 13) {
            $("#home_label_detail_search").click();
        }
    })
}

function enter_restaurant_detail_search() {
    $("#restaurant_detail_input").keydown(function (event) {
        if (event.keyCode == 13) {
            $("#restaurant_detail_search").click();
        }
    })
}

function hide_mail_form() {
    $('#mail_form').modal('hide');
}

function show_mail_form() {
    $('#mail_form').modal('show');
}

function send_mail_form() {
    var input_legal = checkName() && checkRestaurantName() && checkMobil() && checkEmail();
    if (input_legal) {
        var mail = {};
        mail["mail_to"] = $("#mail_to").attr('rel');
        mail["mailer_name"] = $("#mailer_name").val();
        mail["mailer_phone"] = $("#mailer_phone").val();
        mail["mailer_email"] = $("#mailer_email").val();
        mail["mailer_content"] = $("#mailer_content").val();
        mail["mailer_restaurant_name"] = $("#mailer_restaurant_name").val();
        $.ajax({
            type: "POST",
            url: 'send_mail',
            data: {'mail': mail}
        }).success(function () {
                $("#send_success").removeClass('hidden');
                setTimeout('hide_mail_form()', 3000);
            })
    }
}

function checkEmail() {
    var email_input = $("#mailer_email").val();
    if (email_input == "") {
        $("#emailMsg").html("<font color='red'>邮箱地址不能为空！</font>");
        $("#mailer_email").focus();
        return false;
    }
    if (!email_input.match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)) {
        $("#emailMsg").html("<font color='red'>邮箱格式不正确！请重新输入！</font>");
        $("#mailer_email").focus();
        return false;
    }
    $("#emailMsg").html('');
    return true;
}

function checkMobil() {
    var phone_input = $("#mailer_phone").val();
    if (phone_input == "") {
        $("#phoneMsg").html("<font color='red'>手机号码不能为空！</font>");
        $("#mailer_phone").focus();
        return false;
    }
    if (!phone_input.match(/^04\d{8}$/)) {
        $("#phoneMsg").html("<font color='red'>手机号码格式不正确！请重新输入！</font>");
        $("#mailer_phone").focus();
        return false;
    }
    $("#phoneMsg").html('');
    return true;
}

function checkName() {
    var name_input = $("#mailer_name").val();
    if (name_input == "") {
        $("#nameMsg").html("<font color='red'>姓名不能为空！</font>");
        $("#mailer_name").focus();
        return false;
    }
    $("#nameMsg").html('');
    return true;
}

function checkRestaurantName() {
    var restaurant_name_input = $("#mailer_restaurant_name").val();
    if (restaurant_name_input == "") {
        $("#restaurantMsg").html("<font color='red'>餐馆名称不能为空！</font>");
        $("#mailer_restaurant_name").focus();
        return false;
    }
    $("#restaurantMsg").html('');
    return true;
}

function user_login(){
    current_url = window.location.href;
    name=document.getElementById("login_name").value;
    password=document.getElementById("login_password").value;
    if (!name ||!password){
        $("#err").html("<div class='alert alert-danger'>请将信息填写完整！</div>");
        return
    }
    $.ajax({
        type: "POST",
        url: "user_login",
        data: {"name":name,"password":password}
    }).success(function(back){
        if(back["data"]=="not_found"){
            $("#err").html("<div class='alert alert-danger'>用户名或密码错误！</div>");
        }
        if(back["data"]=="true"){
            window.location.href = current_url;
        }
    })
}

function recover_password(){
    email=document.getElementById("email").value;
    if (!email){
        $("#err").html('<div class="alert alert-danger">请输入邮箱地址！</div>')
        return
    }
    if(email.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) == -1){
        $("#err").html('<div class="alert alert-danger">邮箱格式不正确！</div>')
        return
    }
    $.ajax({
        type: "POST",
        url: '/recover_password',
        data: {"email":email}
    }).success(function(data){
        if(data["status"]=="not_found"){
            $("#err").html('<div class="alert alert-danger">邮箱尚未注册！</div>')
        }
        if(data["status"]=="found"){
            window.location='/home'
            alert("我们已将密码修改链接发送至您的注册邮箱，请查收")
        }
    })
}

function enter_user_login(event){
    if(event.keyCode==13)
    {
        document.getElementById("user_login").click();
    }
}

function enter_user_register(event){
    if(event.keyCode==13)
    {
        document.getElementById("user_register").click();
    }
}

function clear_user_register_form(){
    document.getElementById("name").value='';
    document.getElementById("password").value='';
    document.getElementById("password_confirmation").value='';
    document.getElementById("email").value='';
    $("#sign_err").addClass('hidden');
    $("#email_err").addClass('hidden');
    $("#blank_err").addClass('hidden');
    $("#confirm_err").addClass('hidden');
    $("#format_err").addClass('hidden');
}

function clear_user_login_form(){
    document.getElementById("login_name").value='';
    document.getElementById("login_password").value='';
    $("#err").html('')
}

function enter_recover_password(event){
    if(event.keyCode==13){
        document.getElementById("recover_password").click();
    }
}

function check_merchant_info() {
    user_name = document.getElementById("user_name").value;
    restaurant_name = document.getElementById("restaurant_name").value;
    password = document.getElementById("password").value;
    password_confirmation = document.getElementById("password_confirmation").value;
    email = document.getElementById("email").value;
    phone = document.getElementById("phone").value;
    if (!user_name || !restaurant_name || !password || !password_confirmation || !email || !phone) {
        $("#err").html("<div class='alert alert-danger'>请将信息填写完整！</div>")
        return
    }
    if (password != password_confirmation) {
        $("#err").html("<div class='alert alert-danger'>密码输入不一致！</div>")
        return
    }
    if (email.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) == -1) {
        $("#err").html("<div class='alert alert-danger'>邮箱格式不正确！</div>")
        return
    }
    merchant = {"user_name": user_name, "restaurant_name": restaurant_name, "password": password, "password_confirmation": password_confirmation, "email": email, "phone": phone}
    $.ajax({
        type: "POST",
        url: "/new_merchant",
        data: {"merchant": merchant}
    }).success(function () {
        window.location = '/submit_success'
    })
}

function post_new_user(){
    var  name=document.getElementById("name").value;
    var   password=document.getElementById("password").value;
    var   password_confirmation=document.getElementById("password_confirmation").value;
    var  email=document.getElementById("email").value;
    if (!name ||!password||!password_confirmation||!email){
        $("#blank_err").removeClass("hidden")
        $("#confirm_err").addClass("hidden");
        $("#sign_err").addClass("hidden");
        $("#email_err").addClass("hidden");
        $("#format_err").addClass("hidden");
        return
    }
    if (password!=password_confirmation){
        $("#confirm_err").removeClass("hidden");
        $("#blank_err").addClass("hidden");
        $("#sign_err").addClass("hidden");
        $("#format_err").addClass("hidden");
        $("#email_err").addClass("hidden");
        return
    }
    if(email.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) == -1){
        $("#format_err").removeClass("hidden");
        $("#confirm_err").addClass("hidden");
        $("#blank_err").addClass("hidden");
        $("#sign_err").addClass("hidden");
        $("#email_err").addClass("hidden");
        return
    }
    user={"name":name,"password":password,"password_confirmation":password_confirmation,"email":email}
    $.ajax({
        type: "POST",
        url: "/new_user",
        data: {"user":user}
    }).success(function(back){
        if(back["data"]=="name_repeated"){
            $("#sign_err").removeClass("hidden");
            $("#format_err").addClass("hidden");
            $("#confirm_err").addClass("hidden");
            $("#blank_err").addClass("hidden");
            $("#email_err").addClass("hidden");
            return
        }
        if (back["data"]=="email_repeated"){
            $("#sign_err").addClass("hidden");
            $("#format_err").addClass("hidden");
            $("#confirm_err").addClass("hidden");
            $("#blank_err").addClass("hidden");
            $("#email_err").removeClass("hidden");
            return
        }
        window.location='/home'
        alert("我们已经发送了一封包含激活链接的邮件到您的注册邮箱，去邮箱激活用户。")
    })
}
//
function submit_review(data){
    if(!$(data).attr('rel')){
        clear_user_login_form();
        $("#login_modal").modal("show");
        return
    }
    var user_name=JSON.parse(JSON.stringify($(data).attr('rel')));
    var merchant_name=JSON.parse(JSON.stringify($(data).attr('rel1')));

    var comment=$('#comment').val()  ;

    if(comment!=""){
        var user_comment={
            merchant_name:merchant_name,
            user_name:user_name,
            comment:comment
        };
        $.ajax({
            type: "POST",
            url: "/new_comment",
            data: {"comment":user_comment}
        }).success(function(data){
            if(data["data"]){
                localStorage.setItem("top","to_top")
                location.reload();

            }else{
                alert("连接服务器失败，请重新提交！")
            }
        })

    }else{
        alert("请输入评论内容！")

    }
}

function to_top(){
    if(localStorage.getItem("top")=="to_top"){
      $("#jump")[0].click();
        localStorage.setItem("top","not_top")
    }
}