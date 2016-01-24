class Opinion < ActiveRecord::Base
  belongs_to :user
  belongs_to :band
  
  validates :text, presence: true, length: {minimum: 10, maximum: 100}
end
