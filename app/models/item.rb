class Item < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :product, optional: true
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  # name(商品名) description(商品説明) category(カテゴリー) condition(商品の状態) prefecture(発送元の地域(都道府県)) deliberydate(発送までの日数) postage(配送料) price(価格)
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :size, presence: true
  validates :condition, presence: true
  validates :prefecture, presence: true
  validates :deliberydate, presence: true
  validates :postage, presence: true
  validates :price, presence: true

 
  enum size:      { SS: 1, S: 2, M: 3, L: 4, LL: 5, LX: 6 }, _prefix: true
  enum condition: { 新品・未使用: 1, 未使用に近い: 2, 目立った傷や汚れなし: 3, やや傷や汚れあり: 4, 全体的に状態が悪い: 5 }, _prefix: true
  enum postage:   { 送料込み（出品者負担）: 1, 着払い（購入者負担）: 2 }, _prefix: true
  enum deliberydate: { "1~2日で発送": 1, "3~4日で発送": 2, "4~7日で発送": 3 }, _prefix: true
end