class User < ActiveRecord::Base
  has_many :bookings
  belongs_to :user
  has_many :rooms
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]
         belongs_to :role
         before_create :assign_role
         def role?(role)
         	self.role.name == role
         end

        
         def assign_role
         	self.role_id = Role.last.id
         end
end
