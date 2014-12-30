function delete_label(btn) {
    var label_id = $(btn).attr('id'),
        label_content = $(btn).attr('rel'),
        category =$(btn).attr('name');
    if(category=="位置类"){
        current_url="/admin/label_site_list"
    }
    if(category=="菜系类"){
        current_url="/admin/label_dish_style_list"
    }
    if(category=="口味类"){
        current_url="/admin/label_flavour_list"
    }
    if (confirm("确定要删除 '" + label_content + "' 吗?")) {
        $.ajax({
            type: "POST",
            url: "/admin/delete_label",
            data: {'delete_label_id': label_id}
        }).success(function () {
                window.location = current_url;
            });
    }
}

function delete_roll_image(btn) {
    var roll_order = $(btn).attr("rel"),
        current_url = window.location.href;
    if (confirm("确定要删除第 " + roll_order + " 张图片吗?")) {
        $.ajax({
            type: "POST",
            url: "/admin/delete_roll_image",
            data: {'delete_roll_order': roll_order}
        }).success(function () {
                window.location.href = current_url;
            });
    }
}

function set_switch_in_admin_index(){
    $("#checking").click(function(){
        $(this).addClass("label_block_clicked");
        $("#checking_block").addClass("selected");
        $("#checked").removeClass("label_block_clicked");
        $("#checked_block").removeClass("selected");
        $("#checked_merchants").addClass("hidden");
        $("#checking_merchants").removeClass("hidden")
        $("#checking_merchants").load("admin_index.haml #checking_merchants_block" )
    })
    $("#checked").click(function(){
        $(this).addClass("label_block_clicked");
        $("#checked_block").addClass("selected");
        $("#checking").removeClass("label_block_clicked");
        $("#checking_block").removeClass("selected");
        $("#checked_merchants").removeClass("hidden");
        $("#checking_merchants").addClass("hidden")
    })
}

function show_postcode(){
    $("#label_category_id1_value_rellabel_site_list").click(function(){
        $("#postcode").removeClass('hidden')
    });
    $("#label_category_id2_value_rellabel_dish_style_list").click(function(){
        $("#postcode").addClass('hidden')
    });
    $("#label_category_id3_value_rellabel_flavour_list").click(function(){
        $("#postcode").addClass('hidden')
    });
}

function pass_check(btn){
    $.ajax({
        type: "POST",
        url: "/admin/pass_check",
        data: {"user_name":$(btn).attr("id")}
    }).success(function(back){
        $("#checked_merchants").load("admin_index.haml #checked_merchants");
        $("#checking_merchants").load("admin_index.haml #checking_merchants_block")
        $.ajax({
            type: "POST",
            url: "/admin/send_pass_check_email",
            data: {"email":back["email"]}
        })
    })
}

function save_about_us_text(){
    var about_us=$('#editor').html()
    $.ajax({
        type: 'POST',
        url: '/admin/save_about_us',
        data: {"about_us":about_us}
    }).success(function(){
        setTimeout($('#change_success').removeClass('hidden'),200);
        setTimeout(function(){window.location.href = '/admin/set_about_us';},2000);
    })
}

function save_privacy_security_text(){
    var privacy_security=$('#editor').html()
    $.ajax({
        type: 'POST',
        url: '/admin/save_privacy_security',
        data: {"privacy_security":privacy_security}
    }).success(function(){
        setTimeout($('#change_success').removeClass('hidden'),200);
        setTimeout(function(){window.location.href = '/admin/set_privacy_security';},2000);
    })
}

function save_terms_conditions_text(){
    var terms_conditions=$('#editor').html()
    $.ajax({
        type: 'POST',
        url: '/admin/save_terms_conditions',
        data: {"terms_conditions":terms_conditions}
    }).success(function(){
        setTimeout($('#change_success').removeClass('hidden'),200);
        setTimeout(function(){window.location.href = '/admin/set_terms_conditions';},2000);
    })
}