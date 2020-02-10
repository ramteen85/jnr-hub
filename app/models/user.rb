class User < ApplicationRecord
  # User must have a hashed password
  has_secure_password
  # User can be a jobseeker or an employer
  enum user_type: [:jobseeker, :employer]
  # User must have unique email
  validates_uniqueness_of :email
  # Name can't be blank
  validates :full_name, presence: true
  # User has many applications
  has_many :applications 
  # User has many jobs
  has_many :jobs, through: :applications
end
