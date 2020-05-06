document.addEventListener(
  'DOMContentLoaded', (e) => {
    if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
      Payjp.setPublicKey("pk_test_1810989aac86ea04fd269122"); //ここに公開鍵を直書き
      let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得されます
      btn.addEventListener("click", e => { //ボタンが押されたときに作動します
        e.preventDefault(); //ボタンを一旦無効化します
        let card = {
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("expire_month").value,
          exp_year: document.getElementById("expire_year").value
        }; //入力されたデータを取得します。
        Payjp.createToken(card, function(s, response) {
          if (response.error) { //成功した場合
            alert("カード情報が正しくありません。"); //確認用
          } else {
            $("#card_number").removeAttr("card_number");
            $("#cvc").removeAttr("cvc");
            $("#expire_month").removeAttr("expire_month");
            $("#expire_year").removeAttr("expire_year"); //データを自サーバにpostしないように削除
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
            ); //取得したトークンを送信できる状態にします
            document.inputForm.submit();
            console.log(document.inputForm);
            alert("登録が完了しました"); //確認用
          }
        });
      });
    }
  },
  false
);