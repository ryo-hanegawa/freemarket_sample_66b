crumb :root do
  link "フリマ", root_path
end

crumb :mypage do
  link "マイページ", mypage_path: "user"
  parent :root
end

crumb :logout do
  link "ログアウト", logout_index_path: "logouts"
  parent :mypage
end

crumb :card_create do
  link "支払い方法", mypage_card_new_path: " user_creditcards"
  parent :mypage
end

crumb :product do
  link "商品詳細ページ", product_path: "item"
  parent :mypage
end