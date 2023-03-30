$(function () {
  $(document).on('turbolinks:load', () => {
    $('#customer_postcode').jpostal({
      postcode: [
        '#cusstomer_postcode'
      ],
      address: {
        "#customer_prefecture_code": "%3%4%5",
        "#customer_other_address": "%6%7"
      }
    });
  });
});


// # 入力項目フォーマット
// #   %3  都道府県
// #   %4  市区町村
// #   %5  町域
// #   %6  大口事業所の番地 ex)100-6080
// #   %7  大口事業所の名称