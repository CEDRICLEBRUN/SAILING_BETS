class CreateBets < ActiveRecord::Migration[7.0]
  def change
    create_table :bets do |t|
      t.integer :position
      t.integer :score
      t.references :user, null: false, foreign_key: true
      t.references :boat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
