class User < ApplicationRecord
  has_secure_password
  enum user_type: [:jobseeker, :employer]
  validates_uniqueness_of :email
  validates :full_name, presence: true  # name can't be blank

  has_many :jobs
end
