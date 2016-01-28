class AddBandIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :band_id, :integer
  end
end
