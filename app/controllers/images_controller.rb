class ImagesController < ApplicationController
  respond_to :json
  
  def index
    images = Image.all
    respond_with images
  end
  
  def show
    respond_with Image.find(params[:id])
  end
  
  def create
    respond_with Image.create(image_params)
  end
  
  def destroy
    respond_with Image.destroy(params[:id])
  end
  
  private
  def image_params
    params.require(:image).permit(:word)
  end
end
