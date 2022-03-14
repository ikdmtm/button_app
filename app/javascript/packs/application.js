// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//= require jquery3
//= require popper
//= require bootstrap-sprockets

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("jquery")

document.addEventListener('turbolinks:load', () => {
  $(function() {
      console.log("OK");
      //デバイス判定（タッチが有効か否か）
      var isTouchDevice = (('ontouchstart' in window) || window.DocumentTouch && document instanceof DocumentTouch);
      //デバイス判定によるイベントの決定
      var eventType = (isTouchDevice) ? 'touchend' : 'click';

      $('button').on(eventType, function(){
          console.log('on');
          var postid = $(this).data('id')
          console.log(postid)
          document.querySelector("#play-button-" + postid).currentTime = 0;
          document.querySelector("#play-button-" + postid).play()
        });
  });
})
