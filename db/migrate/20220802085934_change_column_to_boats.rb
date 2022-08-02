class ChangeColumnToBoats < ActiveRecord::Migration[7.0]
  def change
    remove_column :boats, :skiper_last_name
    add_column :boats, :skipper_last_name, :string
  end
end
