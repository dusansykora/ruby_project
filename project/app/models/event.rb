class Event < ActiveRecord::Base
  belongs_to :band
  has_many :attendances
end
