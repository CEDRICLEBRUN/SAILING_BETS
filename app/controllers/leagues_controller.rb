class LeaguesController < ApplicationController
  def index
    @leagues = League.where(user: current_user)
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)
    @league.user = current_user
    if @league.save
      redirect_to leagues_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def league_params
    params.require(:league).permit(:title)
  end
end
