class AddUserIdToPersonalBestsAndDeletePersonalBestFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :personal_best
    add_column :personal_bests, :user_id, :integer
  end
end
