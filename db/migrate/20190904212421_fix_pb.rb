class FixPb < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :person_best, :personal_best
  end
end
