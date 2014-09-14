Rails.application.routes.draw do
  root 'lessons#index'
  devise_for :users
  resources :lessons, only: :index do
    post 'watch', on: :member
  end
end
