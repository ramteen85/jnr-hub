class User < ApplicationRecord
  has_secure_password
  enum user_type: [:jobseeker, :employer]
end
