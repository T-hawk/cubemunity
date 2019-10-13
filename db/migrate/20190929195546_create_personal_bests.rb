class CreatePersonalBests < ActiveRecord::Migration[5.2]
  def change
    create_table :personal_bests do |t|
      t.string :two_by_two
      t.string :three_by_three
      t.string :four_by_four
      t.string :five_by_five
      t.string :six_by_six
      t.string :seven_by_seven
      t.string :megaminx
      t.string :pyraminx
      t.string :skewb
      t.string :clock
      t.timestamps
    end
  end
end
