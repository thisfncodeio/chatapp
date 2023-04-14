class User < ApplicationRecord
  has_many :messages
  validates_uniqueness_of :username
  scope :all_except, ->(user) { where.not(id: user) }

  # Ask our models to broadcast any newly added instance to a particular channel
  # Here, we are asking the User model to broadcast to a channel called `"users"` after every new instance of a user is created.
  after_create_commit { broadcast_append_to "users" } # What is `"users"`??
end
