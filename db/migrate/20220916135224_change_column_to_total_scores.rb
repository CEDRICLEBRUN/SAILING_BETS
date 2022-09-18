class ChangeColumnToTotalScores < ActiveRecord::Migration[7.0]
  def change
    change_column :total_scores, :ultim, :integer, default: 0
    change_column :total_scores, :imoca, :integer, default: 0
    change_column :total_scores, :ocean_fifty, :integer, default: 0
    change_column :total_scores, :class_fourty, :integer, default: 0
    change_column :total_scores, :rhum_mono, :integer, default: 0
    change_column :total_scores, :rhum_multi, :integer, default: 0
  end
end
