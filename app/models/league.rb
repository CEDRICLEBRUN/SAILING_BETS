require "open-uri"

class League < ApplicationRecord
  belongs_to :user
  has_many :admissions, dependent: :destroy
  has_one_attached :logo
  before_save :assign_logo
  validates :title, presence: true
  validates :title, length: { minimum: 3, maximum: 30 }
  validates :title, uniqueness: true


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

  private

  def assign_logo
    return if logo.attached?

    defaultlogo = URI.open('https://res.cloudinary.com/dciokrtia/image/upload/v1664789109/logo_mvhufs.png')
    logo.attach(io: defaultlogo, filename: 'logo.png', content_type: 'image/png')
  end

end
