Rails.application.routes.draw do
  resources :users, except: [:new, :edit]

  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout'
  post '/signup', to: 'users#signup'

end
