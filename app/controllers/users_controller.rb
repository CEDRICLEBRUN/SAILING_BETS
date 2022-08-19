class UsersController < ApplicationController
  def dashboard
    @requests = Admission.joins(:league).where(league: {user: current_user})
  end
end
