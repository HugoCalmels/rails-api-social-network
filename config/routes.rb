Rails.application.routes.draw do

  resources :post_images
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
      resources :users 
      resources :post_images
          get "latest", to: 'posts#latest'
      get "removePostDisplay", to: 'posts#removePostDisplay'
      post "createAvatar", to: 'avatars#createAvatar'
      get "latestAvatar", to: 'avatars#latestAvatar'
      post "createThumbnail", to: 'thumbnails#createThumbnail'
      get "latestThumbnail", to: 'thumbnails#latestThumbnail'
      get "getAllPostImagesFromUser", to: 'posts#getAllPostImagesFromUser'
  
      resources :posts do
        
        resources :likes
        resources :comments
   
      end
    end
  end
end