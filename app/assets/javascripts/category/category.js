$(document).ready(function() {

  // 子カテゴリのHTML表示
  function buildChildHTML(children){
    var option = ``
    children.forEach(function(child){
      option += `<option value="${child.id}">${child.name}</option>`
    })

    var html = `<div id="children_wrapper">
                  <select class= 'input-form', id= 'child-form', required= 'required'>
                <option value label="選択してください"></option>
                ${option}
                </div>`;
    return html;
  }

  // 孫カテゴリのHTML表示e
  function buildGrandChildHTML(grandchildren){
    var option = ``
    grandchildren.forEach(function(grandchild){
      option += `<option value="${grandchild.id}">${grandchild.name}</option>`
    })

    var html = `<div id="grandchildren_wrapper">
                  <select class= 'input-form', id= 'grandchild-form', required= 'required'>
                <option value label="選択してください"></option>
                ${option}
                </div>`;
    return html;
  }



    // 親カテゴリ選択後のイベント
  $('#parent-form').on('change', function(){
    var parentCategory = $('#parent-form').val();
    if(parentCategory != 0){
      $.ajax({
        url: '/search',
        type: 'GET',
        data: { parent_id: parentCategory },
        dataType: 'json',
      })
      .done(function(children){
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();

        var html = buildChildHTML(children);
        $("#pull_down_category").append(html);
      })
      .fail(function(){
        alert('親カテゴリの取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove();
      $('#grandchildren_wrapper').remove();
    }
  });

  // 子カテゴリ選択後のイベント
  $('#pull_down_category').on('change', '#child-form', function(){
    // カテゴリーの子要素に紐づくIDを取得して、そのIDに紐づく孫要素を取得する。
    // option:selected を指定する事で、プルダウンで選択したものの情報を取得できる事になる。
    var childId = $('#child-form').val();
    if (childId != 0) {
      $.ajax({
        url: '/grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json',
      })
      .done(function(grandchildren){
        $('#grandchildren_wrapper').remove();

        var html = buildGrandChildHTML(grandchildren);
        $("#pull_down_category").append(html);
      })
      .fail(function() {
        alert('子カテゴリの取得に失敗しました');
      })
    } else {
      $('#grandchildren_wrapper').remove();
    }
  });
});