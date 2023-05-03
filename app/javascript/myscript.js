jQuery(document).on("turbolinks:load", function () {

  // 郵便番号にハイフンを付けるスクリプト。強制半角数字
  $(function () {
    $("#customer_postcode").on('keyup', function () {
      let val = $(this).val().replace(/[^0-9]/g, '');
      if (val.length > 3) {
        val = val.slice(0, 3) + "-" + val.slice(3);
      }
      $(this).val(val.slice(0, 8));
    });
  });



  // 全角英数字を半角英数字に変換する。
  $(function () {
    $("#customer_address_street").on("input", function () {
      var inputVal = $(this).val();
      var outputVal = inputVal
        .replace(/[Ａ-Ｚａ-ｚ０-９]/g, function (s) {
          return String.fromCharCode(s.charCodeAt(0) - 0xFEE0);
        })
        .replace(/[ー―]/g, "-")
        .replace(/[^0-9\-]/g, "");
      $(this).val(outputVal);
    });
  });




  // 電話番号は、半角数字のみ
  $(function () {
    $("#customer_tel_number").on("input", function () {
      var inputVal = $(this).val();
      var outputVal = inputVal.replace(/[^\d]/g, "");
      $(this).val(outputVal);
    });
  });



  //トグルメニュー
  $(document).ready(function () {
    $(".toggle-menu img").click(function () {
      $(".menu").toggle();
    });
  });




  // タグを自動で入れる

  // テキストボックスを取得
  const tagInput = $('input[name="item[tag_name]"]');

  // タグをクリックした時の処理
  const tagLinks = $('.tag-link');
  tagLinks.each(function () {
    $(this).on("click", function (e) {
      // リンクのデフォルト動作を無効化
      e.preventDefault();
      // テキストボックスの内容にタグを追加
      const clickedTag = $(this).text().trim();
      if (tagInput.val()) {
        tagInput.val(`${tagInput.val()} ${clickedTag}`);
      } else {
        tagInput.val(clickedTag);
      }
    });
  });

  // タグのクリアボタン
  const clearButton = $("#clear-button");

  clearButton.on("click", function (e) {
    tagInput.val("");
  });


  ////////////////////////////////////////////////////////////////////////////////////////////////////////

  // モーダルウィンドウ
  $("#modal-open").click(function () {

    //キーボード操作などにより、オーバーレイが多重起動するのを防止する
    $(this).blur();	//ボタンからフォーカスを外す
    if ($("#modal-overlay")[0]) return false;		//新しくモーダルウィンドウを起動しない (防止策1)
    //if($("#modal-overlay")[0]) $("#modal-overlay").remove() ;		//現在のモーダルウィンドウを削除して新しく起動する (防止策2)

    //オーバーレイを出現させる
    $("body").append('<div id="modal-overlay"></div>');
    $("#modal-overlay").fadeIn("slow");

    //コンテンツをセンタリングする
    centeringModalSyncer();

    //コンテンツをフェードインする
    $("#modal-tag").fadeIn("slow");

    //[#modal-overlay]、または[#modal-close]をクリックしたら…
    $("#modal-overlay,#modal-close").unbind().click(function () {

      //[#modal-content]と[#modal-overlay]をフェードアウトした後に…
      $("#modal-tag,#modal-overlay").fadeOut("slow", function () {

        //[#modal-overlay]を削除する
        $('#modal-overlay').remove();

      });
    });
  });

  $(window).resize(centeringModalSyncer);

  //センタリングを実行する関数
  function centeringModalSyncer() {

    //画面(ウィンドウ)の幅、高さを取得
    var w = $(window).width();
    var h = $(window).height();

    // コンテンツ(#modal-content)の幅、高さを取得
    // jQueryのバージョンによっては、引数[{margin:true}]を指定した時、不具合を起こします。
    //		var cw = $( "#modal-tag" ).outerWidth( {margin:true} );
    //		var ch = $( "#modal-tag" ).outerHeight( {margin:true} );
    var cw = $("#modal-tag").outerWidth();
    var ch = $("#modal-tag").outerHeight();

    //センタリングを実行する
    $("#modal-tag").css({ "left": ((w - cw) / 2) + "px", "top": ((h - ch) / 2) + "px" });

  }


  // TOPへ戻る
  $("#top-upper").on("click", function () {
    $("html, body").animate({ scrollTop: 0 }, "slow");
  });



  // セレクトボックスの値を入力フィールドに反映。
  $(function () {
    $('#stock-select').change(function () {
      $('#item_stock').val($(this).val());
    });
  });







});