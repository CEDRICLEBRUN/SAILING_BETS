class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :boat

  validates :boat, :position, presence: true
  validates :user_id, uniqueness: { scope: :boat_id,
    message: "Vous ne pouvez choisir un bateau qu'une seule fois" }

  def score_compute!
    boat = Boat.find(self.boat.id)
    if boat.result == nil
      self.score = 100
    elsif boat.result.result_position == self.position
      self.score = self.position - 3
    elsif boat.result.result_position in 1..3
      self.score = boat.result.result_position - 1
    else
      case boat.category
      when "Ultim"
        self.score = boat.result.result_position
      when "IMOCA"
        self.score = boat.result.result_position
      when "Ocean Fifty"
        self.score = boat.result.result_position
      when "Class 40"
        self.score = boat.result.result_position
      when "Rhun Mono"
        self.score = boat.result.result_position
      when "Rhum Multi"
        self.score = boat.result.result_position
      end
    end
    self.save!
  end
end
