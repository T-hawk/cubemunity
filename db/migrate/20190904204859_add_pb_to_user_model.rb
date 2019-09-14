class AddPbToUserModel < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :person_best, :string
  end
end
