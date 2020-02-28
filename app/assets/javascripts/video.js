$(function(){

  // 検索結果表示エリア
  var result = $(".result")

  // 非同期で検索処理
  function search_video(){

    // 区分
    category = "";
    if($('input[name="category"]:checked').val() == "stage"){
      category = "ステージ";
    }else if($('input[name="category"]:checked').val() == "close"){
      category = "クロース";
    }else if($('input[name="category"]:checked').val() == "juggling"){
      category = "ジャグ";
    }

    // 学生/プロアマ
    performer_status = "";
    if($('#performer_status_student').prop("checked") == true && $('#performer_status_proama').prop("checked") == true){
      performer_status = "";
    }else if($('#performer_status_student').prop("checked") == true){
      performer_status = "学生";
    }else if($('#performer_status_proama').prop("checked") == true){
      performer_status = "プロ・アマ"
    }

    // Ajaxの設定
    $.ajax({
      url: "/videos/searches",
      type: "GET",
      data:{ 
        category: category,
        item: $('#item').val(),
        performer_status: performer_status,
        performer_name: $('#performer_name').val(),
        music_title: $('#music_title').val(),
        music_artist: $('#music_artist').val(),
        performed_at: $('#performed_at').val(),
        tags: $('#tags').val()
      },
      dataType: "json"
    })

    // 検索成功
    .done(function(videos){
      result.empty();
      if(videos.length != 0){
        videos.forEach(function(video){
          // 動画情報のhtml作成（1件）
          appendMovie(video);

          // 動画埋め込み処理

          // DB上の動画情報のid
          let videoId = video.id
          // 挿入先となるdivのid
          let playerId = "player_" + videoId;
          // youtubeの動画ID("v="以降の11桁)
          let youtubeId = video.url.match(/v=.*/)[0].substring(2,13);

          // プレイヤーの生成（１件）
          player = new YT.Player(
            playerId, {
              width: "320",
              height: "180",
              videoId: youtubeId
            }
          )
        });
      }
    })

    // 検索失敗
    .fail(function(){
      alert("検索エラー")
    })
  }

  // 動画情報１件分のhtml作成
  function appendMovie(video){
    // html作成
    var html = `<div class='result__video'>
                  <div class='result__video__thumbnail'>
                    <div id='player_${video.id}'>
                    </div>
                  </div>
                  <a href="/videos/${video.id}" class='result__video__show--link'>
                    <table class='result__video__information'>
                      <tr>
                        <th>区分</th>
                        <td>${video.category}</td>
                        <th>曲タイトル</th>
                        <td>${video.music_title}</td>
                      </tr>
                      <tr>
                        <th>種目・アイテム</th>
                        <td>${video.item}</td>
                        <th>アーティスト</th>
                        <td>${video.music_artist}</td>
                      </tr>
                      <tr>
                        <th>学生／プロ・アマ</th>
                        <td>${video.performer_status}</td>
                        <th>出演・受賞</th>
                        <td>${video.performed_at}</td>
                      </tr>
                      <tr>
                        <th>演者名</th>
                        <td> ${video.performer_name}</td>
                        <th>タグ</th>
                        <td>${video.tags}</td>
                      </tr>
                    </table>
                  </a>
                  <a href="/videos/${video.id}/edit" class='result__video__edit--link'>
                    <div class='result__video__edit-button'>
                      <i class="far fa-edit .result__video__edit-button__icon"></i>
                      編集
                    </div>
                  </a>
                </div>`

    // 検索結果表示エリアに追加
    result.append(html);
  }

  // 確認ダイアログ表示
  function confirm_dialog(message){
    var result = confirm(message);
    if( result ) {
      return true;
    }else{
      return false;
    }
  }

  // 検索エリアのアコーディオン
  $(".accordion-search").on("click", function(){

    // アイコン変更
    if ($(".search").css('display') == 'block') {
      // イベント発火時点で表示状態の場合、「開く」アイコンに変更
      $(".accordion-search").html('<i class=" fas fa-bars"></i>');
    } else {
      // イベント発火時点で非表示状態の場合、「閉じる」アイコン
      $(".accordion-search").html('<i class="fas fa-chevron-up"></i>');
    }
    // エリアの表示・非表示
    $(".search").slideToggle();
  })

  // 検索条件が変更されるたび動画検索する
  $('.search__form input').on("change", function(){
    search_video();
  })

  // サムネイル設定（new画面,show画面,edit画面）
  $("#video_url").on("blur", function(){

    if($(this).val() !== ""){
      // 動画URLから動画のIDを取得
      let url = $(this).val();
      let id = url.match(/v=.*/)[0].substring(2,13);

      // 動画のIDを設定
      player.cueVideoById({videoId: id});
    }
  })

  // 一覧から画面遷移する場合、検索条件を取得する
  $(document).on("click", ".header__add-video__btn,.result__video__show--link,.result__video__edit--link", function(){
    
    // 現在のページがindexの場合のみ（新規登録ボタンはindex以外でも使えるため）
    if($(".search").length && $(".result").length){

      // 検索フォームの状態を取得する
      let category = "";
      if($('input[name="category"]:checked').length){
        category = $('input[name="category"]:checked').val();
      }
      let item = $('#item').val();
      let performer_status_student = $('#performer_status_student').prop("checked");
      let performer_status_proama = $('#performer_status_proama').prop("checked");
      let performer_name = $('#performer_name').val();
      let music_title = $('#music_title').val();
      let music_artist = $('#music_artist').val();
      let performed_at = $('#performed_at').val();
      let tags = $('#tags').val();

      // パラメータの配列化
      let params_array = [
        `category=${category}`,
        `item=${item}`,
        `performer_status_student=${performer_status_student}`,
        `performer_status_proama=${performer_status_proama}`,
        `performer_name=${performer_name}`,
        `music_title=${music_title}`,
        `music_artist=${music_artist}`,
        `performed_at=${performed_at}`,
        `tags=${tags}`
      ];

      // リンク先にパラメータを追加する
      let params = '?' + params_array.join('&');
      $(this).attr("href", $(this).attr("href") + params)
    }
  })

  // 検索条件復元 & 動画プレイヤー埋め込み（APIの準備ができたら実行）
  window.onYouTubePlayerAPIReady = function() {
    // indexの場合、検索条件復元
    if($(".search").length && $(".result").length){

      // 区分ラジオボタン
      $('input[name="category"]').val([$("#category_hidden").val()]);

      // 種目
      $("#item").val($("#item_hidden").val());

      // 学生チェックボックス
      if($("#performer_status_student_hidden").val() == "true"){
        $("#performer_status_student").prop('checked', true);
      }

      // プロアマチェックボックス
      if($("#performer_status_proama_hidden").val() == "true"){
        $("#performer_status_proama").prop('checked', true);
      }

      // 演者名
      $("#performer_name").val($("#performer_name_hidden").val());

      // 曲名
      $("#music_title").val($("#music_title_hidden").val());

      // アーティスト
      $("#music_artist").val($("#music_artist_hidden").val());

      // 出演・受賞
      $("#performed_at").val($("#performed_at_hidden").val());

      // タグ
      $("#tags").val($("#tags_hidden").val());

      // 検索結果を取得
      let videos = $(".result__video")

      if(videos.length != 0){
        videos.each(function(){

          // 動画埋め込み処理

          // 動画情報のid
          let videoId = $(this).find("[id^='video_id_']").val()
          // 挿入先となるdivのid
          let playerId = "player_" + videoId;
          // youtubeの動画ID("v="以降の11桁)
          let youtubeId = $(this).find("[id^='video_url_']").val().match(/v=.*/)[0].substring(2,13);

          // プレイヤーの生成（１件）
          player = new YT.Player(
            playerId, {
              width: "320",
              height: "180",
              videoId: youtubeId
            }
          )
        });
      }
    };
  }

  // 警告メッセージ（newとeditのヘッダーボタン・戻るボタン）
  $(".header__index-link,"
    + ".header__internal__user__name,"
    + ".header__internal__user__sign-out,"
    + ".header__add-video__btn,"
    + ".edit__form__submits__back__btn,"
    + ".new__form__submits__back__btn").on("click", function(){

      // 確認ダイアログを表示
      let current = document.location.href
      if(current.match(/\/videos\/\d+\/edit/) || current.match(/\/videos\/new/)){
        return confirm_dialog('編集内容をキャンセルしてもよろしいですか？');
      }
  })

    // 登録確認ダイアログ
    $(".new__form__submits__create__btn").on("click", function(){
      return confirm_dialog('登録します。よろしいですか？');
    })

    // 更新確認ダイアログ
    $(".edit__form__submits__update__btn").on("click", function(){
      return confirm_dialog('更新します。よろしいですか？');
    })

    // 削除確認ダイアログ
    $(".edit__form__submits__delete__link").on("click", function(){
      return confirm_dialog('削除します。よろしいですか？');
    })
});
