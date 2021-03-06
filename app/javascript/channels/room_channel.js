import consumer from "./consumer"

document.addEventListener('DOMContentLoaded',function(){
consumer.subscriptions.create({ channel: "RoomChannel", room: document.getElementById('message-container').dataset.room}, {
  connected() {
    console.log('connected')
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    if(data['join_notice']){
      $('.message-list').append(data['join_notice']);
      setTimeout(function(){
        $('.join-notice').remove();
      },3000);
      return;
    }else if(data['exit_notice']){
      $('.message-list').append(data['exit_notice']);
      setTimeout(function(){
        $('.exit-notice').remove();
      },3000);
      return;
    }
    console.log('received');
    const template = data['message'];
    const imageInput = document.getElementById('message_image');
    const messageContainer = document.getElementById('message-container');
    const inputform = document.getElementById('message_content');

    messageContainer.insertAdjacentHTML('beforeend',template);
    inputform.value = "";
    imageInput.value = "";

    const messageList = $('.message-list');
    $('.main').animate({scrollTop: messageList[0].scrollHeight},300);
  }
});
});
