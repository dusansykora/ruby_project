class DropIsGoingFromAttendances < ActiveRecord::Migration
  def change
    remove_column :attendances, :is_going
  end
end
