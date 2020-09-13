$(function(){
   const submitBtn = $('.submit');
   const textArea = $('.auto-resize');
   const textareaDummy = $('.textarea-dummy');
   const messageInput = $('.message-input');
   const imageInput = $('#message_image')
   const previewArea = $('#image-preview');
   const formArea = $('.form-area');

   //ハンバーガーメニューの処理
   const hamburger = $('.sp-hamburger');
   hamburger.click(function(){
       console.log('click');
       if($(this).hasClass('open')){
           $(this).removeClass('open');
           $('.sp-menu').removeClass('show');
       }else{
           $(this).addClass('open');
           $('.sp-menu').addClass('show');
       }
   });

});