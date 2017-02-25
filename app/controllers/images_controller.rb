class ImagesController < ApplicationController

  def index
    @images = Image.last(50)
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to images_path
    else
      render 'new'
    end
  end

  private

  def image_params
    params.require(:image).permit(:title, :description, :image_file)
  end
end
