class SessionsController < ApplicationController
  def new; end
  
  def create
    # require 'pry'; binding.pry
    user = User.find_by(username: params[:session][:username]) # Does `params` have a session hash??

    if user
      log_in(user)
    else
      render "new"
    end
  end

  def destroy
    # Self-explanatory
    log_out if logged_in?
    redirect_to root_path
  end
end