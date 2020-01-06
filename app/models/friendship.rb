class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"
  validate :false_but_not_nil

  def false_but_not_nil
    if confirmed.nil?
      errors.add :confirmed, 'confirmed cannot be nil'
    end
  end
<<<<<<< HEAD
=======

  def accept
    confirmed.toggle
  end


>>>>>>> cbe2664f8cae024f8aadb4c95ad22800cdf37b00
end
