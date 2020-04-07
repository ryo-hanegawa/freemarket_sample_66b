crumb :root do
  link 'ホーム', root_path
end

crumb :user_show do
  link "#{current_user.name}"
  parent :root
end

crumb :user_chat_rooms_index do
  link "メッセージ一覧",user_chat_rooms_path(user_id:current_user.id)
  parent :user_show
end
