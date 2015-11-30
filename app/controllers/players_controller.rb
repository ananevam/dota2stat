class PlayersController < ApplicationController
  before_action :before_action

  def before_action
    @user = User.find_by_account_id(params[:account_id])
  end

  def show
    @last_matches = matches_by_account_id(@user.account_id).limit(15)

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
    @last_matches = matches_by_account_id(params[:account_id]).page(params[:page])
  end

  private
  def matches_by_account_id account_id
    Match.joins(:players).includes({:players => :hero}, :lobby)
      .where("players.account_id" => account_id)
      .order(:id=>:desc)
  end
end
