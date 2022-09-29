class UpdateResultsJob < ApplicationJob
  require 'csv'
  require 'uri'
  queue_as :default


  def perform()
    puts 'Deleting results'

    Result.destroy_all

    puts 'Creating results'

    CSV.foreach('db/fixtures/official_results.csv', headers: :first_row) do |row|
      boat = Boat.where(name: row['boat_name']).first
      result = Result.new(
        result_position: row['result_position']
      )
      result.boat = boat
      result.save!
    end

    puts 'Creating results done'

    puts 'Calcul score in progress'

    score_calculation

    puts 'Calcul score done'
  end

  private
  def score_calculation
    players = User.includes(:bets).all

    players.each do |player|
      player.bets.each do |bet|
        bet.score_compute!
      end
    end

    players.each do |player|
      player.total_scores.first.calcul_score
    end
  end
end
