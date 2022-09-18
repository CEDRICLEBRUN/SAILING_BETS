class TotalScore < ApplicationRecord
  belongs_to :user

  def calcul_score
    self.ultim = 0
    self.imoca = 0
    self.ocean_fifty = 0
    self.class_fourty = 0
    self.rhum_mono = 0
    self.rhum_multi = 0
    scores = self.user.all_scores_with_boat_category
    scores.each do |score|
      case score.first
      when "Ultim"
        self.ultim += score.last
      when "IMOCA"
        self.imoca += score.last
      when "Ocean Fifty"
        self.ocean_fifty += score.last
      when "Class 40"
        self.class_fourty += score.last
      when "Rhum Mono"
        self.rhum_mono += score.last
      when "Rhum Multi"
        self.rhum_multi += score.last
      end
    end
    self.save
  end
end
