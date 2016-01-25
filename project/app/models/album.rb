class Album < ActiveRecord::Base
  belongs_to :band
  has_many :tracks
  has_attached_file :cover_photo,
    :styles => { :medium => "300x300>", :thumb => "100x100#" },
    :default_url => "/images/:style/missing_album_cover.png"
  validates_attachment_content_type :cover_photo, :content_type => /\Aimage\/.*\Z/
end
