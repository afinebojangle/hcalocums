Rails.application.routes.draw do
  
  devise_for :users
  
  root 'welcome#index'
  
  get '/dashboard', to: 'dashboard#index'
  
  
  
end
