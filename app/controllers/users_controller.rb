class UsersController < ApplicationController

  before_action :auth_user, only: [:show] 

  def show
    @user = User.find(current_user) 
    @favorites = @user.favorites
  end

private
  
  def auth_user
    if !user_signed_in?
      redirect_to root_path
      flash[:alert] = "You need to be signed in to access 'My Bills'."
    end 
  end 

end
