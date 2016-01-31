# Track of one album of a band
class Track < ActiveRecord::Base
  belongs_to :album
  
  before_validation :strip_whitespace
  
  validates :title, presence: true, length: { minimum: 3, maximum: 20 }, 
    format: { with: /\A[a-zA-Z0-9 _-]+\z/, message: "only allows letters, numbers, spaces, '-' and '_'" }
  validates :number, presence: true, numericality: { greater_than: 0 }
  validate :numbers
  
  def numbers
    self.album.tracks.each do |track|
      if track.number == self.number && track.id != self.id
        errors.add(:number, "#{self.number} is already used in album #{self.album.title}")
      end
    end
  end
  
  def strip_whitespace
    self.title = self.title.strip unless self.title.nil?
  end
end
