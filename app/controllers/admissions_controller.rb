class AdmissionsController < ApplicationController
  def create
    @admission = Admission.new
    @admission.user = current_user
    @admission.league = League.find(params[:league_id])
    @admission.save
    redirect_to leagues_path
  end

  def delete
  end
end
