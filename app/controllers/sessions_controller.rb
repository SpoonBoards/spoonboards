class SessionsController < ApplicationController
  before_action :authenticate, except: [:new, :create]



  def create
    if request.post?
      user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to boards_path(user), notice: "Signed in!"
      # else
      #   flash[:notice] = 'unvalid email/password combination'
      #   redirect_to login_path
      end
    elsif user = User.sign_in_from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to boards_path(user), notice: "Signed in!"
    else
      flash[:notice] = 'Invalid email/password combination'
      redirect_to login_path
    end
    redirect_to login_path
  end

  def new
  end

  def destroy
    session[:user_id] = nil
    session[:omniauth] = nil
    redirect_to root_path, notice: "You have logged out."
  end



end
