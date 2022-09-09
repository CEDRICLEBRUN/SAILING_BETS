class CreateTotalScores < ActiveRecord::Migration[7.0]
  def change
    create_table :total_scores do |t|
      t.integer :ultim
      t.integer :imoca
      t.integer :ocean_fifty
      t.integer :class_fourty
      t.integer :rhum_mono
      t.integer :rhum_multi
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
