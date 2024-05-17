class DogApi < ApplicationService
  require 'net/http'
  require 'json'

  DOG_API_BASE_URL = 'https://dog.ceo/api'.freeze

  def initialize(breed)
    @breed = breed
  end

  def call
    fetch_breed_image
  end

  private

  def fetch_breed_image
    url = URI("#{DOG_API_BASE_URL}/breed/#{@breed.downcase}/images/random")
    response = Net::HTTP.get(url)
    result = JSON.parse(response)
    result
  rescue StandardError => e
    { 'status' => 'error', 'message' => e.message }
  end
end