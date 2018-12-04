class ChatUser < ApplicationRecord
  def to_s
    "id:#{self.id} "\
      "user_id:#{self.user_id} chat_id:#{self.chat_id} "\
      "created_at:#{self.created_at} updated_at:#{self.updated_at}"
  end
end
