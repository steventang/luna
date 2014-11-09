class RenamePostsToArticles < ActiveRecord::Migration
  def change
  	rename_table :posts, :articles
  end
end
