class User < ApplicationRecord
  has_secure_password
  enum userType: [:jobseeker, :employer]
end