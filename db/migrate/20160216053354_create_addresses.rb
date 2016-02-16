class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address_one
      t.string :address_two
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
