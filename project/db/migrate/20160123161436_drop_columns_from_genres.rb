class DropColumnsFromGenres < ActiveRecord::Migration
  def change
    remove_column :genres, :created_at
    remove_column :genres, :updated_at
  end
end
