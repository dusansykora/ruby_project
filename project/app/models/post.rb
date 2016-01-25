class Post < ActiveRecord::Base
  belongs_to :band
  has_many :comments
  
  validates :title, presence: true, length: {minimum: 5, maximum: 30}
  validates :text, presence: true, length: {minimum: 10, maximum: 500}
end
