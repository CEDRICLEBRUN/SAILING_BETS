class BoatsController < ApplicationController
  def index
    @boats = Boat.all.sort_by(&:name)

    category = params[:category]
    if category.present?
      @boats = Boat.where(category: category).sort_by(&:name)
    end
  end
end
