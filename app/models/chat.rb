class Chat < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :messages, :dependent => :destroy
  def to_s
    "id:#{self.id} "\
      "name:#{self.name} description:#{self.description} "\
      "admin_id:#{self.admin_id} "\
      "created_at:#{self.created_at} updated_at:#{self.updated_at}"
  end
end
