class Venue < ActiveRecord::Base
  belongs_to :address

  def name_and_description
    "name: #{self.name}, " +
    "description: #{self.description}"
  end

end
