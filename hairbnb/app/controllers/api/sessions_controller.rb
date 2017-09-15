class Api::SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user
      login!(@user)
      render :root
    else
      render json: ["Invalid credentials"]
    end

  end

  def destroy
    if current_user
      logout!
      render {}
    else
      render json: ['Not logged in'], status: 404
    end
  end
end
