$(window).ready(function(){
    $(window).bind("resize", footer_at_bottom);
    function footer_at_bottom() {
        $(".content").css("min-height", $(window).height() - 168);
    }
    footer_at_bottom();
    if (navigator.appName=='Microsoft Internet Explorer' && navigator.appVersion==10){
        $("#ie_margin").addClass('margin_bottom_18')
    }
});