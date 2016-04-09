class SessionsController < ApplicationController
  before_action :set_user, only: [:edit, :update, :delete]
  before_action :authenticate, except: [:new, :create]

  def new
  end

  def show
  end

  def create
    if user = User.find_by_email(params[:email]) && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to boards_path(user), notice: "Signed in!"

    #  user = User.sign_in_from_omniauth(request.env["omniauth.auth"])
    #   session[:user_id] = user.id
    #   redirect_to boards_path, notice: "Signed in!"

    else
      flash.now[:alert] = "Login failed: invalid email or password."
      render root_path
    end
  end

  def omniauth
     user = User.sign_in_from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to boards_path, notice: "Signed in!"

      # auth = request.env["omniauth.auth"]
      # user = User.find_by_provider_and_uid(auth["pinterest"], auth["uid"]) || User.create_with_omniauth(auth)
      # session[:user_id] = user.id
      # redirect_to boards_path, :notice => "Signed in!"
    end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have logged out."
  end

end
