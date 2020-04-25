FactoryBot.define do
  factory :address do
    user_id               {"1"}
    postal_code           {"111-1111"}
    prefecture            {"1"}
    city                  {"東京都"}
    street                {"江東区"}
    building              {"ミッドランドスクエア"}
    last_name          {"中西"}
    first_name          {"啓太"}
    last_name_reading           {"ナカニシ"}
    first_name_reading           {"ケイタ"}
    user
  end
end
