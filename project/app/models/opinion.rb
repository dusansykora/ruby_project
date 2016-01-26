# Opinion of user on a band, one user can have only one opinion on specific band, 
# users can have reactions on opinions (like / dislike)
class Opinion < ActiveRecord::Base
  belongs_to :user
  belongs_to :band
  has_many :reactions
  
  before_validation :strip_whitespace
  
  validates :text, presence: true, length: { minimum: 10, maximum: 100 }
  
  def strip_whitespace
    self.text = self.text.strip unless self.text.nil?
  end
end
