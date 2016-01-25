class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.belongs_to :band, index: true

      t.timestamps null: false
    end
  end
end
