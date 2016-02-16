class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.text :description
      t.belongs_to :address, index: true
      t.timestamps
    end
  end
end
