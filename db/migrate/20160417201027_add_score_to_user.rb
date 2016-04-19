class AddScoreToUser < ActiveRecord::Migration
  def change
    add_column :users, :pc_score, :integer
    add_column :users, :ctf_score, :integer
    add_column :users, :ai_score, :integer
    add_column :users, :total_score, :integer
  end
end
