class AddTestcaseToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :input, :text,  limit: 16777215
    add_column :problems, :output, :text, limit: 16777215
  end
end
