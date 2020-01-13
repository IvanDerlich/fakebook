class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"
  validates :user_id, :friend_id, presence: true
  validate :false_but_not_nil 
  validate :not_to_yourself, :already_sent, :already_received, :on => :create


  private 

  def false_but_not_nil        
    errors.add :confirmed, 'confirmed cannot be nil' if confirmed.nil?    
  end

  def not_to_yourself    
    if self.user == self.friend 
      errors.add(:not_to_itself, '# You cannot send friend requests to yourself') 
    end
  end

  def already_received    
    if Friendship.exists?(user_id: friend_id, friend_id: user_id )
      errors.add(:already_received, '# You have already received a friend request from that user')
    end
  end

  def already_sent 
    if Friendship.exists?(user_id: user_id, friend_id: friend_id )
      errors.add(:already_sent, '# You have already sent a friend request to that user')
    end      
  end
 
end
