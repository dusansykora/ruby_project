# Album of a band containing tracks
class Album < ActiveRecord::Base
  belongs_to :band
  has_many :tracks
  
  before_validation :strip_whitespace
  
  validates :title, presence: true, length: { minimum: 3, maximum: 20 }, 
    format: { with: /\A[a-zA-Z0-9 _-]+\z/, message: "only allows letters, numbers, spaces, '-' and '_'" }
  validates :release_date, presence: true
  validate :release_date_is_not_in_future
  
  has_attached_file :cover_photo,
    :styles => { :medium => "300x300>", :thumb => "100x100#" },
    :default_url => "/images/:style/missing_album_cover.png"
  validates_attachment_content_type :cover_photo, :content_type => /\Aimage\/.*\Z/
  
  def release_date_is_not_in_future
    errors.add(:release_date, "can't be in the future") if !release_date.blank? && release_date > Date.today
  end
  
  def strip_whitespace
    self.title = self.title.strip unless self.title.nil?
  end
end
