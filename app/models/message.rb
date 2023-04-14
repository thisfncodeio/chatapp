class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  before_create :confirm_participant

  after_create_commit { broadcast_append_to self.room } # This will append the message to the id of the room for which that message was created

  def confirm_participant
    if self.room.is_private
      is_participant = Participant.where(user_id: self.user.id, room_id: self.room.id).first
      throw :abort unless is_participant
    end
  end
end
