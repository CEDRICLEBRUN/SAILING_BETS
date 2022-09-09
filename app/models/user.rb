class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bets
  has_many :leagues
  has_many :admissions
  has_many :total_scores
  has_one_attached :photo
  validates :first_name, :last_name, presence: true

  def display_score_total
    scores = self.total_scores.first
    score_total = scores.ultim + scores.imoca + scores.ocean_fifty + scores.class_fourty + scores.rhum_mono + scores.rhum_multi
  end

  def all_scores_with_boat_category
    all_scores = []
    self.bets.each do |bet|
      all_scores << [bet.boat.category, bet.score]
    end
    all_scores
  end
end
