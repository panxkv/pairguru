Rails.application.routes.draw do
  devise_for :users
  mount API::Base => "/api"

  root "home#welcome"
  get "movie_data/:id" => "movies#movie_data", as: :movie_data
  get "movie_poster/:id" => "movies#movie_poster", as: :movie_poster

  resources :genres, only: :index do
    member do
      get "movies"
    end
  end
  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end
end
