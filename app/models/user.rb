class User < ApplicationRecord
       has_many :sns_credentials, dependent: :destroy
       # Include default devise modules. Others available are:
       # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
       devise :database_authenticatable, :registerable,
              :recoverable, :rememberable, :validatable
              # kanji = /\A[一-龥]+\z/
              # kana = /\A([ァ-ン]|ー)+\z/
              # year_month_day = /\A\d{4}-\d{2}-\d{2}\z/
     
       validates :nickname, presence: true, length: { maximum: 15 }
       validates :first_name, presence: true, length: { maximum: 15 }
       validates :last_name, presence: true, length: { maximum: 15 }
       validates :first_name_reading, presence: true, length: { maximum: 15 }
       validates :last_name_reading, presence: true, length: { maximum: 15 }
       validates :birthday, presence: true
       validates :tel, presence: true
     
       
       def self.without_sns_data(auth)
         user = User.where(email: auth.info.email).first
     
           if user.present?
             sns = SnsCredential.create(
               uid: auth.uid,
               provider: auth.provider,
               user_id: user.id
             )
           else
             user = User.new(
               nickname: auth.info.name,
               email: auth.info.email
             )
           end
           return { user: user}
         end
     
        def self.with_sns_data(auth, snscredential)
         user = User.where(id: snscredential.user_id).first
         unless user.present?
           user = User.new(
             nickname: auth.info.name,
             email: auth.info.email
           )
         end
         return {user: user}
        end
     
end