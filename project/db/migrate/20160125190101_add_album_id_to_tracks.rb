class AddAlbumIdToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :album_id, :integer
  end
end
