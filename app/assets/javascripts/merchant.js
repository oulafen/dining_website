function add_new_address() {
    $('#add_new_address').click(function () {
        $('#add_address_after').html('<div class="row login_row_1">'
            + '<div class="col-xs-3 add-on-1">新地址：</div>'
            + '<div class="col-xs-4"><input class="form-control height" id="new_addr_input" name="addr[address]" type="text"></div>'
            + '<div class="col-xs-1"></div></div>'
            + '<div class="row login_row_1">'
            + '<div class="col-xs-3 add-on-1">新联系方式：</div>'
            + '<div class="col-xs-3"><input class="form-control height"  name="addr[phone]" type="text"></div>'
            + '</div><div class="row login_row_1" id="confirm_div">'
            + '<div class="col-xs-1" style="margin-left:180px">'
            + '<input class="btn" id="new_addr_submit" name="commit" type="submit" value="确认"></div>'
            + '<div class="col-xs-1"><a class="btn btn_1" href="/merchant/merchant_index">取消</a></div></div>')

        $('#add_new_address').attr("disabled", "disabled");
        $('#new_addr_submit').attr("disabled", "disabled");
        set_new_addr_submit_button_status();
    });
    set_add_address_button_status();
}

function set_new_addr_submit_button_status() {
    $('#new_addr_input').keyup(function () {
        if ($(this).val() && $('#address_1_input').val()) {
            $('#new_addr_submit').removeAttr("disabled");
        } else {
            $('#new_addr_submit').attr("disabled", "disabled");
        }
    })
}

function show_update_success() {
    $('#change_success').show(400);
    $('#close').click(function () {
        $('#change_success').hide(400)
    });
}

function NumToChinese(num) {
//    if (!/^\d*(\.\d*)?$/.test(num)) { alert("Number is wrong!"); return "Number is wrong!"; }
    var AA = new Array("零", "一", "二", "三", "四", "五", "六", "七", "八", "九");
    var BB = new Array("", "十", "百", "千", "万", "亿", "点", "");
    var a = ("" + num).replace(/(^0*)/g, "").split("."), k = 0, re = "";
    for (var i = a[0].length - 1; i >= 0; i--) {
        switch (k) {
            case 0:
                re = BB[7] + re;
                break;
            case 4:
                if (!new RegExp("0{4}\\d{" + (a[0].length - i - 1) + "}$").test(a[0]))
                    re = BB[4] + re;
                break;
            case 8:
                re = BB[5] + re;
                BB[7] = BB[5];
                k = 0;
                break;
        }
        if (k % 4 == 2 && a[0].charAt(i + 2) != 0 && a[0].charAt(i + 1) == 0) re = AA[0] + re;
        if (a[0].charAt(i) != 0) re = AA[a[0].charAt(i)] + BB[k % 4] + re;
        k++;
    }

    if (a.length > 1) //加上小数部分(如果有小数部分)
    {
        re += BB[6];
        for (var i = 0; i < a[1].length; i++) re += AA[a[1].charAt(i)];
    }
    return re;
}

function set_add_address_button_status() {
    if (!$('#address_1_input').val()) {
        $('#add_new_address').attr("disabled", "disabled");
    }
    $('#address_1_input').keyup(function () {
        if ($(this).val() && $('#new_addr_input').val() == undefined) {
            $("#add_new_address").removeAttr("disabled")
        } else {
            if (!$(this).val() || $('#new_addr_input').val() != undefined) {
                $('#add_new_address').attr("disabled", "disabled");
                $('#new_addr_submit').attr("disabled", "disabled");
            }
            if ($(this).val() && $('#new_addr_input').val()) {
                $("#new_addr_submit").removeAttr("disabled")
            } else {
                $('#add_new_address').attr("disabled", "disabled");
            }
        }
    })
}

function change(btn) {
    var id = $(btn).attr('id');
    if ($(btn).attr('disabled') == undefined) {
        if (id.substring(0, 3) == 'add') {
            $('#cancel' + id.substring(3)).removeAttr('disabled').css('color', '#2828FF');
        }
        if (id.substring(0, 6) == 'cancel') {
            $('#add' + id.substring(6)).removeAttr('disabled').css('color', '#2828FF');
        }
        $(btn).attr('disabled', 'disabled').css('color', '#8E8E8E');
    }
}

function label_choose_submit() {
    update_present_choose();
    $("#labels_content").html('');
    var choose_labels = JSON.parse(localStorage.getItem('choose_labels'));
    var post_data = [];
    if (!choose_labels[0]) {
        var choose_label = $("[disabled='disabled']");
        for (var i = 0; i < choose_label.length; i++) {
            var id = choose_label[i].id;
            if (id.substring(0, 3) == 'add' && !isNaN(id.substring(3))) {
                $("#labels_content").append('<div class="btn btn_2" disabled="disabled"><div class="h4">' + $("#content" + id.substring(3)).text() + ' </div></div>&nbsp');
                post_data.push(id.substring(3));
            }
        }
    }
    if (choose_labels[0]) {
        post_data = JSON.parse(localStorage.getItem('post_data'));
        for (var i = 0; i < choose_labels.length; i++) {
            $("#labels_content").append('<div class="btn btn_2" disabled="disabled"><div class="h4">' + choose_labels[i].content + ' </div></div>&nbsp');
        }
    }
    var container_id = $('.container')[0].id;
    var post_url = '';
    if (container_id == 'merchant_label') {
        post_url = "/merchant/update_merchant_labels";
    }
    if (container_id == 'add_dish_label') {
        post_url = "/merchant/save_add_dish_labels";
    }
    if (container_id == 'modify_dish_label') {
        post_url = "/merchant/update_modify_dish_labels";
    }
    $.ajax({
        type: "POST",
        url: post_url,
        data: {'choose_label_ids': post_data}
    }).success(function () {
        $("#present_index").attr('class', '');
        $("#label_choose").attr('class', 'hidden');
    });
}

function set_dish_submit_status() {
    if (!$('#dish_name').val() || !$('#dish_price').val()) {
        $('#dish_submit').attr("disabled", "disabled");
    }
    if ($('#dish_name').val() && $('#dish_price').val()) {
        $('#dish_submit').removeAttr("disabled");
    }
    $('#dish_name').keyup(function () {
        if ($(this).val() && $('#dish_price').val() && !isNaN(JSON.parse($('#dish_price').val()))) {
            $('#dish_submit').removeAttr("disabled");
        } else {
            $('#dish_submit').attr("disabled", "disabled");
        }
    });
    $('#dish_price').keyup(function () {
        if ($(this).val() && $('#dish_name').val() && !isNaN(JSON.parse($('#dish_price').val()))) {
            $('#dish_submit').removeAttr("disabled");
        } else {
            $('#dish_submit').attr("disabled", "disabled");
        }
    });
}

function change_to_chinese_num() {
    var span = $("span");
    for (var i = 0; i < span.length; i++) {
        var text = span[i].innerText;
        var num = span[i].innerText.replace(/[^0-9]/ig, "");
        var chinese_num = NumToChinese(num);
        if (text[0] == '地') {
            span[i].innerText = '地址' + chinese_num + '：'
        }
        if (text[0] == '联') {
            span[i].innerText = '联系方式' + chinese_num + '：'
        }
    }
}

function show_more_labels() {

    set_labels_status();
    $("#present_index").attr('class', 'hidden');
    $("#label_choose").attr('class', '');
    $("#footer").addClass("hidden");
    $(window).ready(function () {
        $(window).bind("resize", footer_at_bottom);
        function footer_at_bottom() {
            $(".content").css("min-height", $(window).height());
        }

        footer_at_bottom();
    });
}

function cancel_more_labels() {
    clear_localstorage();
    $("#present_index").attr('class', '');
    $("#label_choose").attr('class', 'hidden');
}

function clear_localstorage() {
    localStorage.removeItem('post_data');
    localStorage.removeItem('choose_labels');
}

function init_choose_labels_status() {
    function show_dish_style_labels(){
        $("#dish_style").addClass("label_block_clicked");
        $("#dish_style_block").addClass("selected");
        $("#dish_style_labels").removeClass("hidden");

        $("#site_block").removeClass("selected");
        $("#site").removeClass('label_block_clicked');
        $("#site_labels").addClass("hidden");

        $("#taste_block").removeClass("selected");
        $("#taste").removeClass('label_block_clicked');
        $("#taste_labels").addClass("hidden");
    }
    function show_site_labels(){
        $("#site").addClass("label_block_clicked");
        $("#site_block").addClass("selected");
        $("#site_labels").removeClass("hidden");

        $("#dish_style_block").removeClass("selected");
        $("#dish_style").removeClass('label_block_clicked');
        $("#dish_style_labels").addClass("hidden");

        $("#taste_block").removeClass("selected");
        $("#taste").removeClass('label_block_clicked');
        $("#taste_labels").addClass("hidden");
    }
    function show_taste_labels(){
        $("#taste").addClass("label_block_clicked");
        $("#taste_block").addClass("selected");
        $("#taste_labels").removeClass("hidden");

        $("#dish_style_block").removeClass("selected");
        $("#dish_style").removeClass('label_block_clicked');
        $("#dish_style_labels").addClass("hidden");

        $("#site_block").removeClass("selected");
        $("#site").removeClass('label_block_clicked');
        $("#site_labels").addClass("hidden");
    }
    $("#dish_style").click(function () {
        if ((!$('#site_labels').is(':hidden')) ) {
            if($('#site_paginate a').length !=0){
                $('#site_paginate a')[1].click();
                setTimeout(function(){
                    show_dish_style_labels();
                },1000)
            }else{
                show_dish_style_labels();
            }
        }
        if ((!$('#dish_style_labels').is(':hidden')) ) {
            if($('#dish_style_paginate a').length !=0){
                $('#dish_style_paginate a')[1].click();
                setTimeout(function(){
                    show_dish_style_labels();
                },1000)
            }else{
                show_dish_style_labels();
            }

        }
        if ((!$('#taste_labels').is(':hidden')) ) {
            if($('#taste_paginate a').length !=0){
                $('#taste_paginate a')[1].click();
                setTimeout(function(){
                    show_dish_style_labels();
                },1000)
            }else{
                show_dish_style_labels();
            }

        }
    });
    $("#site").click(function () {
        if ((!$('#site_labels').is(':hidden')) ) {
            if($('#site_paginate a').length !=0){
                $('#site_paginate a')[1].click();
                setTimeout(function(){
                    show_site_labels();
                },1000)
            }else{
                show_site_labels();
            }
        }
        if ((!$('#dish_style_labels').is(':hidden')) ) {
            if($('#dish_style_paginate a').length !=0){
                $('#dish_style_paginate a')[1].click();
                setTimeout(function(){
                    show_site_labels();
                },1000)
            }else{
                show_site_labels();
            }

        }
        if ((!$('#taste_labels').is(':hidden')) ) {
            if($('#taste_paginate a').length !=0){
                $('#taste_paginate a')[1].click();
                setTimeout(function(){
                    show_site_labels();
                },1000)
            }else{
                show_site_labels();
            }

        }
    });
    $("#taste").click(function () {
        if ((!$('#site_labels').is(':hidden')) ) {
            if($('#site_paginate a').length !=0){
                $('#site_paginate a')[1].click();
                setTimeout(function(){
                    show_taste_labels();
                },1000)
            }else{
                show_taste_labels();
            }
        }
        if ((!$('#dish_style_labels').is(':hidden')) ) {
            if($('#dish_style_paginate a').length !=0){
                $('#dish_style_paginate a')[1].click();
                setTimeout(function(){
                    show_taste_labels();
                },1000)
            }else{
                show_taste_labels();
            }

        }
        if ((!$('#taste_labels').is(':hidden')) ) {
            if($('#taste_paginate a').length !=0){
                $('#taste_paginate a')[1].click();
                setTimeout(function(){
                    show_taste_labels();
                },1000)
            }else{
                show_taste_labels();
            }

        }
    });
}

function change_labels_block() {
    $("#taste_paginate a").click(function () {
        function change_to_taste_labels() {
            $("#site_labels").addClass("hidden");
            $("#dish_style_labels").addClass("hidden");
            $("#taste_labels").removeClass("hidden");
            change_labels_block()
        }

        setTimeout(function () {
            change_to_taste_labels()
        }, 1000);
    })
    $("#dish_style_paginate a").click(function () {
        function change_to_taste_labels() {
            $("#site_labels").addClass("hidden");
            $("#taste_labels").addClass("hidden");
            $("#dish_style_labels").removeClass("hidden");
            change_labels_block()
        }

        setTimeout(function () {
            change_to_taste_labels()
        }, 1000);
    })
}

function add_new_merchant_label(merchant) {
    var content = document.getElementById("content").value;
    var postcode = document.getElementById("postcode_input").value;
    var category_id = $("input[name='category']:checked").val()
    if (!content || !category_id) {
        alert("请输入完整信息")
    }
    else {
        if (category_id == 1) {
            if (!postcode) {
                post_data = {"content": content, "user_name": merchant, "category_id": category_id, "category": "位置类"}
            }
            else {
                post_data = {"content": content + "-" + postcode, "site": content, "postcode": postcode, "user_name": merchant, "category_id": category_id, "category": "位置类"}
            }
        }
        else {
            if (category_id == 2) {
                category = "菜系类"
            }
            if (category_id == 3) {
                category = "口味类"
            }
            post_data = {"content": content, "category_id": category_id, "user_name": merchant, "category": category}
        }
        $.ajax({
            type: "POST",
            url: "/merchant/new_label",
            data: {'label': post_data}
        }).success(function (data) {
            document.getElementById("content").value = '';
            document.getElementById("postcode_input").value = '';
            if (data["repeated"] == "true") {
                alert("标签已存在！")
                return
            }
            update_present_choose()
            if (category_id == 1) {
                $("#site_labels").load("merchant_index.html #site_labels", function () {
                    set_status();
                });
            }
            if (category_id == 2) {
                $("#dish_style_labels").load("merchant_index.html #dish_style_labels_show", function () {
                    set_status();
                });
            }
            if (category_id == 3) {
                $("#taste_labels").load("merchant_index.html #taste_labels_show", function () {
                    set_status()
                });
            }
            function set_status() {
                var merchant_labels = JSON.parse(localStorage.getItem('choose_labels'));
                for (var i = 0; i < merchant_labels.length; i++) {
                    $('#add' + merchant_labels[i].label_id).attr('name', 'add').attr('disabled', 'disabled').css('color', '#8e8e8e');
                    $('#cancel' + merchant_labels[i].label_id).attr('name', 'cancel').removeAttr('disabled').css('color', '#2828FF');
                }
            }
        })
    }
}


