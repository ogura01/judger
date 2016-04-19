class Problem < ActiveRecord::Base
  belongs_to :category
  has_many   :submissions
  has_many   :scores

  def first_step?
    category && category.title != 'AI Battle'
  end

  def last_step?
    category && category.title == 'AI Battle'
  end
end
