class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  validates :first_name, :last_name, :email, presence: true
  validates_inclusion_of :admin, :in => [true, false]

  has_many :bookings, dependent: :delete_all
  
end
