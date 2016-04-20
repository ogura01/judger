class ScoresController < ApplicationController
  def index
    @users = User.where(is_super: nil)
  end
end
