class League < ApplicationRecord
  belongs_to :user
  has_many :admissions, dependent: :destroy
  has_one_attached :logo

  def self.where_am_i(user)
    leagues = League.where(user: user)
    leagues_requested = League.includes(:admissions).where(admissions: {user: user})
    leagues + leagues_requested
  end

  def self.where_am_i_accepted(user)
    leagues = League.where(user: user)
    leagues_requested = League.includes(:admissions).where(admissions: {user: user, status: "accepted"})
    leagues + leagues_requested
  end

  def self.where_am_i_not(user)
    leagues = League.where.not(user: user)
    leagues - League.includes(:admissions).where(admissions: {user: user})
  end
end
