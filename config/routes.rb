Rails.application.routes.draw do


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  authenticated :user do
    root to: "videos#latest", as: :authenticated_root
  end

  root to: redirect('/sign_in')

  resources :videos
  get 'latest/videos' => 'videos#latest'

  resources :operations

  resources :years do
    resources :months
  end

  resources :recruit_contacts
  get 'search/recruit_contacts' => 'recruit_contacts#search_name'

  resources :recruit_requirements
  resources :roles

  resources :members, only: [:index, :show]
  get 'members/add_new_api'
  get 'members/add_temporary_member'
  get 'refresh_member_list' => 'members#refresh_member_list'

  resources :fac_war_systems, only: [:index]
  get 'refresh_fac_war_systems' => 'fac_war_systems#refresh_fac_war_systems'
end
