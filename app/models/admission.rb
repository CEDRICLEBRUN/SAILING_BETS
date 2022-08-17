class Admission < ApplicationRecord
  belongs_to :user
  belongs_to :league

  validates :user_id, uniqueness: { scope: :league_id,
    message: "Vous ne pouvez vous inscrire qu'une seule fois" }
end
