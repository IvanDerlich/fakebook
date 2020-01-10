# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, :email, :phone_number, presence: true
  validates :first_name, length: { minimum: 2 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_many :posts
  has_many :comments
  has_many :likes
  has_many :sent_friendships , :class_name => "Friendship", :foreign_key => "sender_id"
  has_many :received_friendships, :class_name => "Friendship", :foreign_key => "receiver_id"


  def comments_post(post, text)
    comments.create!(
      post: post,
      text: text
    )
  end

  def likes_post(post)
    likes.create!(
      post: post
    )
  end

  def confirms_friendship(user)
    friendship = received_friendships.find do |friendship| 
      friendship.user == user &&
      friendship.confirmed == false
    end    
    #<comment> this funtion returns false in two scenarios
    # 1 - receiver hasn't received the request
    # 2 - or receiver is the one that has send the request  
    # Improvement opportunity: we can create more rich error message
    #</comment> 
    friendship.confirmed = true
    friendship.save
  end

  def requests_friendship(receiver)
    Friendship.create!(
      friend: receiver,
      user: self      
    )
    # <comment> I had to abandon this way of doing it because rspec was making tests fails
    # sent_friendships.create!(
    #   friend: receiver
    # )
    # </comment>
  end 

  def friend?(user)
    friends.include?(user)
  end 
  
  def friends
    friends_array = sent_friendships.   
    map{|friendship| 
      friendship.receiver if friendship.confirmed
    }
    friends_array += received_friendships.map{|friendship| 
      friendship.sender if friendship.confirmed
    }    
    friends_array.compact
  end

  def requests_sent
    sent_friendships.   
    map{|friendship| 
      friendship.receiver unless friendship.confirmed
    }.compact    
  end   

  def requests_received
    received_friendships.map{|friendship| 
      friendship.sender unless friendship.confirmed
    }.compact
  end  
   
end
