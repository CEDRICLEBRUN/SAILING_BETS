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

  after_create :set_total_score

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

  def self.accepted_in_league(league, category)
    owner = User.includes(:leagues).where(leagues: { id: league.id })
    accepted_users = User.includes(:admissions).where(admissions: { league: league, status: "accepted" })
    owner + accepted_users
    all_users = owner + accepted_users
    all_players = []
    all_users.each do |user|
      case category
      when nil
        all_players << [user, user.display_score_total]
      else
        all_players << [user, user.display_score_by_category(category)]
      end
    end
    players = all_players.sort_by { |el| el[1] }
  end

  def bets_by_category(category)
    bets = []
    self.bets.order(:position).each do |bet|
      bets << bet if bet.boat.category == category
    end
    bets
  end

  private

  def set_total_score
    TotalScore.create(user: self)
  end
end
