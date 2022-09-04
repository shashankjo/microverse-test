require('sidekiq/web')

Rails.application.routes.draw do
  resources :users, only: [:index, :show, :fetch_data, :delete_data]
  post 'users/fetch_data', to: 'users#fetch_data'
  post 'users/delete_data', to: 'users#delete_data'
  get 'users/show/:id', to: 'users#show', as: 'show'
  #get 'logout', to: 'sessions#destroy', as: 'logout'
  #mount ApplicationApi, at: '/'

  # Sidekiq UI
  mount ::Sidekiq::Web => '/sidekiq' #if ['staging', 'development'].include?(Rails.env)

  get '/status', to: proc { [200, {}, ['OK']] }
end
