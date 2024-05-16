class DogApi < ApplicationService
  require 'net/http'
  require 'json'

  DOG_API_BASE_URL = 'https://dog.ceo/api'.freeze

  def initialize(breed)
    @breed = breed
  end

  def call
    url = URI("#{DOG_API_BASE_URL}/breed/#{@breed.downcase}/images/random")
    response = Net::HTTP.get(url)
    result = JSON.parse(response)

    puts result
    result
  rescue StandardError => e
    puts "error"
    puts e.message
    { 'status' => 'error', 'message' => e.message }
  end
end