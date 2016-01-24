class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.text :text
      t.belongs_to :user, index: true
      t.belongs_to :band, index: true

      t.timestamps null: false
    end
  end
end
