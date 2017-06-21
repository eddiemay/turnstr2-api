Rails.application.routes.draw do
  resources :controllers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  # To display resque-scheduler tab in web UI app, by default its hidden
  require 'resque-scheduler'
  require 'resque/scheduler/server'

  # To display history tab in resque UI
  require 'resque-history/server'

  # To access resque UI as localhost:3000/resque then username = devzila and password= devzila1234
  mount Resque::Server, at: '/resque'

  namespace :v1, defaults: { format: :json } do
    get '/ping', to: 'ping#show'
    resource  :sessions,   only:   [:show, :create, :destroy]
    resource :signup, only: [:create]

    resources :stories do
      resources :comments, controller: 'story/comments'
    end


    namespace :user do
      resource :profile, only:   [:show, :update]
      resources :photos do
        resources :comments
      end  
      resources :stories do
        resources :comments
      end  
    end  

  end
end
