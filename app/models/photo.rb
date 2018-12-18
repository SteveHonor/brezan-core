class Photo < ApplicationRecord
  belongs_to :album

  has_attached_file :image, :storage => :s3

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def image_url
    self.image.url(:original)
  end
end
