class Category < ActiveRecord::Base
  has_one :problem
end
