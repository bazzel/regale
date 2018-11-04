Rails.application.routes.draw do
  resources :events
  get 'sign_in', to: 'sessions#new', as: :signin
  post 'sign_in', to: 'sessions#create'
  get '/sign_in/:token', to: 'sessions#show', as: :token_sign_in
  delete '/sign_out', to: 'sessions#destroy', as: :sign_out


  get 'welcome/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#show'
end
