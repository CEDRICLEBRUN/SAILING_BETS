class ResultsController < ApplicationController
  def index
    category = params[:category]
    if category.present?
      @boats = Boat.includes(:result).where(category: category).order('results.result_position')
    else
      @boats = Boat.all.includes(:result).order('results.result_position')
    end
    @result = Result.new
  end

  def new
  end

  def create
    @result = Result.new(result_params)
    @result.boat = Boat.find(params[:boat_id])

    if @result.save
      redirect_to results_path(category: @result.boat.category)
    else
      render 'results/index'
    end
  end

  def edit
  end

  def update
    @result = Result.find(params[:id])
    @result.update(result_params)
    redirect_to results_path(category: @result.boat.category)
  end

  def delete
  end

  private

  def index_boats(category)
    Boat.where(boat: { category: category }).sort_by(&:position)
  end

  def result_params
    params.require(:result).permit(:result_position)
  end
end
