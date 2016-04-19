class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :user_id
      t.integer :problem_id
      t.integer :value

      t.timestamps null: false
    end
  end
end
