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
    resources :search, only: [:index]
    resources :opentok_callback, only: [:create]
    post '/facebook/login', to: 'facebooks#create'

    resources :stories, controller: 'story/stories' do
      resources :comments, controller: 'story/comments', only: [:index, :create, :destroy, :update]
      resources :likes, controller: 'story/likes', only: [:create, :destroy]
    end

    resources :videos, controller: 'videos/videos', only: [:index, :show] do
      resources :comments, controller: 'videos/comments', only: [:index, :create, :destroy, :update]
      resources :likes, controller: 'videos/likes', only: [:create, :destroy]
    end

    resources :photos, controller: 'photos/photos' do
      resources :comments, controller: 'photos/comments', only: [:index, :create, :destroy, :update]
      resources :likes, controller: 'photos/likes', only: [:create, :destroy]
    end
      
    resources :members , only: [:index, :show] do
      resources :following, only: [:index]
      resources :followers, only: [:index]
      resources :family, only: [:index, :create, :destroy]
      resources :follow, only: [:create] 
      resources :unfollow, only: [:create] 
      resources :stories, only: [:index, :show], controller: 'story/stories'
      resources :photos, only: [:index, :show], controller: 'photos/photos'
      resources :videos, only: [:index], controller: 'videos/videos'
      resources :favourites, only: [:index, :create]
      resources :invite, only: [:create], controller: 'member/invite'
    end
    match '/members/:member_id/favourites', to: 'favourites#destroy', via: 'delete', defaults: { id: nil }

    resources :populars, only: [:index]


    namespace :user do
      resources :followers, only: [:index]
      resources :following, only: [:index]
      resources :family, only: [:index]
      resource :profile, only:   [:show, :update]
      resources :videos, only: [:index]
      resources :photos, only: [:create]
      resources :albums, only: [:index] do
        resources :photos, only: [:index, :show, :destroy] do
          resources :comments, controller: 'photos/comments', only: [:index]
        end  
      end  
      resources :stories do
        resources :comments, controller: 'story/comments', only: [:index]        
      end
      # Live stream
      resource :live_session, controller: 'live_session', only: [:show, :create, :destroy]
      resource :golive_session, controller: 'golive_session', only: [:create]
      resources :live_notify, only: [:create]
      resources :devices, only: [:index, :create, :destroy]
      post '/stories/arrange', to: 'stories#arrange'  
    end  

  end
end
