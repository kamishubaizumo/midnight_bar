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




});