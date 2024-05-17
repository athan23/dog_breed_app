class DogsController < ApplicationController
  def index
  end

  def fetch_breed_image
    breed = helpers.format_breed_name(params[:breed])
    result = DogApi.call(breed)

    if result["status"] == "success"
      @image_url = result["message"]
      @breed = params[:breed]
    else
      @image_url = nil
      @breed = params[:breed]
    end

    respond_to do |format|
      format.turbo_stream
    end
  end
end
