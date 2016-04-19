class AddTestcaseToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :input, :text
    add_column :problems, :output, :text
  end
end
