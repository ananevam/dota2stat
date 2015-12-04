class HeroesController < ApplicationController
  def index
    @heroes = Hero.order(:localized_name => :asc)
  end

  def show
    @hero = Hero.find params[:id]
    my_team_kills = Player.where(:account_id => current_user.account_id).where(:hero_id => @hero.id)
  end
end
