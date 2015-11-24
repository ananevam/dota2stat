
class MainController < ApplicationController
  def index
    @matches = Match.all
  end
end
