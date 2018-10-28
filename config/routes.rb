Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      devise: 'users/devise',
      passwords: 'users/passwords',
      confirmations: 'users/confirmations',
      registrations: 'users/registrations',
      unlocks: 'users/unlocks'
  }

  devise_scope :user do
    unauthenticated do
      root 'devise/sessions#new'
    end

    get '/login', to: 'devise/sessions#new'
  end

  authenticated :user do
    root 'dashboard#index' , constraints: lambda { |request| !request.env['warden'].user.role?(:requester)}
    root 'tickets#index'
  end

  resources :admins, except: :show
  resources :agents

  resource :setting, except: :show

  scope 'knowledge-base', controller: 'solutions' do
    get '/', action: 'knowledge_base', as: :knowledge_base
    get 'search', action: 'search', as: :knowledge_base_search
  end

  resources :solutions
  resources :solution_folders
  resources :solution_categories

  resources :ticket_templates
  resources :tickets, except: :show, shallow: true do
    resources :ticket_replies, only: [:new, :create, :show]
  end

  resources :requesters
  resources :companies, except: :show
  resources :departments, except: :show
end
