class Job < ApplicationRecord
  # User has many jobs
  has_many :applications
end
