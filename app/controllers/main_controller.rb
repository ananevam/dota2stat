
class MainController < ApplicationController
  def index
    @matches = Match.includes({:players => :hero}, :mode, :lobby).order(:id => :desc).page(params[:page])
  end
end
