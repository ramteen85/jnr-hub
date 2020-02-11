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
  has_many :applications   # which applications have i applied for? (jobseekers)
  has_many :jobs           # which jobs have i created? (as an employer)

  # User has many they have applied for (if they're a jobseeker)
  # But we want to give this through association a unique name, distinct from 'jobs'
  # which is used above to get the jobs an employer has created
  has_many :jobs_applied_for, through: :applications, source: :job
end
