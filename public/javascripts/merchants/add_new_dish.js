$(document).ready(function(){
    set_dish_submit_status();
    reload_image("overlook","logo_input","show_logo_input");
    $('.pagination a').attr('data-remote', 'true');
    clear_localstorage();
//    function init_choose_labels_status() {
//        $("#dish_style").click(function(){
//            $(this).addClass("label_block_clicked");
//            $("#dish_style_block").addClass("selected");
//            $("#dish_style_labels").removeClass("hidden");
//
//            $("#taste_block").removeClass("selected");
//            $("#taste").removeClass('label_block_clicked');
//            $("#taste_labels").addClass("hidden");
//        });
//        $("#taste").click(function(){
//            $(this).addClass("label_block_clicked");
//            $("#taste_block").addClass("selected");
//            $("#taste_labels").removeClass("hidden");
//
//            $("#dish_style_block").removeClass("selected");
//            $("#dish_style").removeClass('label_block_clicked');
//            $("#dish_style_labels").addClass("hidden");
//        });
//    };
    init_choose_labels_status();
    show_postcode();
    change_labels_block()

})