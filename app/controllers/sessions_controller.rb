class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Hello."
        redirect_to "/posts"
      else
        flash["notice"] = "Wrong Email or Password."
        redirect_to "/login"
      end
    else
      flash["notice"] = "Wrong Email or Password."
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "See you later."
    redirect_to "/login"
  end
end