class Image < ActiveRecord::Base
  # TODO: Restrict attribute fetching, e.g. don't return IP info

  has_attached_file :image,
    :styles => lambda { |image| {
      :thumb => "200x200>",
    }},
    :default_url => "/images/missing.:style.png",
    :url         => "/images/:style/:id.:extension",
    :path        => ":rails_root/public/images/:style/:id.:extension"
    
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  def word=(loved_word)
    search_results = GoogleCustomSearchApi.search(loved_word, {
      "searchType" => "image",
      "imgSize"    => "xlarge",
      "safe"       => "off",   # SafeSearch level (high | medium | off)
    })
    img = search_results["items"][0]

    file = Paperclip::TempfileFactory.new.generate(img["link"])
    image = MiniMagick::Image.open(img["link"])
    image.combine_options('convert') do |c|                                                                                  
      c.gravity 'South'   
      c.background "none"
      c.strokewidth 4                                                                                 
      c.font Rails.root.join('public', 'watermark.ttf')                                                     
      c.fill "#ffffff"
      c.size "#{image[:width]}x#{image[:height]/4}"
      c.stroke "black"
      c.caption "I love #{loved_word}!"
      c.composite
      c.stroke "none"
      c.caption "I love #{loved_word}!"
      c.composite                                                                                           
    end

    image.write(file)
    file.rewind
    self.image = file
    write_attribute(:word, loved_word)
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
