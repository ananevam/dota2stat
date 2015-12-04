Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }, :skip => [:sessions]
  scope "(:locale)", locale: /en|ru/ do

    devise_scope :user do
      delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
    end

    root 'main#index'

    match 'matches/:id' => 'matches#show', :as => :match, :via => [:get]
    get 'heroes' => "heroes#index", as: :heroes
    get 'heroes/:id' => "heroes#show", as: :hero

    match 'players/:account_id' => 'players#show', :as => :player, :via => [:get]
    get 'players/:account_id/matches', to: "players#matches", as: :player_matches
  end
end
