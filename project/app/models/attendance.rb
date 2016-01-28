# Confirmed attendance of a user to an event of a band
class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
end
