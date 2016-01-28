class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start_time
      t.integer :duration
      t.string :place
      t.string :info

      t.timestamps null: false
    end
  end
end
