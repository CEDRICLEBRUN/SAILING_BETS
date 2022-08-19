class AdmissionsController < ApplicationController
  def create
    @admission = Admission.new
    @admission.user = current_user
    @admission.league = League.find(params[:league_id])
    @admission.save
    redirect_to leagues_path
  end

  def delete
    admission = Admission.find(params['admission'])
    admission.destroy
    redirect_to leagues_path(choice: 'all_leagues')
  end

  def accept
    @admission = Admission.find(params[:id])
    @admission.status = "accepted"
    @admission.save
    redirect_to users_dashboard_path
  end

  def reject
    @admission = Admission.find(params[:id])
    @admission.status = "rejected"
    @admission.save
    redirect_to users_dashboard_path
  end
end
