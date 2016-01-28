class AddEventIdAndUserIdToAttendance < ActiveRecord::Migration
  def change
    add_column :attendances, :user_id, :integer
    add_column :attendances, :event_id, :integer
  end
end
