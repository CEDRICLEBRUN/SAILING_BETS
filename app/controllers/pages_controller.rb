class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @start_time = Time.new(2022,11,9,14,15)
  end
end
