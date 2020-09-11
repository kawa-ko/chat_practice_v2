import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    console.log('connected')
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
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
