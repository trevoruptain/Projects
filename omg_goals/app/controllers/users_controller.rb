class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      redirect_to users_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def index
    @user = current_user
    if @user
      render :index
    else
      redirect_to new_session_url
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :username)
  end
end
