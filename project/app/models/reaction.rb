# Reaction (like / dislike) of user on opinion on a band
class Reaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :opinion
end
