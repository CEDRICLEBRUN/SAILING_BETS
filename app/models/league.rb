class League < ApplicationRecord
  belongs_to :user
  has_many :admissions
  has_one_attached :logo

  def self.where_am_i(user)
    leagues = League.where(user: user)
    leagues_requested = League.includes(:admissions).where(admissions: {user: user})
    leagues + leagues_requested
  end
end
