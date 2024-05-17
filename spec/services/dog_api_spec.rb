require 'rails_helper'

RSpec.describe DogApi, type: :service do
  describe '.call' do
    let(:breed) { 'beagle' }

    context 'when the breed exists' do
      before do
        response = {
          status: 'success',
          message: 'https://images.dog.ceo/breeds/labrador/n02099712_9596.jpg'
        }.to_json

        stub_request(:get, "https://dog.ceo/api/breed/#{breed}/images/random")
          .to_return(status: 200, body: response, headers: {})
      end

      it 'returns the image URL' do
        result = described_class.call(breed)
        expect(result['status']).to eq('success')
        expect(result['message']).to eq('https://images.dog.ceo/breeds/labrador/n02099712_9596.jpg')
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

      it 'returns an error message' do
        result = described_class.call(breed)
        expect(result['status']).to eq('error')
        expect(result['message']).to eq('Breed not found')
      end
    end

    context 'when there is a network error' do
      before do
        stub_request(:get, "https://dog.ceo/api/breed/#{breed}/images/random")
          .to_raise(StandardError.new('Network error'))
      end

      it 'returns a network error message' do
        result = described_class.call(breed)
        expect(result['status']).to eq('error')
        expect(result['message']).to eq('Network error')
      end
    end
  end
end
