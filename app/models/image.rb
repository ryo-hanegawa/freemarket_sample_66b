class Image < ApplicationRecord
  mount_uploaders :image_url, ImageUploader
  belongs_to :item, inverse_of: :images
  validates :image, presence: true
end