# Comment of user on a post written by "band"
class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  
  before_validation :strip_whitespace
  
  validates :text, presence: true, length: {minimum: 10, maximum: 150}
  
  def strip_whitespace
    self.text = self.text.strip unless self.text.nil?
  end
end
