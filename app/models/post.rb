class Post < ActiveRecord::Base
	include ActionView::Helpers::TextHelper
	include Bootsy::Container

  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :user_id, :presence => true
  validates :title, :presence => true, :length => { :maximum => 140 }
  validates :text_content, :presence => true

  acts_as_taggable # Alias for acts_as_taggable_on :tags

  def preview
  	# get the rich text html output, remove tags, then truncate for preview
  	truncate(strip_tags(text_content), :length => 140 )
  end
end
