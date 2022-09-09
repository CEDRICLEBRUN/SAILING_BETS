class UsersController < ApplicationController
  def dashboard
    @requests = Admission.joins(:league).where(status: "pending", league: {user: current_user})
    @my_leagues = League.where_am_i(current_user)
  end
end
