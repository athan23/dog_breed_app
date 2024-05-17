require 'rails_helper'

RSpec.describe DogsController, type: :controller do
  describe 'GET #fetch_breed_image' do
    let(:breed) { 'labrador' }

    context 'when the breed exists' do
      before do
        response = {
          status: 'success',
          message: 'https://images.dog.ceo/breeds/labrador/n02099712_9596.jpg'
        }.to_json

        stub_request(:get, "https://dog.ceo/api/breed/#{breed}/images/random")
          .to_return(status: 200, body: response, headers: {})
      end

      it 'returns a successful response with the image URL' do
        get :fetch_breed_image, params: { breed: breed }, format: :turbo_stream
        expect(response).to be_successful
        expect(assigns(:image_url)).to eq('https://images.dog.ceo/breeds/labrador/n02099712_9596.jpg')
        expect(assigns(:breed)).to eq(breed)
      end
    end

    context 'when the breed does not exist' do
      let(:breed) { 'unknownbreed' }

      before do
        response = {
          status: 'error',
          message: 'Breed not found'
        }.to_json

        stub_request(:get, "https://dog.ceo/api/breed/#{breed}/images/random")
          .to_return(status: 404, body: response, headers: {})
      end

      it 'returns an error response' do
        get :fetch_breed_image, params: { breed: breed }, format: :turbo_stream
        expect(response).to be_successful
        expect(assigns(:image_url)).to be_nil
        expect(assigns(:breed)).to eq(breed)
      end
    end
  end
end
