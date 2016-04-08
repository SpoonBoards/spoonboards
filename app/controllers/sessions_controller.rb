class SessionsController < ApplicationController
  # before_action :set_user, only: [:edit, :update, :delete]
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
      redirect_to users_path, notice: "Signed in!"
    else
      flash[:alert] = "Login failed: invalid email or password."
      render "new"
    end
  end

  def omniauth
      auth = request.env["omniauth.auth"]
      user = User.find_by_provider_and_uid(auth["pinterest"], auth["uid"]) || User.create_with_omniauth(auth)
      session[:user_id] = user.id
      redirect_to boards_path, :notice => "Signed in!"
    end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have logged out."
  end
end
