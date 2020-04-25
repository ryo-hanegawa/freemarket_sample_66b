$(function(){
  //変数fileIndex = インデックス番号をつける。この番号を使ってプレビュー表示の際に紐付ける
  let fileIndex = 1
  const buildFileField = (num)=> {
    const html = `<div class="js-file_group" data-index="${num}">
                    <input class="js-file" type="file"
                    name="item[item_images_attributes][${num}][image]"
                    id="item_item_images_attributes_${num}_image">
                    <span class="js-remove">削除</span>
                  </div>`;
    //新しい入力フォームが生成されるたびに、インデックス番号を１足していく
    fileIndex += 1
    return html;
  }
  //プレビュー表示用の定数。該当インデックス番号とそれに紐づくURLと画像サイズを変数buildingに代入。
  const buildImg = (index, url)=> {
    const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
    return html;
  }

  

  //#image-boxの子要素であるjs-fileに変更がある場合にイベントが発火。
  $('#image-box').on('change', '.js-file', function(e) {

    //選択した要素の親要素のdata属性のインデックス番号を取得して、定数targetIndexに代入。
    const targetIndex = $(this).parent().data('index');
    //ファイル名を取得して、定数fileに代入。
    const file = e.target.files[0];

    
    
    //「一度選択した画像ファイルを再度選択してキャンセルボタンを押すと、「選択されていません」と表示され、プレビュー表示に残骸のようなものが残る。それを解消するため、キャンセルした時に入力フォームに紐づくインデックス番号の削除ボタンを起動させるための記述です。
    //(!file)とは、定数fileに値がない時の条件分岐です。
    if(!file){
      $(`.js-file_group[data-index=${targetIndex}]`).find(".js-remove").trigger("click");
      return false;
    }

      //定数fileに値があれば以下の処理に移る。

      var blobUrl = window.URL.createObjectURL(file);
    
    //もし一度選択された画像ファイルを変更した時の処理.

    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {  
      $('#previews').append(buildImg(targetIndex, blobUrl));
    let limitFileField = $(".js-file_group:last").data("index");

    //この部分によって最大10枚以上の画像は投稿できないようにしています。ength番号10までは、画像入力フォームを生成するようにしてます。※インデックス番号を利用していないことに注意
    if($(".js-file_group").length >= 10 ){
      return false;
    } else {
      $('#image-box').append(buildFileField(fileIndex));

    }
    }
  });

  $('#image-box').on('click', '.js-remove', function() {
    //最新のインデックス番号を取得して変数limitFileFieldに代入してます。
    let limitFileField = $(".js-file_group:last").data("index");
    const targetIndex = $(this).parent().data('index')
    //削除ボタンを押した時に該当のインデックス番号の入った入力フォームとプレビュー画像を消せるようになってます。
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    if (hiddenCheck) hiddenCheck.prop('checked', true);
    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();
    //もし、（現在入力されてるフォームが最新のフォームで、かつ、入力フォームのlengthが９以上なら、新しく入力フォームを生成する。という条件分岐によって、入力フォーム自体が消滅することを防ぎつつ、「現在入力されてるフォームが最新のフォーム」以外の条件でフォーム自体を消してしまう不具合を解消しています。（要するに、最新の入力フォーム以外を削除すると入力フォーム自体が消滅してしまう）
    if ((targetIndex == limitFileField ) || ($(".js-file_group").length >= 9)) ($('#image-box').append(buildFileField(fileIndex)));
  });
});