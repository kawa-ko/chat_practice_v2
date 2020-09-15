$(function(){

   //ハンバーガーメニューの処理
   const hamburger = $('.sp-hamburger');
   hamburger.click(function(){
       if($(this).hasClass('open')){
           $(this).removeClass('open');
           $('.sp-menu').removeClass('show');
       }else{
           $(this).addClass('open');
           $('.sp-menu').addClass('show');
       }
   });

});