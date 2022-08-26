class LeaguesController < ApplicationController
  def index
    @leagues = League.all
    @my_leagues = League.where(user: current_user)
    @admission = Admission.new
    @admissions = Admission.where(user: current_user)
  end

  def show
    if League.find(params[:id]).admissions.where(user: current_user, status: "accepted").present? || League.find(params[:id]).user == current_user
      @league = League.find(params[:id])
      @admissions = Admission.where(league: @league, status: "accepted")
      @bets = Bet.all
      score_calculation
    else
      flash[:alert] = "Pas accès à cette ligue..."
      redirect_to leagues_path
    end
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

  def score_calculation
    players = User.includes(:bets).all

    players.each do |player|
      player.bets.each do |bet|
        bet.score_compute!
      end
    end
  end
end
