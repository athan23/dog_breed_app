Rails.application.routes.draw do
  root "dogs#index"
  post 'dogs/fetch_breed_image', to: 'dogs#fetch_breed_image'
end
