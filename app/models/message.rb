class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  sync :all
  sync_scope :by_chat, ->(chat) { where(chat_id: chat.id) }

  def to_s
    "id:#{self.id} "\
      "user_id:#{self.user_id} chat_id:#{self.chat_id} "\
      "body:#{self.body} "\
      "created_at:#{self.created_at} updated_at:#{self.updated_at}"
  end
end
