$(function(){

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
});
