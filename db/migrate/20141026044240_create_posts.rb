class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :text_content
      t.references :user, index: true

      t.timestamps null: false
    end
    add_index :posts, [:user_id, :created_at]
  end
end
