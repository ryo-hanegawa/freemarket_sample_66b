$(function(){

  // 子カテゴリのHTML表示
  function buildChildHTML(children){
    var option = ``
    children.forEach(function(child){
      option += `<option value="${child.id}">${child.name}</option>`
    })

    var html = `<div id="children_wrapper_edit">
                  <select class= 'input-form', id= 'child-form-edit',required= 'required'>
                <option value label="選択してください"></option>
                ${option}
                </div>`;
    return html;
  }

  // 孫カテゴリのHTML表示
  function buildGrandChildHTML(grandchildren){
    var option = ``
    grandchildren.forEach(function(grandchild){
      option += `<option value="${grandchild.id}">${grandchild.name}</option>`
    })

    var html = `<div id="grandchildren_wrapper_edit">
                  <select class= 'input-form', id= 'grandchild-form-edit', name= "item[category_id]",  required= 'required'>
                <option value label="選択してください"></option>
                ${option}
                </div>`;
    return html;
  }

  // 親カテゴリ選択後のイベント
  $('#parent-form-edit').on('change', function(){
    var parentCategory = $('#parent-form-edit').val();
    $.ajax({
      url: '/search_edit',
      type: 'GET',
      data: { parent_id: parentCategory },
      dataType: 'json',
    })
    .done(function(children){
      $('#child-form-edit').remove();
      $('#grandchild-form-edit').remove();
      var html = buildChildHTML(children);
      $("#pull_down_category_edit").append(html);
    })
    .fail(function(){
      alert('親カテゴリの取得に失敗しました');
    })
  });

  // 子カテゴリ選択後のイベント1
  $('#pull_down_category_edit').on('change', '#child-form-edit', function(){
    var childId = $('#child-form-edit').val();
    $.ajax({
      url: '/grandchildren_edit',
      type: 'GET',
      data: { child_id: childId },
      dataType: 'json',
    })
    .done(function(grandchildren){
      $('#grandchild-form-edit').remove();
      var html = buildGrandChildHTML(grandchildren);
      $("#pull_down_category_edit").append(html);
    })
    .fail(function() {
      alert('子カテゴリの取得に失敗しました');
    })
  });

  // 子カテゴリ選択後のイベント2
  $('#child-form-edit').on('change', function(){
    var childId = $('#child-form-edit').val();
    $.ajax({
      url: '/grandchildren_edit',
      type: 'GET',
      data: { child_id: childId },
      dataType: 'json',
    })
    .done(function(grandchildren){
      $('#grandchild-form-edit').remove();
      var html = buildGrandChildHTML(grandchildren);
      $("#pull_down_category_edit").append(html);
    })
    .fail(function() {
      alert('子カテゴリの取得に失敗しました');
    })
  });
});