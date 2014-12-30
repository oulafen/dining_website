function modify_password(){
    if(navigator.appName.indexOf('Explorer')>-1){
        var  name=document.getElementById("m_name").innerText;
    }
    else{
        var   name=document.getElementById("m_name").textContent;
    }
    var  password=document.getElementById("m_password").value;
    var  password_confirmation=document.getElementById("m_password_confirmation").value
    if(!password||!password_confirmation){
        $("#m_err").html('<div class="alert alert-danger">请输入完整信息！</div>');
        return
    }
    if(password!=password_confirmation){
        $("#m_err").html('<div class="alert alert-danger">两次密码输入不一致！</div>');
        return
    }
    user={"name":name,"password":password,"password_confirmation":password_confirmation}
    $.ajax({
        type: "POST",
        url: "/new_password",
        data: {"user":user}
    }).success(function(){
        window.location='/home'
    })
}