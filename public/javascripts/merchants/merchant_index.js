$(document).ready(function(){
    add_new_address();
    change_to_chinese_num();
    reload_image("overlook","logo_input","show_logo_input");
    $('.pagination a').attr('data-remote', 'true');
    clear_localstorage();
    init_choose_labels_status();
    show_postcode();
    change_labels_block()
});