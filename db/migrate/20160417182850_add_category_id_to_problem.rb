class AddCategoryIdToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :category_id, :integer
  end
end
