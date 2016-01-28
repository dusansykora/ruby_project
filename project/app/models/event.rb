# Event of a band, users can set their attendance.
class Event < ActiveRecord::Base
  belongs_to :band
  has_many :attendances
  
  before_validation :strip_whitespace
  
  validates :title, presence: true, length: { minimum: 3, maximum: 20 }, 
    format: { with: /\A[a-zA-Z0-9 _-]+\z/, message: "only allows letters, numbers, spaces, '-' and '_'" }
  validates :info, presence: true, length: { minimum: 3, maximum: 200 }
  validates :place, presence: true, length: { minimum: 3, maximum: 50 }
  validates :start_time, presence: true
  validate :start_time_is_not_in_past
  validates :duration, presence: true, numericality: { greater_than: 0 }
  
  def strip_whitespace
    self.title = self.title.strip unless self.title.nil?
    self.info = self.info.strip unless self.info.nil?
    self.place = self.place.strip unless self.place.nil?
  end
  
  def start_time_is_not_in_past
    errors.add(:start_time, "can't be in the past") if !start_time.blank? && start_time < Date.today
  end
end
