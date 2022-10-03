class UsersController < ApplicationController
  def dashboard
    @requests = Admission.joins(:league).where(status: "Pending", league: {user: current_user})
    @my_leagues = League.where_am_i(current_user)

    flash[:notice] = "Vous n'avez accès à aucune ligue... Pensez à rejoindre une ligue !" if params[:notice]
  end
end
