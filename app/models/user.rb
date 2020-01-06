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
  
  def confirmed_friends
    confirmed_friends_array = sent_friendships.map{|friendship| 
      friendship.friend if friendship.confirmed
    }
    confirmed_friends_array + received_friendships.map{|friendship| 
      friendship.user if friendship.confirmed
    }
    confirmed_friends_array.compact
  end

  def confirmed_sent_and_received_friendships
    confirmed_friendships_array = sent_friendships.map{|friendship| 
      friendship if friendship.confirmed
    }
    confirmed_friendships_array + received_friendships.map{|friendship| 
      friendship if friendship.confirmed
    }
    confirmed_friendships_array.compact
  end

  def unconfirmed_sent_and_received_friendships
    unconfirmed_friendships_array = sent_friendships.map{|friendship| 
      friendship.friend unless friendship.confirmed
    }
    unconfirmed_friendships_array + received_friendships.map{|friendship| 
      friendship.user unless friendship.confirmed
    }
    unconfirmed_friendships_array.compact
  end

  def unconfirmed_sent_friendships
    sent_friendships.map{|friendship| 
      friendship.friend unless friendship.confirmed
    }.compact    
  end

  def unconfirmed_received_friendships
    received_friendships.map{|friendship|
       friendship.user unless friendship.confirmed
    }.compact
  end
  
  def confirms_friendship(friendship)
  #def confirms_friendship(user)
    #friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.confirmed = true
    friendship.save
  end

  def request_friendship(receiver)
    sent_friendships.create!(
      friend: receiver
    )
  end

  #checks if a user is a friend or not
  def friend?(user)
    friends.include?(user)
  end    
end
