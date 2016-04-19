class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :problem_id
      t.text :output
      t.integer :score

      t.timestamps null: false
    end
  end
end
