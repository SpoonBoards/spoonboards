class SessionsController < ApplicationController
  # before_action :set_user, only: [:edit, :update, :delete]
  before_action :authenticate, except: [:new, :create]

  def new
  end

  def show
  end

  def create
    if request.post?
    user = User.find_by_email(params[:email])

      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to boards_path(user), notice: "You have successfully logged in!"
      end

    elsif
      user = User.sign_in_from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to boards_path, notice: "SIGNED IN"
    else
      flash.now[:alert] = "Login failed: invalid email or password."
      render root_path
    end
  end

  def destroy
    session[:user_id] = nil
    session[:omniauth] = nil
    redirect_to root_path, notice: "You have logged out."
  end

end
