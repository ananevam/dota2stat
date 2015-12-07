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
    @enemy_team[:kda] = enemy_team(params[:account_id], @hero.id)
        .select("(SUM(players2.kills) + SUM(players2.assists)) / IF(SUM(players2.deaths)=0,1,SUM(players2.deaths)) as kda_value")[0].kda_value.to_f

    @enemy_team[:gold_earned] = enemy_team(params[:account_id], @hero.id).joins(:match)
        .sum("(players2.gold_per_min / 60 * matches.duration)").to_i / (@enemy_team[:count] == 0 ? 1 : @enemy_team[:count])

    @enemy_team[:last_hits] = enemy_team(params[:account_id], @hero.id)
        .select("AVG(players2.last_hits) as last_hits_value")[0].last_hits_value.to_i
    @enemy_team[:hero_damage] = enemy_team(params[:account_id], @hero.id)
        .select("AVG(players2.hero_damage) as hero_damage_value")[0].hero_damage_value.to_i

    @my_team = {}
    @my_team[:count] = my_team(params[:account_id], @hero.id).count
    @my_team[:kda] = my_team(params[:account_id], @hero.id)
        .select("(SUM(players2.kills) + SUM(players2.assists)) / IF(SUM(players2.deaths)=0,1,SUM(players2.deaths)) as kda_value")[0].kda_value.to_f

    @my_team[:gold_earned] = my_team(params[:account_id], @hero.id).joins(:match)
        .sum("(players2.gold_per_min / 60 * matches.duration)").to_i / (@my_team[:count] == 0 ? 1 : @my_team[:count])

    @my_team[:last_hits] = my_team(params[:account_id], @hero.id)
        .select("AVG(players2.last_hits) as last_hits_value")[0].last_hits_value.to_i
    @my_team[:hero_damage] = my_team(params[:account_id], @hero.id)
        .select("AVG(players2.hero_damage) as hero_damage_value")[0].hero_damage_value.to_i
  end

  def records
    @longest = Match.joins(:players).where("players.account_id" => @user.account_id).order(:duration => :desc).first
    @max_kills = Player.where(:account_id => @user.account_id).order(:kills => :desc).first
    @max_assists = Player.where(:account_id => @user.account_id).order(:assists => :desc).first
    @max_last_hits = Player.where(:account_id => @user.account_id).order(:last_hits => :desc).first
    @max_denies = Player.where(:account_id => @user.account_id).order(:denies => :desc).first
    @max_gold = Player.joins(:match).where(:account_id => @user.account_id)
      .select("(gold_per_min / 60 * matches.duration) as all_gold, players.*").order("all_gold DESC").first
    @max_xp = Player.joins(:match).where(:account_id => @user.account_id)
      .select("(xp_per_min * (matches.duration/60)) as all_xp, players.*").order("all_xp DESC").first
    @max_hd = Player.where(:account_id => @user.account_id).order(:hero_damage => :desc).first
    @max_hh = Player.where(:account_id => @user.account_id).order(:hero_healing => :desc).first
    @max_td = Player.where(:account_id => @user.account_id).order(:tower_damage => :desc).first
    @max_kda = Player.select("players.*, ((players.kills + players.assists) / IF(players.deaths=0,1,players.deaths)) as kda_value")
      .where(:account_id => @user.account_id).order("kda_value DESC").first
  end

  private
  def matches_by_account_id account_id
    Match.joins(:players).includes({:players => :hero}, :lobby)
        .where("players.account_id" => account_id)
        .order(:id => :desc)
  end

  def my_team account_id, hero_id
    Player
        .joins("LEFT JOIN players AS players2 ON players.match_id = players2.match_id AND players.team = players2.team")
        .where("players.account_id" => account_id).where("players2.hero_id" => hero_id)
  end

  def enemy_team account_id, hero_id
    Player
        .joins("LEFT JOIN players AS players2 ON players.match_id = players2.match_id AND players.team != players2.team")
        .where("players.account_id" => account_id).where("players2.hero_id" => hero_id)
  end
end
