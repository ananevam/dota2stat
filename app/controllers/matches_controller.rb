class MatchesController < ApplicationController
  def show
    @match = Match.includes(:players => [:user, :hero, :items]).find(params[:id])
    @match.generate_map! if @match.map_picture_file_name.nil?
  end
end
