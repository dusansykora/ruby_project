class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name
      t.integer :establish_year

      t.timestamps null: false
    end
  end
end
