class Art < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validates :picture, presence: true
  validate :picture_size

  private
  	def picture_size
  		if picture.size > 3.megabytes
  			errors.add(:picture, "must be 3MB or smaller")
  		end
  	end
end
