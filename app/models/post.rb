class Post < ActiveRecord::Base
	include ActionView::Helpers::TextHelper

  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :user_id, :presence => true
  validates :title, :presence => true, :length => { :maximum => 140 }
  validates :text_content, :presence => true

  def preview
  	truncate(text_content, :length => 140 )
  end
end