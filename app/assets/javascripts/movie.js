$(function(){

  // 検索結果表示エリア
  var result = $(".result")

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

  // 動画情報１件分のhtml作成
  function appendMovie(movie){
    // html作成
    var html = `<div class='result__movie'>
                  <div class='result__movie__thumbnail'>
                    サムネイルがここに入ります
                  </div>
                  <a href="/movies/${movie.id}">
                    <table class='result__movie__information'>
                      <tr>
                        <th>区分</th>
                        <td>${movie.category}</td>
                        <th>曲タイトル</th>
                        <td>${movie.music_title}</td>
                      </tr>
                      <tr>
                        <th>種目・アイテム</th>
                        <td>${movie.item}</td>
                        <th>アーティスト</th>
                        <td>${movie.music_artist}</td>
                      </tr>
                      <tr>
                        <th>学生／プロ・アマ</th>
                        <td>${movie.performer_status}</td>
                        <th>出演・受賞</th>
                        <td>${movie.performed_at}</td>
                      </tr>
                      <tr>
                        <th>演者名</th>
                        <td> ${movie.performer_name}</td>
                        <th>タグ</th>
                        <td>${movie.tags}</td>
                      </tr>
                    </table>
                  </a>
                    <a href="/movies/${movie.id}/edit">
                      <div class='result__movie__edit-button'>
                        <i class="far fa-edit .result__movie__edit-button__icon"></i>
                        編集
                      </div>
                    </a>
                </div>`

    // 検索結果表示エリアに追加
    result.append(html);
  }

  // 非同期で動画検索
  $('.search__form input').on("change", function(){

    // 区分
    category = "";
    if($('input[name="category"]:checked').val() == "stage"){
      category = "ステージ";
    }else if($('input[name="category"]:checked').val() == "close"){
      category = "クロース";
    }else if($('input[name="category"]:checked').val() == "salon"){
      category = "サロン";
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
      url: "/movies/searches",
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
    .done(function(movies){
      result.empty();
      if(movies.length != 0){
        // 検索結果１件ずつHTMLを追加
        movies.forEach(function(movie){
          appendMovie(movie);
        });
      }
    })

    // 検索失敗
    .fail(function(){
      alert("検索エラー")
    })
  })

  // サムネイル設定
  $("#movie_url").on("blur", function(){

    if($(this).val() !== ""){
      // 動画URLから動画のIDを取得
      let url = $(this).val();
      let id = url.match(/v=.*/)[0].substring(2,13);

      // 動画のIDを設定
      player.cueVideoById({videoId: id});
    }
  })

});
