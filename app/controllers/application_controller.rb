class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    # Memoizing the current logged in user
    @current_user  = User.find(session[:user_id]) if session[:user_id]
  end

  def log_in(user)
    # Set the session `:user_id` to the current found user ( User.find_by(username: params[:session][:username]) )
    session[:user_id] = user.id
    @current_user = user # `user` is being passed in from the SessionsController `create` action
    redirect_to root_path
  end

  def logged_in?
    # If there is a `current_user` there someone is logged in
    !current_user.nil?
  end

  def log_out
    # Remove the `:user_id` key from the session hash
    # Clear the `current_user` variable (this is probably because there will be no page refreshing??)
    session.delete(:user_id)
    @current_user = nil
  end
end
