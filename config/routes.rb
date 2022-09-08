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
      get "selectedUserCM/:username", to: 'common_friendships#selectedUserCM'
      resources :users do
        resources :friendships
        resources :common_friendships
        resources :suggestions
      end
      resources :profiles
      resources :invitations
      resources :friendships
      resources :post_images
      get "getUserByEmail/:email", to: 'users#getUserByEmail'
      get "getAllUsernames", to: 'users#getAllUsernames'
      get "updateLastSeen/:time", to: 'users#updateLastSeen'
      delete "destroyMutualFriendship", to: 'friendships#destroyMutualFriendship'
      get "getAllPostImagesFromUser", to: 'posts#getAllPostImagesFromUser'
      get "latest", to: 'posts#latest'
      get "removePostDisplay", to: 'posts#removePostDisplay'
      post "createAvatar", to: 'avatars#createAvatar'
      get "latestAvatar", to: 'avatars#latestAvatar'
      post "createThumbnail", to: 'thumbnails#createThumbnail'
      get "latestThumbnail", to: 'thumbnails#latestThumbnail'
      get "getOnlySelectedUserPosts/:username", to: 'posts#getOnlySelectedUserPosts'
    
      resources :posts do
        get 'page/:page', action: :index, on: :collection
        get "getOnlySelectedUserPosts/page/:page/:username", action: :getOnlySelectedUserPosts, on: :collection
        resources :likes
        resources :comments
      end
    end
  end
end