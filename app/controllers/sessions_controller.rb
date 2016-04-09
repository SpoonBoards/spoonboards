class SessionsController < ApplicationController

  before_action :authenticate, except: [:new, :create]

  def new
  end

  def show
  end

  def create
    user = User.find_by_email(params[:email])
    if user.blank? == false && user == user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to boards_path(user), notice: "Signed in!"

    elsif user.blank? == true && params[:email].blank? == false || user.blank? == false && user.authenticate(params[:password]) == false || user.blank? == true && params[:email].blank? == false && params[:password].blank? == true
      redirect_to login_path, notice: "Login failed: invalid email or password."

    else user = User.sign_in_from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to boards_path, notice: "Signed in!"
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
