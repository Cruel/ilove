class Image < ActiveRecord::Base
  attr_reader :image_remote_url
  has_attached_file :image, :styles => {:thumb => "200x200>"},
    :default_url => "/images/missing.:style.png",
    :url         => "/images/:style/:id.:extension",
    :path        => ":rails_root/public/images/:style/:id.:extension"
    #:path        => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  def image_remote_url=(url)
    self.image = URI.parse(url)
    @image_remote_url = url
  end
end
