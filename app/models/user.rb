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
  has_many :sent_friendships , :class_name => "Friendship", :foreign_key => "user_id"
  has_many :received_friendships, :class_name => "Friendship", :foreign_key => "friend_id"


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

  def confirms_friendship(friendship)
    friendship.confirmed = true
    friendship.save
  end

  def confirms_friendship_user(user)
    friendship = received_friendships.find do |friendship| 
      friendship.user == user
    end    
    #<comment> this funtion returns false in two scenarios
    # 1 - receiver hasn't received the request
    # 2 - or receiver is the one that has send the request    
    return false unless friendship 
    #</comment> 
    friendship.confirmed = true
    friendship.save
  end

  def requests_friendship(receiver)
    sent_friendships.create!(
      friend: receiver
    )
  end 

  def friend?(user)
    friends.include?(user)
  end 
  
  def friends
    friends_array = sent_friendships.
    # <comment> see docs/bugs/bug1
    map{|f| f.id}.
    map{|id| Friendship.find(id)}.
    # </comment>
    map{|friendship| 
      friendship.friend if friendship.confirmed
    }
    friends_array += received_friendships.map{|friendship| 
      friendship.user if friendship.confirmed
    }    
    friends_array.compact
  end

  def requests_sent_users
    sent_friendships.
    # <comment> see docs/bugs/bug1
    map{|f| f.id}.
    map{|id| Friendship.find(id)}.
    # </comment>
    map{|friendship| 
      friendship.friend unless friendship.confirmed
    }.compact    
  end 

  # def requests_sent
  #   sent_friendships.map{|friendship| 
  #     friendship unless friendship.confirmed
  #   }.compact    
  # end 

  def requests_received_users
    received_friendships.map{|friendship| 
      friendship.user unless friendship.confirmed
    }.compact
  end  
   
end
