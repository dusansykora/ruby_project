# User of the system, can be in band, post opinions on bands, have reactions on other opinions, 
# attend events of bands, post comments on posts of bands
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  belongs_to :band
  has_many :opinions
  has_many :reactions
  has_many :attendances
  has_many :comments
  
  validates :username, uniqueness: true, presence: true, length: { minimum: 3, maximum: 20 }, 
    format: { with: /\A[a-zA-Z0-9]+\z/, message: "only allows letters and numbers" }
  validates :dob, presence: true
  validate :dob_is_in_past
  validate :username_is_allowed

  has_attached_file :avatar,
    :styles => { :medium => "300x300>", :thumb => "100x100#" },
    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def dob_is_in_past
    errors.add(:dob, "can't be in the future") if !dob.blank? && dob > Date.today
  end
  
  def username_is_allowed
    if !username.blank? && (username.downcase.include?('admin') || username.downcase.include?('administrator'))
      errors.add(:username, "#{username} is not allowed")
    end
  end
end
