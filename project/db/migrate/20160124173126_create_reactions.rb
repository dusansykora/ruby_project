class CreateReactions < ActiveRecord::Migration
  def change
    create_table :reactions do |t|
      t.boolean :positive
      t.belongs_to :user, index: true
      t.belongs_to :opinion, index: true

      t.timestamps null: false
    end
  end
end
