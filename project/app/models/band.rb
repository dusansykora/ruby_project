# Consists of multiple users, is of one genre, has events, posts and albums, 
# user can write opinion on it
class Band < ActiveRecord::Base
  belongs_to :genre
  has_many :users
  has_many :events
  has_many :opinions
  has_many :posts
  has_many :albums
  
  before_validation :strip_whitespace
  
  validates :name, uniqueness: true, presence: true, length: { minimum: 3, maximum: 20 }, 
    format: { with: /\A[a-zA-Z0-9 _-]+\z/, message: "only allows letters, numbers, spaces, '-' and '_'" }
  validates :establish_year, presence: true
  validate :establish_year_is_not_in_future

  has_attached_file :cover_photo,
    :styles => { :medium => "300x300>", :thumb => "100x100#" },
    :default_url => "/images/:style/missing_band.png"
  validates_attachment_content_type :cover_photo, :content_type => /\Aimage\/.*\Z/
  
  def establish_year_is_not_in_future
    errors.add(:establish_year, "can't be in the future") if !establish_year.blank? && establish_year > Date.today.year
  end
  
  def strip_whitespace
    self.name = self.name.strip unless self.name.nil?
  end
end
