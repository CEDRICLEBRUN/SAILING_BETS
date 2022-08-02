class Boat < ApplicationRecord
  has_many :bets
  has_many :results
end
