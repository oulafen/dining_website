// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(function () {
    $(".sort_paginate_ajax th a, .sort_paginate_ajax .pagination a").bind("click", function () {
        update_present_choose();
        $.getScript(this.href);
        return false;
    });
});

function update_present_choose() {
    var choose_label = $("[disabled='disabled']");
    var choose_labels = JSON.parse(localStorage.getItem('choose_labels')) || [];
    var post_data = JSON.parse(localStorage.getItem('post_data')) || [];
    for (var i = 0; i < choose_label.length; i++) {
        var id_label = choose_label[i].id.substring(0, 3);
        var id_num = choose_label[i].id.substring(3) ;
        var is_find = false;
        for (var j = 0; j < choose_labels.length; j++) {
            var choose_label_id = choose_labels[j].label_id;
            if (id_label == 'add' && choose_label_id == id_num && !isNaN(id_num)) {
                is_find = true;
            }
        }
        if (id_label == 'add' && !is_find && !isNaN(id_num)) {
            var label = {};
            label.label_id = id_num;
            label.content = $("#content" + id_num).text();
            choose_labels.push(label);
            post_data.push(id_num);
        }
        var cancel_id_num = id_num.substring(3);
        if(id_label == 'can' && !isNaN(cancel_id_num) ){
            for(var m=0;m<post_data.length;m++){
                if(post_data[m]==cancel_id_num){
                    var id_index ;
                    if(!post_data.indexOf){
                        for(var n=0;n<post_data.length;n++){
                            if(post_data[n]==cancel_id_num){
                                id_index = n;
                                break;
                            }
                        }
                    }else{
                        id_index = post_data.indexOf(cancel_id_num);
                    }
                    post_data.splice(id_index,1);
                    choose_labels.splice(id_index,1);
                    m-=1;
                }
            }
        }
    }
    localStorage.setItem('choose_labels', JSON.stringify(choose_labels));
    localStorage.setItem('post_data', JSON.stringify(post_data));
}

function set_labels_status() {
    var labels = $('#labels').attr('rel');
    var merchant_labels = JSON.parse(localStorage.getItem('choose_labels')) ;
    if (labels[0] && !merchant_labels) {
        merchant_labels = JSON.parse(labels.replace(/=>/g, ':'));
        var post_data = [];
        for(var i= 0;i<merchant_labels.length;i++){
            post_data.push(merchant_labels[i].label_id);
        }
        localStorage.setItem('choose_labels',JSON.stringify(merchant_labels));
        localStorage.setItem('post_data',JSON.stringify(post_data));
    }
    for (var i = 0; i < merchant_labels.length; i++) {
        $('#add' + merchant_labels[i].label_id).attr('name', 'add').attr('disabled', 'disabled').css('color', '#8e8e8e');
        $('#cancel' + merchant_labels[i].label_id).attr('name', 'cancel').removeAttr('disabled').css('color', '#2828FF');
    }
}

function reload_image(btn_id,image_input_id,show_image_input_id) {
    $('#'+image_input_id).hide();
    $('#'+btn_id).click(function () {
        $('#'+image_input_id).click();
    });
    $('#'+image_input_id).change(function () {
        var logo_type = $("#"+image_input_id)[0].files[0].type;
        if (logo_type == "image/jpeg" || logo_type == "image/png" || logo_type == "image/gif") {
            $('#'+show_image_input_id).attr('value', $('#'+image_input_id).val());
        } else {
            alert('请选择格式为.jpg .png .gif的文件');
        }
    });
}
