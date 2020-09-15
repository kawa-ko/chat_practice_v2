document.addEventListener('DOMContentLoaded',function(){
    const submitBtn = $('.submit');
    const textArea = $('.auto-resize');
    const textareaDummy = $('.textarea-dummy');
    const messageInput = $('.message-input');
    const imageInput = $('#message_image')
    const previewArea = $('#image-preview');
    const formArea = $('.form-area');
    const messageList = document.querySelector('.message-list');
    const main = document.querySelector('.main');
    
    main.scrollTop = messageList.scrollHeight;

    //フォームの高さが画面最上部に達したら高さを指定し、スクロールできるようにするためのファンクション
    const setFormAreaHeight = function(){
    const mainAreaHeight = $('body').height()-$('.room-header').innerHeight();
    if(formArea.innerHeight() >= mainAreaHeight){
        formArea.css({
         'height':mainAreaHeight,
         'overflow':'auto' 
        });
        console.log('maximum!');
        }
    }

    //画像ファイルを選択したら、テクストエリアのその画像の高さの分だけテキストエリアを大きくし、画像のプレビューを表示する。
    imageInput.change(function(e){
      const reader = new FileReader;
      const file = e.target.files;

      reader.readAsDataURL(file[0]);
      reader.onload = function(){
        const previewImage = reader.result;
        previewArea.attr('src',previewImage);
        messageInput.css({'height':'auto'});
        $('.image-preview-area').fadeIn().addClass('show');
        previewArea.on('load',function(){
            setFormAreaHeight();
            formArea.animate({scrollTop: formArea[0].scrollHeight},300);
        });
      }
    });

    //送信ボタンがクリックされた時の処理
    submitBtn.click(function(){
      console.log('submit');
      //空の場合アラートを表示
      if(textArea.value === ""){
        alert('メッセージを入力してください');
      }

      //フォームエリアの大きさが画面最上部に達していたら
      //フォームエリアのheightとoverflowを変更する。
      formArea.css({
       'height':'auto',
       'overflow':'hidden'
      });

      //40px以上の場合（改行したとき、字数が多い時など）は
      //テクストエリアの高さを40pxに戻す。
      //(画像があった場合、room_cahnnel.jsの方で削除する。
      //ここで削除すると、パラメーターに画像が入らない
      if(textareaDummy.height() > 40){
     　　textareaDummy.animate({'height':40},300);
     　　$('.image-preview-area').fadeOut().addClass('show');
      }

      //画像のプレビューが表示してあった場合それを消す。
      if($('.image-preview-area').hasClass('show')){
        $('.image-preview-area').fadeOut().removeClass('show');
      }

    });

    //テクストエリアに入力した文字数が多くなったら自動で高さを変える。
    textArea.on('keydown',function(){
　　   if(textareaDummy.height() <= 40){
        textareaDummy.css('height','auto');
       }
       textareaDummy.text(textArea.val());
       setFormAreaHeight();
    });

    //画像のプレビューを消した時の処理
    $('#image-preview').on('load',function(){
      $('.close').click(function(){
        console.log('close');
        formArea.css({
          'height':'auto',
          'overflow':'hidden'
        });
   
        $('.image-preview-area').fadeOut().removeClass('show');
        imageInput.val("");
      });
    });

});