Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'themes#index'

  resources :themes, only: [:index, :show] do
    get 'posts', on: :collection
  end
end
