# Post (news) written by "band", can have comments written by users
class Post < ActiveRecord::Base
  belongs_to :band
  has_many :comments
  
  before_validation :strip_whitespace
  
  validates :title, presence: true, length: {minimum: 5, maximum: 30}
  validates :text, presence: true, length: {minimum: 10, maximum: 500}
  
  def strip_whitespace
    self.title = self.title.strip unless self.title.nil?
    self.text = self.text.strip unless self.text.nil?
  end
end
