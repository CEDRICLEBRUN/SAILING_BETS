class LeaguesController < ApplicationController
  def index
    @leagues = League.where_am_i_not(current_user)
    @admission = Admission.new
  end

  def show
    if League.find(params[:id]).admissions.where(user: current_user, status: "accepted").present? || League.find(params[:id]).user == current_user
      @league = League.find(params[:id])
      @admissions = Admission.where(league: @league, status: "accepted")
      @users = User.accepted_in_league(@league, params[:category])
      @my_leagues = League.where_am_i(current_user)
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
    params.require(:league).permit(:title, :logo)
  end

  def score_calculation
    players = User.includes(:bets).all

    players.each do |player|
      player.bets.each do |bet|
        bet.score_compute!
      end
    end

    players.each do |player|
      player.total_scores.first.calcul_score
    end
  end
end
