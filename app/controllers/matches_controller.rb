class MatchesController < ApplicationController
  def show
    @match = Match.includes(:players => [:user, :hero, :items]).find(params[:id])
  end
end
