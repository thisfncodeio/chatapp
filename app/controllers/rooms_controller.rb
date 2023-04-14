class RoomsController < ApplicationController
  def index
    @current_user = current_user # `current_user` coming from the method defined in ApplicationController
    redirect_to "/signin" unless @current_user # self-explanatory

    @rooms = Room.public_rooms # user scope method
    @users = User.all_except(@current_user) # using scope method

    @room = Room.new # Used in _new_room_form.html.erb file
  end

  def create
    @room = Room.create(name: params[:room][:name])
  end

  def show
    # This gives us the particular room being routed to
    @single_room = Room.find(params[:id])

    @message = Message.new
    @messages = @single_room.messages
    
    # Same info as the RoomsController#index action
    @current_user = current_user
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    @room = Room.new

    # Rendering the RoomsController#index action
    # Because we now have 2 actions routing to the same page, we will need to use some conditional rendering
    render "index"
  end
end