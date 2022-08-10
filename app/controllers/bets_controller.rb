class BetsController < ApplicationController
  def index
    @ultims = index_boat("Ultim")
    @imocas = index_boat("IMOCA")
    @ocean_fifties = index_boat("Ocean Fifty")
    @class_40s = index_boat("Class 40")
    @rhum_monos = index_boat("Rhum Mono")
    @rhum_multis = index_boat("Rhum Multi")
  end

  def new
  end

  def create
    # first bet
    boat_name = bet_params["skipper_1"].split("-").first.chop
    create_bet(1, boat_name)

    #second bet
    boat_name = bet_params["skipper_2"].split("-").first.chop
    create_bet(2, boat_name)

    # third bet
    boat_name = bet_params["skipper_3"].split("-").first.chop
    create_bet(3, boat_name)

    redirect_to bets_path
  end

  private

  def bet_params
    params.permit(:skipper_1, :skipper_2, :skipper_3)
  end

  def create_bet(position, boat_name)
    bet = Bet.new
    bet.position = position
    bet.user = current_user
    bet.boat = Boat.where(name: boat_name).first
    bet.save!
  end

  def index_boat(category)
    Bet.includes(:boat).where(user: current_user, boat: { category: category }).sort_by(&:position)
  end
end
