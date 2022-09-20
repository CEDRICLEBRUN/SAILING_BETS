class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bets, dependent: :destroy
  has_many :leagues, dependent: :destroy
  has_many :admissions, dependent: :destroy
  has_many :total_scores, dependent: :destroy
  has_one_attached :photo
  validates :first_name, :last_name, presence: true
  validates :bets, length: { maximum: 18 }

  def display_score_total
    scores = self.total_scores.first
    score_total = scores.ultim + scores.imoca + scores.ocean_fifty + scores.class_fourty + scores.rhum_mono + scores.rhum_multi
  end

  def display_score_by_category(category)
    scores = self.total_scores.first
    case category
    when "Ultim"
      score = scores.ultim
    when "IMOCA"
      score = scores.imoca
    when "Ocean Fifty"
      score = scores.ocean_fifty
    when "Class 40"
      score = scores.class_fourty
    when "Rhum Mono"
      score = scores.rhum_mono
    when "Rhum Multi"
      score = scores.rhum_multi
    end
    score
  end

  def all_scores_with_boat_category
    all_scores = []
    self.bets.each do |bet|
      all_scores << [bet.boat.category, bet.score]
    end
    all_scores
  end

  def self.accepted_in_league(league)
    owner = User.includes(:leagues).where(leagues: { id: league.id })
    accepted_users = User.includes(:admissions).where(admissions: { league: league, status: "accepted" })
    owner + accepted_users
    # players = []
    # all_users.each do |user|
    #   case type
    #   when "yellow_jersey"
    #     players << [user, user.total_scores.first.yellow_jersey]
    #   when "green_jersey"
    #     players << [user, user.total_scores.first.green_jersey]
    #   when "polka_dot_jersey"
    #     players << [user, user.total_scores.first.polka_dot_jersey]
    #   end
    # end
    # players
  end

  def bets_by_category(category)
    bets = []
    self.bets.each do |bet|
      bets << bet if bet.boat.category == category
    end
    bets
  end
end
