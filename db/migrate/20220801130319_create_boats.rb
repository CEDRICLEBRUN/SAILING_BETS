class CreateBoats < ActiveRecord::Migration[7.0]
  def change
    create_table :boats do |t|
      t.string :name
      t.string :skipper_first_name
      t.string :skiper_last_name
      t.string :skipper_nationality
      t.string :category

      t.timestamps
    end
  end
end
