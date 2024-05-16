class DogsController < ApplicationController
  def index
  end

  def fetch_breed_image
    breed = params[:breed]
    result = DogApi.call(breed)

    if result["status"] == "success"
      @image_url = result["message"]
      @breed = breed
    else
      @image_url = nil
      @breed = breed
    end

    puts @image_url
    puts @breed

    respond_to do |format|
      format.turbo_stream
    end
  end
end
