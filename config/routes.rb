Rails.application.routes.draw do


 
  
  resources :thumbnails
  resources :avatars
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  get '/member-data', to: 'members#show'

  namespace :api do
    namespace :v1 do
      resources :users do
      
      
        resources :friendships
       
        
            end
            resources :profiles
      resources :invitations
      resources :friendships
      resources :post_images

      get "getAllUsernames", to: 'users#getAllUsernames'
      get "updateLastSeen", to: 'users#updateLastSeen'
      delete "destroyMutualFriendship", to: 'friendships#destroyMutualFriendship'
      get "getAllPostImagesFromUser", to: 'posts#getAllPostImagesFromUser'
      
          get "latest", to: 'posts#latest'
      get "removePostDisplay", to: 'posts#removePostDisplay'
      post "createAvatar", to: 'avatars#createAvatar'
      get "latestAvatar", to: 'avatars#latestAvatar'
      post "createThumbnail", to: 'thumbnails#createThumbnail'
      get "latestThumbnail", to: 'thumbnails#latestThumbnail'

  
      resources :posts do
        
        resources :likes
        resources :comments
   
      end
    end
  end
end