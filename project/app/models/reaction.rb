class Reaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :opinion
end
