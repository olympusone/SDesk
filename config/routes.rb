Rails.application.routes.draw do
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

    root 'dashboard#index'#, constraints: lambda { |request| request.env['warden'].user.present?}
    # root 'tickets#new'

    resources :admins
    resources :agents

    resource :setting

    get '/knowledge-base', to: 'solutions#knowledge_base'
    resources :solutions
    resources :solution_folders
    resources :solution_categories

    resources :ticket_templates
    resources :tickets, shallow: true do
      resources :ticket_replies
    end

    resources :requesters
    resources :companies
    resources :departments, except: :show
  end
end
