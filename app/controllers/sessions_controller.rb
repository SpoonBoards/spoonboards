class SessionsController < ApplicationController
  before_action :set_user, only: [:edit, :update, :delete]
  before_action :authenticate, except: [:new, :create]

  def new
    @user = User.new
  end

  def show
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to users_path, notice: "You have successfully logged in!"
    else
      flash[:alert] = "Login failed: invalid email or password."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have logged out."
  end
end
