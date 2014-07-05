class Image < ActiveRecord::Base
  attr_reader :image_remote_url
  has_attached_file :image, :styles => {:thumb => "200x200>"},
    :default_url => "/images/missing.:style.png",
    :url         => "/images/:style/:id.:extension",
    :path        => ":rails_root/public/images/:style/:id.:extension"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  def image_remote_url=(url)
    self.image = URI.parse(url)
    @image_remote_url = url
  end
  
  def image_url
    image.url
  end
  
  def image_thumb_url
    image.url(:thumb)
  end
end
