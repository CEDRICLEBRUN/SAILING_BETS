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

    if bet_params["skipper_1"] == "" || bet_params["skipper_2"] == "" || bet_params["skipper_3"] == ""
      flash[:alert] = "Les 3 bateaux doivent être sélectionnés"
      render 'bets/new'
    else
    # first bet
      boat_name = bet_params["skipper_1"].split("-").first.chop
      create_bet(1, boat_name)

      #second bet
      boat_name = bet_params["skipper_2"].split("-").first.chop
      create_bet(2, boat_name)

      # third bet
      boat_name = bet_params["skipper_3"].split("-").first.chop
      create_bet(3, boat_name)

      redirect_to bets_path, notice: "Pari pris en compte !"
    end
  end

  def change
  end

  def modify
    if bet_params["skipper_1"] == "" || bet_params["skipper_2"] == "" || bet_params["skipper_3"] == ""
      flash[:alert] = "Les 3 bateaux doivent être sélectionnés"
      render 'bets/change'
    else
      bets = Bet.includes(:boat).where(user: current_user, boat: { category: bet_params["category"] })
      bets.each do |bet|
        bet.delete
      end

      # first bet
      boat_name = bet_params["skipper_1"].split("-").first.chop
      create_bet(1, boat_name)

      #second bet
      boat_name = bet_params["skipper_2"].split("-").first.chop
      create_bet(2, boat_name)

      # third bet
      boat_name = bet_params["skipper_3"].split("-").first.chop
      create_bet(3, boat_name)

      redirect_to bets_path, notice: "Pari modifié et pris en compte !"
    end
  end

  private

  def bet_params
    params.permit(:skipper_1, :skipper_2, :skipper_3, :category)
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
