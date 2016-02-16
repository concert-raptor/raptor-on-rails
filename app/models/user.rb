class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

  validates_presence_of :email

end
