class User < ApplicationRecord
has_many :sns_credentials, dependent: :destroy
has_many :products,dependent: :destroy
  has_many :cards,dependent: :destroy
  has_many :addresses,dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

#   validates :nickname, presence: true, length: { maximum: 15 },profanity_filter: true
#   validates :f_name_kanji, presence: true, length: { maximum: 15 }, format: { with: kanji }
#   validates :l_name_kanji, presence: true, length: { maximum: 15 }, format: { with: kanji }
#   validates :f_name_kana, presence: true, length: { maximum: 15 }, format: { with: kana }
#   validates :l_name_kana, presence: true, length: { maximum: 15 }, format: { with: kana }
#   validates :birthday, presence: true, format: { with: year_month_day }
#   validates :password,presence: true
#   validates :password_confirmation,presence: true
#   validates :tel, presence: true
end