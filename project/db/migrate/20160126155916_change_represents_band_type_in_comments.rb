class ChangeRepresentsBandTypeInComments < ActiveRecord::Migration
  def self.up
    change_column :comments, :represents_band, 'integer USING CAST(represents_band AS integer)'
  end
  
  def self.down
    change_column :comments, :represents_band, 'boolean USING CAST(represents_band AS boolean)'
  end
end
