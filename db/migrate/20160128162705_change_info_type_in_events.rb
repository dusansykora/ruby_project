class ChangeInfoTypeInEvents < ActiveRecord::Migration
  def self.up
    change_column :events, :info, 'text USING CAST(info AS text)'
  end
  
  def self.down
    change_column :events, :info, 'string USING CAST(info AS string)'
  end
end
