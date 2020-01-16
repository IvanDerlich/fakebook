class AddMirrorColumnInFriendshipTable < ActiveRecord::Migration[6.0]
  def change
    add_column :friendships, :mirror, :boolean
    change_column_default :friendships, :mirror, false
  end
end
