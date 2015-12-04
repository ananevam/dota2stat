class PlayersController < ApplicationController
  before_action :before_action

  def before_action
    @user = User.find_by_account_id(params[:account_id])
  end

  def show
    @matches = matches_by_account_id(@user.account_id).limit(15)

    @most_played_heroes = Player.find_by_sql(
        ["SELECT players.*, COUNT(hero_id) as count_games, heroes.name as hero_name
          FROM players
          INNER JOIN heroes ON players.hero_id = heroes.id
          WHERE account_id = (?)
          GROUP BY hero_id
          ORDER BY count_games DESC
          LIMIT 10
        ", @user.account_id]
    )
    ActiveRecord::Associations::Preloader.new.preload(@most_played_heroes, :hero)
  end

  def matches
    @matches = matches_by_account_id(params[:account_id]).page(params[:page])
  end


  def heroes_vs
    @heroes = Hero.order(:localized_name => :asc)
  end

  def heroes_vs_show
    @hero = Hero.find params[:id]

    @enemy_team = {}
    @enemy_team[:count] = enemy_team(params[:account_id], @hero.id).count
    @enemy_team[:kills] = enemy_team(params[:account_id], @hero.id).sum("players2.kills")
    @enemy_team[:deaths] = enemy_team(params[:account_id], @hero.id).sum("players2.deaths")
    @enemy_team[:assists] = enemy_team(params[:account_id], @hero.id).sum("players2.assists")

    @my_team = {}
    @my_team[:count] = my_team(params[:account_id], @hero.id).count
    @my_team[:kills] = my_team(params[:account_id], @hero.id).sum("players2.kills")
    @my_team[:deaths] = my_team(params[:account_id], @hero.id).sum("players2.deaths")
    @my_team[:assists] = my_team(params[:account_id], @hero.id).sum("players2.assists")
  end

  private
  def matches_by_account_id account_id
    Match.joins(:players).includes({:players => :hero}, :lobby)
      .where("players.account_id" => account_id)
      .order(:id=>:desc)
  end

  def my_team account_id, hero_id
    Player
        .joins("LEFT JOIN players AS players2 ON players.match_id = players2.match_id AND players.team = players2.team")
        .where("players.account_id" => account_id).where("players2.hero_id" => hero_id)
  end
  def enemy_team account_id, hero_id
    Player
        .joins("LEFT JOIN players AS players2 ON players.match_id = players2.match_id AND players.team != players2.team")
        .where("players.account_id" => current_user.account_id).where("players2.hero_id" => hero_id)
  end
end
