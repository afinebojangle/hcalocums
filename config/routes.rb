Rails.application.routes.draw do
  
  devise_for :users
  
  root 'welcome#index'
  
  get '/dashboard', to: 'dashboard#index'
  
  get '/import_historical', to: 'import_historical#index'
  
  post '/import_historical', to: 'import_historical#create'
  
  get '/reconcile', to: 'reconcile#index'
  
  get '/reconcile_by_month', to: 'reconcile#month'
  
  
  
end
