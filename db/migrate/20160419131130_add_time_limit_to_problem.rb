class AddTimeLimitToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :open_time, :datetime
    add_column :problems, :close_time, :datetime
  end
end
