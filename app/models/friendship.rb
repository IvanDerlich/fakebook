class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"
  validate :false_but_not_nil, :not_to_yourself, :already_sent, :already_received

  def false_but_not_nil    
    errors.add :confirmed, 'confirmed cannot be nil' if confirmed.nil?    
  end

  def not_to_yourself    
    errors.add(:not_to_itself, 'You cannot send friend requests to yourself') if self.user == self.friend 
  end

  def already_received
    errors.add(:already_received, 'You have already received a friend request from that user') if false #user.received_friendships.include?(self)
  end

  def already_sent    
    errors.add(:already_sent, 'You have already sent a friend request to that user') if false# if user.sent_friendships.include?(self)    
  end
 
end
