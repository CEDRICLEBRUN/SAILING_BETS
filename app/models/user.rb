class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bets
  has_many :leagues
  has_many :admissions

  def display_score_total
    total_score = 0
    self.bets.each do |bet|
      total_score += bet.score
    end
    return total_score
  end
end
