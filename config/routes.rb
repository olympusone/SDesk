Rails.application.routes.draw do
  resources :solutions
  resources :solution_folders
  resources :solution_categories
  resources :ticket_replies
  resources :ticket_templates
  resources :tickets
  resources :requesters
  resources :companies
  resources :departments
  resources :agents
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      devise: 'users/devise',
      passwords: 'users/passwords',
      confirmations: 'users/confirmations',
      registrations: 'users/registrations',
      unlocks: 'users/unlocks'
  }

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    devise_scope :user do
      get '/admin', to: 'devise/sessions#new'
    end

    root 'dashboard#index'

    resources :users
    resource :setting
  end
end
