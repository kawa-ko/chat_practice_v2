$(function(){
    $('.flash-close').click(function(){
        $('.flash').fadeOut();
    });
    setTimeout(function(){
        $('.flash').remove();
    },4010);
});