class PlayersController < ApplicationController
  def show
    @user = User.find_by_account_id(params[:account_id])
    @matches = Match.joins(:players).where("players.account_id" => @user.account_id).order(:id=>:desc).page(params[:page])
  end
end
