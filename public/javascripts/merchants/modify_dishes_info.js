$(document).ready(function(){
    set_dish_submit_status();
    reload_image("overlook","logo_input","show_logo_input");
    $('.pagination a').attr('data-remote', 'true');
    clear_localstorage();
    show_postcode();
    init_choose_labels_status();
});