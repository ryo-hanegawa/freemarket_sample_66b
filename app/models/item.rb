class Item < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :product, optional: true
  belongs_to :category
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  # name(商品名) description(商品説明) category(カテゴリー) condition(商品の状態) prefecture(発送元の地域(都道府県)) deliberydate(発送までの日数) postage(配送料) price(価格)
  validates :name, presence: true
  validates :description, presence: true
  # validates :category, presence: true
  validates :size, presence: true
  validates :condition, presence: true
  validates :prefecture, presence: true
  validates :deliberydate, presence: true
  validates :postage, presence: true
  validates :price, presence: true

  # enum prefecture: { 北海道: 1, 青森県: 2, 岩手県: 3, 宮城県: 4, 秋田県: 5, 山形県: 6, 福島県: 7, 東京都: 8, 神奈川県: 9, 埼玉県: 10, 千葉県: 11, 茨城県: 12, 栃木県: 13, 群馬県: 14, 山梨県: 15, 新潟県: 16, 長野県: 17, 富山県: 18, 石川県: 19, 福井県: 20, 愛知県: 21, 岐阜県: 22, 静岡県: 23, 三重県: 24, 大阪府: 25, 兵庫県: 26, 京都府: 27, 滋賀県: 28, 奈良県: 29, 和歌山県: 30, 鳥取県: 31, 島根県: 32, 岡山県: 33, 広島県: 34, 山口県: 35, 徳島県: 36, 香川県: 37, 愛媛県: 38, 高知県: 39, 福岡県: 40, 佐賀県: 41, 長崎県: 42, 熊本県: 43, 大分県: 44, 宮崎県: 45, 鹿児島県: 46, 沖縄県: 47}, _prefix: true
  enum size:      { SS: 1, S: 2, M: 3, L: 4, LL: 5, LX: 6 }, _prefix: true
  enum condition: { 新品・未使用: 1, 未使用に近い: 2, 目立った傷や汚れなし: 3, やや傷や汚れあり: 4, 全体的に状態が悪い: 5 }, _prefix: true
  enum postage:   { 送料込み（出品者負担）: 1, 着払い（購入者負担）: 2 }, _prefix: true
  enum deliberydate: { "1~2日で発送": 1, "3~4日で発送": 2, "4~7日で発送": 3 }, _prefix: true
end
