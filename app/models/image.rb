class Image < ActiveRecord::Base
  # TODO: Restrict attribute fetching, e.g. don't return IP info
  attr_reader :image_remote_url
  
  has_attached_file :image, :styles => {:thumb => "200x200>"},
    :default_url => "/images/missing.:style.png",
    :url         => "/images/:style/:id.:extension",
    :path        => ":rails_root/public/images/:style/:id.:extension"
    
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  def word=(word)
    search_results = GoogleCustomSearchApi.search(word, {
      "searchType" => "image",
      "imgSize"    => "xlarge",
      "safe"       => "off",   # SafeSearch level (high | medium | off)
    })
    img = search_results["items"][0]
    self.image = URI.parse(img["link"])
    write_attribute(:word, word)
  end
  
  # URL methods for to_json
  def image_url
    image.url
  end
  def image_thumb_url
    image.url(:thumb)
  end
  
  def as_json(options)
    super({:methods => [:image_url, :image_thumb_url]}.merge(options))
  end
end
