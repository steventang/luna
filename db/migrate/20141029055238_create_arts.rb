class CreateArts < ActiveRecord::Migration
  def change
    create_table :arts do |t|
      t.string :picture
      t.string :title
      t.text :description
      t.references :user, index: true

      t.timestamps
    end
    add_index :arts, [:user_id, :created_at]
  end
end
