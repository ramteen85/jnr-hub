class User < ApplicationRecord
  has_secure_password
  enum user_type: [:jobseeker, :employer]
  validates_uniqueness_of :email
  has_many :jobs
end
