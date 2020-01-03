# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes
  validates :text, :user_id, presence: true
  validates :text, length: { in: 5..300 }
end
