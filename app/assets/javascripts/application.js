// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require_tree .

var tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

let player;
function onYouTubeIframeAPIReady() {
  // 縦：横 ＝ 9:16
  player = new YT.Player('thumbnail', {
    height: '270',
    width: '480',
    events: {
      // プレイヤーが生成されたら、動画IDを設定する
      'onReady': setVideoId
    }
  });
}

// 動画IDの設定
function setVideoId(event) {
  if($("#movie_url").val() !== ""){
    // 動画URLから動画のIDを取得
    let url = $("#movie_url").val();
    let id = url.match(/v=.*/)[0].substring(2,13);

    // 動画のIDを設定
    event.target.cueVideoById({videoId: id});
  }
}
