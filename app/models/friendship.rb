class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  def to_s
    "id:#{self.id} "\
    "user_id:#{self.user_id} friend_id:#{self.friend_id} "\
      "created_at:#{self.created_at} updated_at:#{self.updated_at}"
  end
end
