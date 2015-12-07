Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }, :skip => [:sessions]
  scope "(:locale)", locale: /en|ru/ do

    devise_scope :user do
      delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
    end

    root 'main#index'

    match 'matches/:id' => 'matches#show', :as => :match, :via => [:get]

    match 'players/:account_id' => 'players#show', :as => :player, :via => [:get]
    get 'players/:account_id/matches', to: "players#matches", as: :player_matches

    get 'players/:account_id/heroes_vs' => "players#heroes_vs", as: :heroes_vs
    get 'players/:account_id/heroes_vs/:id' => "players#heroes_vs_show", as: :hero_vs
    get 'players/:account_id/records' => "players#records", as: :player_records

  end
end
