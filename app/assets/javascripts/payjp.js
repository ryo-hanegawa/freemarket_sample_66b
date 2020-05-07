document.addEventListener(
  'DOMContentLoaded', (e) => {
    if (document.getElementById("token_submit") != null) {
      Payjp.setPublicKey("pk_test_1810989aac86ea04fd269122");
      let btn = document.getElementById("token_submit");
      btn.addEventListener("click", e => {
        e.preventDefault();
        let card = {
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("expire_month").value,
          exp_year: document.getElementById("expire_year").value
        };
        Payjp.createToken(card, function(s, response) {
          if (response.error) {
            alert("カード情報が正しくありません。");
          } else {
            $("#card_number").removeAttr("card_number");
            $("#cvc").removeAttr("cvc");
            $("#expire_month").removeAttr("expire_month");
            $("#expire_year").removeAttr("expire_year");
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
            );
            document.inputForm.submit();
            console.log(document.inputForm);
            alert("登録が完了しました");
          }
        });
      });
    }
  },
  false
);