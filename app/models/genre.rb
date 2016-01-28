# Every band has one genre
class Genre < ActiveRecord::Base
  has_many :bands
  
  validates :name, uniqueness: true, presence: true, length: { minimum: 3, maximum: 20 }
  
  def to_param
    name
  end
end
