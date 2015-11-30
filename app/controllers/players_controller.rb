class PlayersController < ApplicationController
  def show
    @user = User.find_by_account_id(params[:account_id])

    @matches = Match.joins(:players).includes({:players => :hero}, :lobby)
       .where("players.account_id" => @user.account_id)
       .order(:id=>:desc).page(params[:page])

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
end
