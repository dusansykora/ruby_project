# Track of one album of a band
class Track < ActiveRecord::Base
  belongs_to :album
  
  before_validation :strip_whitespace
  
  validates :title, uniqueness: true, presence: true, length: { minimum: 3, maximum: 20 }, 
    format: { with: /\A[a-zA-Z0-9 _-]+\z/, message: "only allows letters, numbers, spaces, '-' and '_'" }
  validates :number, uniqueness: true, numericality: { greater_than: 0 }
  
  def strip_whitespace
    self.title = self.title.strip unless self.title.nil?
  end
end
