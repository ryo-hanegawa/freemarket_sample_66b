crumb :root do
  link "フリマ", root_path
end

crumb :mypage do
  link "マイページ", mypages_path
  parent :root
end

crumb :logout do
  link "ログアウト", logout_index_path
  parent :mypage
end

crumb :profile do
  link "プロフィール", mypage_profile_path
  parent :mypage
end

crumb :card_create do
  link "支払い方法", mypage_card_new_path
  parent :mypage
end