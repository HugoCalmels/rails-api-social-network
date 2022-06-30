class Invitation < ApplicationRecord
  after_create :seen
  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :receiver, :class_name => 'User', :foreign_key => 'receiver_id'
  #belongs_to :receiver

  def confirmed
    self[:confirmed] = false
  end
  def seen
    self[:confirmed] = false
  end
end
