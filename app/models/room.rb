class Room < ApplicationRecord
  has_many :messages
  has_many :participants, dependent: :destroy

  validates_uniqueness_of :name
  scope :public_rooms, -> { where(is_private: false) }

  # Ask our models to broadcast any newly added instance to a particular channel
  # Here, we are asking the Room model to broadcast to a channel called `"rooms"` after every new instance of a user is created.
  # after_create_commit { broadcast_append_to "rooms" }
  after_create_commit { broadcast_if_public }

  def broadcast_if_public
    broadcast_append_to "rooms" unless self.is_private
  end

  def self.create_private_room(users, room_name)
    single_room = Room.create(name: room_name, is_private: true)
    users.each do |user|
      Participant.create(user_id: user.id, room_id: single_room.id )
    end
    single_room
  end
end
