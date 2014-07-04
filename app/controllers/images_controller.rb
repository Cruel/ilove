class ImagesController < ApplicationController
  
  def index
    @images = Image.all
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
    #render plain: params[:image].inspect
    img = test["items"][0]
    #render plain: img["link"]
    @image.image_remote_url = img["link"]
    @image.save
    redirect_to @image
  end
  
  private
  def image_params
    params.require(:image).permit(:word)
  end
end
