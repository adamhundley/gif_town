require 'faraday'
require 'json'
class Admin::GifsController < Admin::BaseController
  def index
    @gifs = Gif.all
  end

  def show
    @gif = Gif.find(params[:id])
  end

  def new
    @gif = Gif.new
  end

  def destroy
    Gif.destroy(params[:id])
    redirect_to admin_gifs_path
  end

  def create
    @gif = Gif.new(gif_params)
    @gif.image_url = find_gif(gif_params)
    if @gif.save
      flash[:notice] = "Gif found and created!"
      redirect_to admin_gifs_path
    else
      flash[:error] = @gif.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def gif_params
    params.require(:gif).permit(:category)
  end

  def find_gif(gif)
    response = Faraday.get("http://api.giphy.com/v1/gifs/search?q=#{gif["category"]}&api_key=dc6zaTOxFJmzC")
    raw_data = response.body
    parsed_data = JSON.parse(raw_data)["data"]
    parsed_data.first["images"]["fixed_height"]["url"]
  end
end
