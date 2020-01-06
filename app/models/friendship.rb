class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => "User"
  validate :false_but_not_nil

  def false_but_not_nil
    if confirmed.nil?
      errors.add :confirmed, 'confirmed cannot be nil'
    end
  end
end
