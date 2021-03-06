class Image < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :item, inverse_of: :images
  validates :image, presence: true
end