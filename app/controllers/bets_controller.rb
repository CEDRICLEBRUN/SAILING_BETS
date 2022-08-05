class BetsController < ApplicationController
  def index
    @bets = Bet.where(user: current_user)
  end

  def new
  end

  def create
  end
end
