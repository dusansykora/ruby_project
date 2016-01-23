class AddGenreIdToBand < ActiveRecord::Migration
  def change
    add_column :bands, :genre_id, :integer
  end
end
