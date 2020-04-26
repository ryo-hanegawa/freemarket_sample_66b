class Item < ApplicationRecord
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  # name(商品名) description(商品説明) category(カテゴリー) condition(商品の状態) prefecture(発送元の地域(都道府県)) deliberydate(発送までの日数) postage(配送料) price(価格)
  validates :name, :description, :category, :condition, :prefecture, :deliberydate, :postage, :price, presence: true
end