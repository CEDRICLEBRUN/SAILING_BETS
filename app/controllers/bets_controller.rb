class BetsController < ApplicationController
  def index
    @ultims = index_boat('Ultim')
    @imocas = index_boat('IMOCA')
    @ocean_fifties = index_boat('Ocean Fifty')
    @class_40s = index_boat('Class 40')
    @rhum_monos = index_boat('Rhum Mono')
    @rhum_multis = index_boat('Rhum Multi')
  end

  def new
    if Time.now > Time.new(2022,11,8,13,01)
      redirect_to bets_path, alert: "La course est partie, il est trop tard pour faire tes paris..."
    end
  end

  def create
    if bet_params['skipper_1'] == '' || bet_params['skipper_2'] == '' || bet_params['skipper_3'] == ''
      flash.now.alert = 'Les 3 bateaux doivent être sélectionnés'
      render 'bets/new', status: :unprocessable_entity
    else
      # first bet
      boat_name = bet_params['skipper_1'].reverse.split(' - ', 2).last.reverse
      first_bet = create_bet(1, boat_name)

      # second bet
      boat_name = bet_params['skipper_2'].reverse.split(' - ', 2).last.reverse
      second_bet = create_bet(2, boat_name)

      # third bet
      boat_name = bet_params['skipper_3'].reverse.split(' - ', 2).last.reverse
      third_bet = create_bet(3, boat_name)

      if first_bet && second_bet && third_bet
        redirect_to bets_path, notice: 'Pari pris en compte !'
      else
        delete_incomplete_bets
        flash.now.alert = "Vous ne pouvez choisir un bateau qu'une seule fois"
        render :new, status: :unprocessable_entity
      end
    end
  end

  def change
    if Time.now > Time.new(2022,11,8,13,02)
      redirect_to bets_path, alert: "La course est partie, il est trop tard pour modifier tes paris..."
    end
  end

  def modify
    if bet_params['skipper_1'] == '' || bet_params['skipper_2'] == '' || bet_params['skipper_3'] == ''
      delete_incomplete_bets
      flash[:alert] = 'Les 3 bateaux doivent être sélectionnés'
      render 'bets/change', status: :unprocessable_entity
    else
      Bet.includes(:boat).where(user: current_user, boat: { category: bet_params['category'] }).destroy_all

      # first bet
      boat_name = bet_params['skipper_1'].reverse.split(' - ', 2).last.reverse
      first_bet = create_bet(1, boat_name)

      # second bet
      boat_name = bet_params['skipper_2'].reverse.split(' - ', 2).last.reverse
      second_bet = create_bet(2, boat_name)

      # third bet
      boat_name = bet_params['skipper_3'].reverse.split(' - ', 2).last.reverse
      third_bet = create_bet(3, boat_name)

      if first_bet && second_bet && third_bet
        redirect_to bets_path, notice: 'Pari modifié et pris en compte !'
      else
        delete_incomplete_bets
        flash.now.alert = "Vous ne pouvez choisir un bateau qu'une seule fois"
        render :change, status: :unprocessable_entity
      end
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
    bet.save
  end

  def index_boat(category)
    Bet.includes(:boat).where(user: current_user, boat: { category: category }).sort_by(&:position)
  end

  def delete_incomplete_bets
    Bet.includes(:boat).where(user: current_user, boat: { category: bet_params['category'] }).destroy_all
  end
end
