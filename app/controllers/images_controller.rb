class ImagesController < ApplicationController
  respond_to :json
  
  def index
    images = Image.all
    respond_with images.to_json(:methods => [:image_url, :image_thumb_url])
  end
  
  def new
    #
  end
  
  def show
    @image = Image.find(params[:id])
  end
  
  def create
    @image = Image.new(image_params)
    
    test = GoogleCustomSearchApi.search(params[:image][:word], {
      "searchType" => "image",
      "imgSize"    => "xlarge",
      "safe"       => "off",   # SafeSearch level (high | medium | off)
    })
    img = test["items"][0]
    @image.image_remote_url = img["link"]
    @image.save
    redirect_to @image
  end
  
  private
  def image_params
    params.require(:image).permit(:word)
  end
end
